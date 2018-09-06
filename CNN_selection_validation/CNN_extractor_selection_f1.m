close all; clc; clear;
tic
 window = '8s';
 method = {'SVM','RF','KNN'}; 
 NSec = [1 3 2 4];
  
% Data collection
  [trdata,trlabel,tedata,telabel,tr_rec_id,te_rec_id,tr_label,te_label,...
      segment_length] = data_colection(window);
% CNN extractor selection and saving
  path_res = '../CNN_selection_validation/CNNs_extractors/';
  filename = {'CNN_extractor'}; 
for j=1:length(method)
  ML = method{j};  
  for i=1:length(NSec)   
   [trainedNet,ber,bestNet,bestOpt] = CNN_extractor(trdata,trlabel,...
       tr_label,tr_rec_id,segment_length,method{j},NSec(i));
   file_save = sprintf('%s%s_%s_%s_%d',path_res,filename{1},method{j},window,NSec(i));   
   save(file_save,'trainedNet','ber','bestNet','bestOpt','ML');
  end
end 
toc

function [trdata,trlabel,tedata,telabel,tr_rec_id,te_rec_id,tr_label,...
    te_label,segment_length] = data_colection(window)
       data = ['S:/public_codes/data/' 'dataCNN73_8s'] %#ok<NOPRT>
load(data); 
tr_rec_id = data.rec_id_tr; te_rec_id = data.rec_id_te;
ECGdim = 1; segment_length = size(data.ECGtr,2);
teECG = data.ECGte.'; teNSH_ECG = data.NSH_ECGte.'; teSH_ECG = data.SH_ECGte.';

trECG = data.ECGtr.'; trNSH_ECG = data.NSH_ECGtr.'; trSH_ECG = data.SH_ECGtr.';
trECG = reshape(trECG,segment_length,ECGdim,1,[]);
trNSH_ECG = reshape(trNSH_ECG,segment_length,ECGdim,1,[]);
trSH_ECG = reshape(trSH_ECG,segment_length,ECGdim,1,[]);
trdata = trECG; trdata(:,:,2,:) = trNSH_ECG;trdata(:,:,3,:) = trSH_ECG; 
tr_label = data.labeltr;
trlabel = categorical(tr_label);

teECG = reshape(teECG,segment_length,ECGdim,1,[]);                
teNSH_ECG = reshape(teNSH_ECG,segment_length,ECGdim,1,[]);
teSH_ECG = reshape(teSH_ECG,segment_length,ECGdim,1,[]);
tedata = teECG; tedata(:,:,2,:) = teNSH_ECG; tedata(:,:,3,:) = teSH_ECG; 
te_label = data.labelte;
telabel = categorical(te_label);
end

function [trainedNet,ber,bestNet,bestOpt] = CNN_extractor(trdata,trlabel,...
    tr_label,tr_rec_id,SL,method,NetSection)

rng('shuffle','twister');        
num_folds = 5;
num_labels = size(trlabel, 1);
num_record = size(tr_rec_id, 1);
  perm = randperm(num_record)';    
  start_record = 1;
    for i = 1:num_folds
       end_record = floor(num_record*i/num_folds);
       selected_record = sort(perm(start_record:end_record));
       num_observation_of_record = [1; cumsum(tr_rec_id)+1];
       t_record = [];
      for j=1:size(selected_record,1)
         t_record = [t_record;[num_observation_of_record(selected_record(j))...
             :num_observation_of_record(selected_record(j)+1)-1]']; %#ok<AGROW>
      end
        t_folds{i} = t_record; 
        t_id_record{i} = selected_record;  
        start_record = end_record + 1;
    end

NetDepth = [1 2 3];
L2Regulation = [0.1 0.15 0.2];
LearnRate = [0.001 0.005 0.01];
momentum = [0.7 0.8 0.9 0.95];
ber = zeros(length(NetDepth),length(L2Regulation),...
    length(LearnRate),length(momentum));  
loop = 0;

for NetDep = 1:length(NetDepth)
 for L2Regu = 1:length(L2Regulation)
  for LearnR = 1:length(LearnRate)
   for momen = 1:length(momentum)
    options = trainingOptions('sgdm','MaxEpochs',40,'MiniBatchSize',100,...
           'InitialLearnRate',LearnRate(LearnR),'Momentum',momentum(momen),...
           'L2Regularization',L2Regulation(L2Regu));   
    % Layer definition
    ECGsize = [SL 1 3];
    numClasses = numel(unique(trlabel));
    initialNumFilters = 10;%round(50/NetDepth(NetDep));  
    if NetSection == 1
      layers = [imageInputLayer(ECGsize)           
      convBlock([101 1],initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)   
      fullyConnectedLayer(100)
      fullyConnectedLayer(numClasses)
      softmaxLayer
      classificationLayer];
    elseif NetSection == 2
      layers = [imageInputLayer(ECGsize)            
      convBlock([101 1],initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)         
      convBlock([101 1],2*initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)
      fullyConnectedLayer(100)
      fullyConnectedLayer(numClasses)
      softmaxLayer
      classificationLayer];
    elseif NetSection == 3
      layers = [imageInputLayer(ECGsize)            
      convBlock([101 1],initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)         
      convBlock([101 1],2*initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)
      convBlock([101 1],4*initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)
      fullyConnectedLayer(100)
      fullyConnectedLayer(numClasses)
      softmaxLayer
      classificationLayer];    
    elseif NetSection == 4
      layers = [imageInputLayer(ECGsize)            
      convBlock([101 1],initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)         
      convBlock([101 1],2*initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)
      convBlock([101 1],4*initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)
      convBlock([101 1],8*initialNumFilters,NetDepth(NetDep))
      maxPooling2dLayer([11 1],'Stride',2)
      fullyConnectedLayer(100)
      fullyConnectedLayer(numClasses)
      softmaxLayer
      classificationLayer]; 
    end
        loop = loop + 1;
 sprintf('loop: %d',loop)
     
  % 5-fold Cross validation
  for k=1:num_folds
  % training data
    tr_record = setdiff((1:num_labels)', t_folds{k});
    tr_labels = trlabel(tr_record,1); tr_data = trdata(:,:,:,tr_record);
    tr_nhan = tr_label(tr_record,1); 
    train_id_record = setdiff((1:num_record)', t_id_record{k});
    tr_id_record = tr_rec_id(train_id_record,1);
    tr_length = size(tr_nhan,1);
  % testing data    
    t_nhan = tr_label(t_folds{k},1);
    t_data = trdata(:,:,:,t_folds{k}); 
    te_id_record = tr_rec_id(t_id_record{k},1);
    
  % Train the CNN model
    net = trainNetwork(tr_data,tr_labels,layers,options);
    feat_layer = 'fc_1';
    tr_vector = activations(net,tr_data,feat_layer,'MiniBatchSize',100,'OutputAs','rows');
    t_vector = activations(net,t_data,feat_layer,'MiniBatchSize',100,'OutputAs','rows');
    tr_vector = double(tr_vector); t_vector = double(t_vector); 
  
  % Scaling the data
    tune_X = [tr_vector;t_vector];
    mini = min(tune_X, [], 1);
    rang = max(tune_X, [], 1) - mini;
    tuned_data = (tune_X - repmat(mini, size(tune_X, 1), 1)) ./ repmat(rang, size(tune_X, 1), 1);
    tuned_nhan = [tr_nhan;t_nhan]; 
    tuned_record = [tr_id_record;te_id_record];   
  
  if all(isnan(tuned_data(:))) == 0
    if strcmp(method,'SVM')||strcmp(method,'BG')||strcmp(method,'RF')||strcmp(method,'BS')||strcmp(method,'KNN')
       para = parameter_selection(tuned_data,tuned_nhan,tuned_record,method); 
    end    
   
    tr_vec = tuned_data(1:tr_length,:);
    t_vec = tuned_data(tr_length+1:end,:);   

   if any(t_nhan(:)==0) && any(t_nhan(:)==1)  
    switch method
     case 'SVM'   
       lib_opt = [' -s 0 -t 2 -h 0 -c ' num2str(2^para.SVM.logC)...
           ' -g ' num2str(2^para.SVM.logG)];  
       SVM_model = svmtrain(tr_nhan,tr_vec, ['-q ' lib_opt]); %#ok<SVMTRAIN>
       [t_pred, ~, t_dec] = svmpredict(t_nhan, t_vec, SVM_model, '-q');
       t_dec = t_dec * (2 * SVM_model.Label(1) - 1);
       stats(k,:) = ML_performance(t_pred,t_nhan,0);  %#ok<AGROW>
     case 'LR'  
       LR_model =glmfit(tr_vec,tr_nhan,'binomial','link','logit');
       yfit = glmval(LR_model,t_vec,'logit');
       t_pred = yfit>0.5; t_dec = yfit;
       stats(k,:) = ML_performance(t_pred,t_nhan,0);      %#ok<AGROW>
     case 'RF'
       RF_tree = TreeBagger(para.RF.num_tree,tr_vec,tr_nhan,'Method',...
           'classification','minleaf', para.RF.num_leaf,'prior', [0.7 0.3]);
       [t_pred_class, t_score] = RF_tree.predict(t_vec);
       t_dec = t_score(:,2);
       % convert to double
       S = sprintf('%s*', t_pred_class{:});
       t_pred = sscanf(S, '%f*');       
       stats(k,:) = ML_performance(t_pred,t_nhan,0); %#ok<AGROW>
     case 'BG'  
       BG_tree = TreeBagger(para.BG.num_tree,tr_vec,tr_nhan,'Method',...
           'classification','minleaf', para.BG.num_leaf,'NvarToSample',...
           'all','prior', [0.7 0.3]);
       [t_pred_class, t_score] = BG_tree.predict(t_vec);
       t_dec = t_score(:,2);
       % convert to double
       S = sprintf('%s*', t_pred_class{:});
       t_pred = sscanf(S, '%f*');
       stats(k,:) = ML_performance(t_pred,t_nhan,0);    %#ok<AGROW>
     case 'BS'  
       tree = templateTree('Minleaf',para.BS.leaf);
       BS_model = fitensemble(tr_vec,tr_nhan,'LogitBoost',para.BS.iter,...
           tree,'LearnRate',para.BS.LR,'type','classification');
       [t_pred, t_score] = predict(BS_model,t_vec);
       t_dec = t_score(:,1);              
       stats(k,:) = ML_performance(t_pred,t_nhan,0);      %#ok<AGROW>
     case 'KNN'  
       KNN_model = fitcknn(tr_vec,tr_nhan,'NSMethod','exhaustive','Distance','euclidean');
       KNN_model.NumNeighbors= para.KNN.neighbor;    
       t_pred = predict(KNN_model,t_vec);
       [~,KNNscore] = resubPredict(KNN_model);
       t_dec = KNNscore(:,1);
       stats(k,:) = ML_performance(t_pred,t_nhan,0);      %#ok<AGROW>
    end 
   end 
  end 
 end
    ber(NetDep,L2Regu,LearnR,momen) = mean(stats(:,4)); % mean ber value    
    trainedNet{NetDep,L2Regu,LearnR,momen}.layers = net.Layers; %#ok<AGROW>
    trainedNet{NetDep,L2Regu,LearnR,momen}.options = options; %#ok<AGROW>
   end  
  end
 end
end
[~,minI] = min(ber(:));
[NetS,NetD,L2R,LR,Mom] = ind2sub(size(ber),minI);
bestNet = trainedNet{NetS,NetD,L2R,LR,Mom}.layers;
bestOpt = trainedNet{NetS,NetD,L2R,LR,Mom}.options;
end

function layers = convBlock(filterSize,numFilters,numConvLayers)
layers = [convolution2dLayer(filterSize,numFilters,'Padding',[(filterSize(1)-1)/2 0]);
    reluLayer];
layers = repmat(layers,numConvLayers,1);
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