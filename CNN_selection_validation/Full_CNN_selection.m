close all; clc; clear;
tic
  window = '5s';
 NSec = [1 2 3 4];
% Data collection
  [trdata,trlabel,tedata,telabel,tr_rec_id,te_rec_id,segment_length]...
      = data_colection(window);
% Fully CNN selection and saving
  path_res = '../CNN_selection_validation/Full_CNNs/';
  filename = {'CNN'}; 
  for i=1:length(NSec)   
   [trainedNet,ber,bestNet,bestOpt] = Fully_CNN_selection(trdata,trlabel,...
       tr_rec_id,segment_length,NSec(i));
   file_save = sprintf('%s%s_model_%s_%d',path_res,filename{1},window,NSec(i));
   save(file_save,'trainedNet','ber','bestNet','bestOpt');
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

function [trainedNet,ber,bestNet,bestOpt] = Fully_CNN_selection(trdata,trlabel,...
    tr_rec_id,SL,NetSection)
pos = categorical(1); neg = categorical(0);
rng('shuffle','twister');         % Ensure same folds accross all parameters
num_folds = 5;
num_labels = size(trlabel, 1);
num_record = size(tr_rec_id, 1);
  perm = randperm(num_record)';    % Select radomly index of records 
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
        t_folds{i} = t_record; %#ok<AGROW>
       % t_id_record{i} = selected_record;  %#ok<NASGU>
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
 
 for k=1:num_folds
 % training data
  tr_record = setdiff((1:num_labels)', t_folds{k});
  tr_labels = trlabel(tr_record,1); tr_data = trdata(:,:,:,tr_record);
 % Testing data    
  t_labels = trlabel(t_folds{k},1); t_data = trdata(:,:,:,t_folds{k});   
     
 %%%Ktra xem co du 2 nhan khong, neu k du thi bo qua.
  if any(t_labels(:)==neg) && any(t_labels(:)==pos)  
  % Train the CNN model
   net = trainNetwork(tr_data,tr_labels,layers,options);
  % Test the CNN model
   [prelabel,~] = classify(net,t_data);      
   stats(k,:) = compute_metrics(prelabel,t_labels);  %#ok<AGROW>
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
[NetD,L2R,LR,Mom] = ind2sub(size(ber),minI);
bestNet = trainedNet{NetD,L2R,LR,Mom}.layers;
bestOpt = trainedNet{NetD,L2R,LR,Mom}.options;
end

function layers = convBlock(filterSize,numFilters,numConvLayers)
layers = [convolution2dLayer(filterSize,numFilters,'Padding',[(filterSize(1)-1)/2 0]);
    reluLayer];
layers = repmat(layers,numConvLayers,1);
end

function stats_vector = compute_metrics(predicted_label,true_label)
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
stats.ber = 0.5 * (fn/pc + fp/nc ) * 100 ;  
stats.ppv  = tp/(tp+fp) * 100; % Pos. Predictivity, Also as Precision
stats.err = 100-stats.ac;               % Error rate
stats.fsc = 2*stats.ppv * stats.se / (stats.ppv + stats.se);
stats.gme = sqrt(stats.se * stats.sp);  
stats_vector = [stats.ac,stats.se,stats.sp,stats.ber,stats.ppv,...
    stats.err,stats.fsc,stats.gme];
end
