close all; clc; clear;
tic
  window = '5s';
 NSec = [1 2 3 4];
% Data collection
  [trdata,trlabel,tedata,telabel,tr_rec_id,te_rec_id,segment_length]...
      = data_colection(window);
% Fully CNN selection and saving
  path_res = 'S:/research/four_paper/CNN_selection_validation/Full_CNNs/5s/';
  filename = {'CNN'}; 
for i=1:length(NSec)   
  CNN_metrics = CNN_validation(window,NSec(i),tedata,telabel,te_rec_id);
  file_save = sprintf('%s%s_validation_%s_%d_100',path_res,filename{1},window,NSec(i));
  save(file_save,'CNN_metrics');
end
toc

function [trdata,trlabel,tedata,telabel,tr_rec_id,te_rec_id,segment_length]...
    = data_colection(window)
switch window
    case '5s'
       data = ['S:/research/four_paper/data/' 'dataCNN73_5s'] %#ok<NOPRT>
       %data = ['C:/four_paper/data/' 'dataCNN73_5s'] %#ok<NOPRT>
    case '8s'   
       data = ['S:/research/four_paper/data/' 'dataCNN73_8s'] %#ok<NOPRT>
       %data = ['C:/four_paper/data/' 'dataCNN73_8s'] %#ok<NOPRT>
end
load(data); %#ok<LOAD>
% ECGchannel = 3;
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

function CNN_metrics = CNN_validation(window,NS,tedata,telabel,te_rec_id)
pos = categorical(1); neg = categorical(0);
addpath('S:/research/four_paper/CNN_selection_validation/Full_CNNs/5s/');
CNN_model_file = sprintf('CNN_model_%s_%d',window,NS);
load(CNN_model_file); %#ok<LOAD>
layers = bestNet; options = bestOpt;
  
% Dividing data for cross validation
num_record = size(te_rec_id, 1);
num_folds = 5;
num_labels = size(telabel, 1); 

% Cross validation repetitions 
for repeat=1:100 
 sprintf('vong lap thu: %d',repeat)
 rng('shuffle', 'twister');
 perm = randperm(num_record)';    % Select radomly index of records 
 start_record = 1;
  for k = 1:num_folds
     end_record = floor(num_record*k/num_folds);
     selected_record = sort(perm(start_record:end_record));
     num_observation_of_record = [1; cumsum(te_rec_id)+1];
     t_record = [];
     for t=1:size(selected_record,1)
       t_record = [t_record; [num_observation_of_record(selected_record(t))...
           :num_observation_of_record(selected_record(t)+1)-1]']; %#ok<AGROW>
     end
     t_folds{k} = t_record; %#ok<AGROW>
     start_record = end_record+1;
  end
  for l=1:num_folds
   % training data
    tr_record = setdiff((1:num_labels)', t_folds{l});
    tr_labels = telabel(tr_record,1);
    tr_data = tedata(:,:,:,tr_record);
   % Testing data    
    t_labels = telabel(t_folds{l},1); 
    t_data = tedata(:,:,:,t_folds{l});   
   
   %%%Ktra xem co du 2 nhan khong, neu k du thi bo qua.
    if any(t_labels(:)==neg) && any(t_labels(:)==pos)                     
     % Train the CNN model
      net = trainNetwork(tr_data,tr_labels,layers,options);
     % Test the CNN model
      [prelabel,~] = classify(net,t_data);      
      stats(l,:) = CNN_Performance(prelabel,t_labels);  %#ok<AGROW>
    end  
  end   
stats_CNN(repeat,:) = mean(stats); %#ok<AGROW>
end  
CNN_metrics.mean = mean(stats_CNN); CNN_metrics.std = std(stats_CNN);
end

function stats_vector = CNN_Performance(predicted_label,true_label)
% labels is predicted labels
%scores is true labels of test set
% positive class: Shockable rhythms
pos = categorical(1); neg = categorical(0);
fv = find(true_label == pos);
tp = sum(predicted_label(fv)==pos);
fn = sum(predicted_label(fv)==neg);
pc = tp + fn;
% negative class: Others
rs = find(true_label == neg);
tn = sum(predicted_label(rs)==neg);
fp = sum(predicted_label(rs)==pos);
nc = tn + fp;
% metrics
stats.ac = (tp + tn) / (pc + nc) * 100; % Accuracy
stats.se = tp/(tp+fn) * 100; % Sensitivity, Also known as Recall
stats.sp = tn/(tn+fp) * 100; % Specificity,  Also known as False Positives Rate
stats.ber = 0.5* (fn/pc + fp/nc ) * 100 ;  
stats.ppv  = tp/(tp+fp) * 100; % Pos. Predictivity, Also as Precision
stats.err = 100-stats.ac;               % Error rate
stats.fsc = 2*stats.ppv*stats.se / (stats.ppv + stats.se);
stats.gme = sqrt(stats.se*stats.sp);  
stats_vector = [stats.ac,stats.se,stats.sp,stats.ber,stats.ppv,...
    stats.err,stats.fsc,stats.gme];
end