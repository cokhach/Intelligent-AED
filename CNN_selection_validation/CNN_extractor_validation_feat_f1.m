close all; clc; clear;
window = '8s';
method = {'SVM','KNN','RF','BG','BS','LR'}; 
NSec = [1 3 2 4];

% Data collection
[trdata,trlabel,tedata,telabel,tr_rec_id,te_rec_id,tr_label,te_label] = ...
    data_colection(window);

% CNN Feature extraction and validation
  path_res = 'S:/public_codes/CNN_selection_validation/CNN_vailation_features/';
  filename = {'CNN_validation_features'};
for j = 1:length(method)
    ML = method{j};  
  for i = 1:length(NSec)  
    NS = NSec(i);  
    [SVM_metrics,RF_metrics,BG_metrics,BS_metrics,KNN_metrics,LR_metrics] =...
        ML_validation(window,NS,ML,trdata,trlabel,tedata,te_label,te_rec_id); 
    file_save = sprintf('%s%s_%s_%s_%d_100',path_res,filename{1},ML,window,NS);
    save(file_save,'SVM_metrics','RF_metrics','BG_metrics','BS_metrics','KNN_metrics','LR_metrics');
  end  
end  
toc
 function [trdata,trlabel,tedata,telabel,tr_rec_id,te_rec_id,tr_label,...
    te_label] = data_colection(window)
    data = ['S:/public_codes/data/' 'dataCNN73_8s'] %#ok<NOPRT>
load(data);
tr_rec_id = data.rec_id_tr; te_rec_id = data.rec_id_te;
ECGdim = 1; segment_length = size(data.ECGtr,2);
teECG = data.ECGte.'; teNSH_ECG = data.NSH_ECGte.'; teSH_ECG = data.SH_ECGte.';

trECG = data.ECGtr.'; trNSH_ECG = data.NSH_ECGtr.'; trSH_ECG = data.SH_ECGtr.';
trECG = reshape(trECG,segment_length,ECGdim,1,[]);
trNSH_ECG = reshape(trNSH_ECG,segment_length,ECGdim,1,[]);
trSH_ECG = reshape(trSH_ECG,segment_length,ECGdim,1,[]);
trdata = trECG; trdata(:,:,2,:) = trNSH_ECG; trdata(:,:,3,:) = trSH_ECG; 
tr_label = data.labeltr;
trlabel = categorical(tr_label);

teECG = reshape(teECG,segment_length,ECGdim,1,[]);                
teNSH_ECG = reshape(teNSH_ECG,segment_length,ECGdim,1,[]);
teSH_ECG = reshape(teSH_ECG,segment_length,ECGdim,1,[]);
tedata = teECG; tedata(:,:,2,:) = teNSH_ECG; tedata(:,:,3,:) = teSH_ECG; 
te_label = data.labelte;
telabel = categorical(te_label);
end

function [SVM_metrics,RF_metrics,BG_metrics,BS_metrics,KNN_metrics,LR_metrics] = ...
    ML_validation(window,NS,method,trdata,trlabel,tedata,te_label,te_rec_id)
%{
For the 8s-segment database
    best CNN-SVM extractor: CNN_extractor_SVM_8s_1
    best CNN-KNN extractor: CNN_extractor_KNN_5s_1
    best CNN_RF extractor: CNN_extractor_RF_5s_3
%}

addpath('S:/public_codes/CNN_selection_validation/CNNs_extractors/');

CNN_extractor_file = sprintf('CNN_extractor_%s_%s_%d',method,window,NS);
load(CNN_extractor_file); %#ok<LOAD>
layers = bestNet; options = bestOpt;

% Training the selected CNN-extractor model 
net = trainNetwork(trdata,trlabel,layers,options);
feat_layer = 'fc_1';
    
% Feature extraction with pre-trained CNN extractor on testing data
f_vector = activations(net,tedata,feat_layer,'MiniBatchSize',100,'OutputAs','rows');
feat_vector = double(f_vector);

% Scaling the data  
mini = min(feat_vector, [], 1);
rang = max(feat_vector, [], 1) - mini;
feature_vector = (feat_vector - repmat(mini, size(feat_vector, 1), 1)) ./ repmat(rang, size(feat_vector, 1), 1); 

% Tuning parameters for the ML classsifiers
SVM_para = parameter_selection(feature_vector,te_label,te_rec_id,'SVM');
RF_para = parameter_selection(feature_vector,te_label,te_rec_id,'RF');
BG_para = parameter_selection(feature_vector,te_label,te_rec_id,'BG');
BS_para = parameter_selection(feature_vector,te_label,te_rec_id,'BS');    
KNN_para = parameter_selection(feature_vector,te_label,te_rec_id,'KNN'); 

% Dividing data for cross validation
num_record = size(te_rec_id, 1);
num_folds = 5;
num_labels = size(te_label, 1); 

% Cross validation repetitions 
for repeat=1:100
    sprintf('loop #: %d',repeat)
rng('shuffle', 'twister');
 perm = randperm(num_record)';  
 start_record = 1;
  for k = 1:num_folds
     end_record = floor(num_record*k/num_folds);
     selected_record = sort(perm(start_record:end_record));
     num_observation_of_record = [1; cumsum(te_rec_id)+1];
     t_record = [];
     for t=1:size(selected_record,1)
       t_record = [t_record; [num_observation_of_record(selected_record(t))...
           :num_observation_of_record(selected_record(t)+1)-1]']; 
     end
     t_folds{k} = t_record; 
     start_record = end_record+1;    
  end
    
 for l=1:num_folds
  % training data
    tr_record = setdiff((1:num_labels)', t_folds{l});
    tr_data = feature_vector(tr_record,:);
    tr_nhan = te_label(tr_record,1);
  % testing data    
    t_data = feature_vector(t_folds{l},:); 
    t_nhan = te_label(t_folds{l},1);
 
   if any(t_nhan(:)==0) && any(t_nhan(:)==1) 
  % 1) SVM 
     lib_opt = [' -s 0 -t 2 -h 0 -c ' num2str(2^SVM_para.SVM.logC)...
         ' -g ' num2str(2^SVM_para.SVM.logG)];         
     SVM_model = svmtrain(tr_nhan, tr_data, ['-q ' lib_opt]); %#ok<SVMTRAIN>
     [t_pred, ~, t_dec] = svmpredict(t_nhan, t_data, SVM_model, '-q');
     t_dec = t_dec * (2 * SVM_model.Label(1) - 1);
     SVM_stats(l,:) = ML_performance(t_pred,t_nhan,0);  %#ok<AGROW>
    
  % 2) Logistic regression
     LR_model =glmfit(tr_data,tr_nhan,'binomial','link','logit');
     yfit = glmval(LR_model,t_data,'logit');
     t_pred = yfit>0.5; t_dec = yfit;
     LR_stats(l,:) = ML_performance(t_pred,t_nhan,0);  %#ok<AGROW>
     
  % 3) Random forest              
     RF_tree = TreeBagger(RF_para.RF.num_tree,tr_data,tr_nhan,'Method',...
         'classification','minleaf', RF_para.RF.num_leaf,'prior', [0.7 0.3]);
     [t_pred_class, t_score] = RF_tree.predict(t_data);
     t_dec = t_score(:,2);
    % convert to double
     S = sprintf('%s*', t_pred_class{:});
     t_pred = sscanf(S, '%f*');       
     RF_stats(l,:) = ML_performance(t_pred,t_nhan,0);  %#ok<AGROW>
     
  % 4) Bagging tree
     BG_tree = TreeBagger(BG_para.BG.num_tree,tr_data,tr_nhan,'Method',...
         'classification','minleaf', BG_para.BG.num_leaf,'NvarToSample',...
         'all','prior', [0.7 0.3]);
     [t_pred_class, t_score] = BG_tree.predict(t_data);
     t_dec = t_score(:,2);
     % convert to double
     S = sprintf('%s*', t_pred_class{:});
     t_pred = sscanf(S, '%f*');
     BG_stats(l,:) = ML_performance(t_pred,t_nhan,0);  %#ok<AGROW>
  
  % 5) Boosting tree  
     tree  = templateTree('Minleaf',BS_para.BS.leaf);
     BS_model = fitensemble(tr_data,tr_nhan,'LogitBoost',BS_para.BS.iter,tree,...
        'LearnRate',BS_para.BS.LR,'type','classification');
     [t_pred, t_score] = predict(BS_model,t_data);
     t_dec = t_score(:,1);              
     BS_stats(l,:) = ML_performance(t_pred,t_nhan,0);     %#ok<AGROW>
   
  % 6) K nearest neighbours
     KNN_model = fitcknn(tr_data,tr_nhan,'NSMethod','exhaustive','Distance','euclidean');
     KNN_model.NumNeighbors= KNN_para.KNN.neighbor;    
     t_pred = predict(KNN_model,t_data);
     [~,KNNscore] = resubPredict(KNN_model);
     t_dec = KNNscore(:,1);
     KNN_stats(l,:) = ML_performance(t_pred,t_nhan,0); %#ok<AGROW>  
  end
 end 
  stats_SVM(repeat,:) = mean(SVM_stats);
  stats_LR(repeat,:) = mean(LR_stats); 
  stats_RF(repeat,:) = mean(RF_stats); 
  stats_BG(repeat,:) = mean(BG_stats);  
  stats_BS(repeat,:) = mean(BS_stats); 
  stats_KNN(repeat,:) = mean(KNN_stats);  
end  
SVM_metrics.mean = mean(stats_SVM); 
SVM_metrics.std = std(stats_SVM);
SVM_metrics.stats = stats_SVM;
LR_metrics.mean = mean(stats_LR); LR_metrics.std = std(stats_LR);
LR_metrics.stats = stats_LR;
RF_metrics.mean = mean(stats_RF); RF_metrics.std = std(stats_RF);
RF_metrics.stats = stats_RF;
BG_metrics.mean = mean(stats_BG); BG_metrics.std = std(stats_BG);
BG_metrics.stats = stats_BG;
BS_metrics.mean = mean(stats_BS); BS_metrics.std = std(stats_BS);
BS_metrics.stats = stats_BS;
KNN_metrics.mean = mean(stats_KNN); KNN_metrics.std = std(stats_KNN);
KNN_metrics.stats = stats_KNN;
end

function stats_vector = ML_performance(labels,scores,value)
fv = find(scores == 1);tp = sum(labels(fv)==1);
fn = sum(labels(fv)==value);pc = tp + fn;
rs = find(scores == value);tn = sum(labels(rs)==value);
fp = sum(labels(rs)==1);nc = tn + fp;
stats.ac = (tp + tn) / (pc + nc) * 100; 
stats.se = tp/(tp+fn) * 100; 
stats.sp = tn/(tn+fp) * 100;
stats.ber = 0.5* (fn/pc + fp/nc ) * 100 ;  
stats_vector = [stats.ac,stats.se,stats.sp,stats.ber];
end
