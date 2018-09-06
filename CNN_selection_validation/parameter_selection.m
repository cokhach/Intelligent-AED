function [parameter] = parameter_selection(X,y,id_record,method,weight)
rng('shuffle','twister');         % Ensure same folds accross all parameters
% Tuning parameters for algorithms:
switch method,
       case 'SVM',
        if nargin > 4  
         [logG, logC] = SVM_para(X,y,id_record,weight);
        else 
         [logG, logC] = SVM_para(X,y,id_record);   
        end 
         parameter.SVM.logC = logC;
         parameter.SVM.logG = logG;
       case 'BG',
         [num_tree, num_leaf] = BG_para(X,y,id_record);
         parameter.BG.num_tree = num_tree;
         parameter.BG.num_leaf = num_leaf;
       case 'RF',
         [num_tree, num_leaf] = RF_para(X,y,id_record);
         parameter.RF.num_tree = num_tree;
         parameter.RF.num_leaf = num_leaf;
       case 'KNN',
         bestk = KNN_para(X,y,id_record);
         parameter.KNN.neighbor = bestk;
       case 'BS',
         [bestLR, best_loop, best_leave] = BS_para(X,y,id_record);
         parameter.BS.LR = bestLR;
         parameter.BS.iter = best_loop;
         parameter.BS.leaf = best_leave;
end
end 

%%% LibSVM
function [bestG, bestC] = SVM_para(X,y,record_id,weight)
num_folds = 5;
num_labels = size(y, 1);
num_record = size(record_id, 1);
  perm = randperm(num_record)';    % Select radomly index of records 
  start_record = 1;
    for i = 1:num_folds
       end_record = floor(num_record*i/num_folds);
       selected_record = sort(perm(start_record:end_record));
       num_observation_of_record = [1; cumsum(record_id)+1];
       t_record = [];
      for j=1:size(selected_record,1)
         t_record = [t_record; [num_observation_of_record(selected_record(j)):num_observation_of_record(selected_record(j)+1)-1]'];
      end
        t_folds{i} = t_record;
        start_record = end_record + 1;
    end

log2c = -3:1:3; log2g = -5:1:1; 
ber = zeros(length(log2g),length(log2c));
for g=1:length(log2g)
  for c=1:length(log2c)  
   if nargin > 4  
    lib_opt = [' -s 0 -t 2 -h 0 -w0 1 -w1 ' num2str(weight) ' -c ' num2str(2^log2c(c)) ' -g ' num2str(2^log2g(g))];
   else
    lib_opt = [' -s 0 -t 2 -h 0 -c ' num2str(2^log2c(c)) ' -g ' num2str(2^log2g(g))];    
   end
    for k=1:num_folds
      % training data
      tr_record = setdiff((1:num_labels)', t_folds{k});
      tr_labels = y(tr_record,1); tr_data = X(tr_record,:);
      % Testing data    
      t_labels = y(t_folds{k},1); t_data = X(t_folds{k},:);   
     
      %%%Ktra xem co du 2 nhan khong, neu k du thi bo qua.
      if any(t_labels(:)==0) && any(t_labels(:)==1)      
      % Train the SVM model  
      model = svmtrain(tr_labels, tr_data, ['-q ' lib_opt]);
      % Test the SVM model
      [t_pred, ~, t_dec] = svmpredict(t_labels, t_data, model, '-q');
       t_dec = t_dec * (2 * model.Label(1) - 1);
      stats(k,:) = compute_metrics(t_pred,t_labels,0); 
      end 
    end                 
      ber(g,c) = mean(stats(:,2)); % mean ber value            
  end  
end
[minB,minI] = min(ber(:));
[I_row, I_col] = ind2sub(size(ber),minI);
bestG = log2g(I_row); bestC = log2c(I_col);
end

%%% BAGGING
function [bestNtree, bestNleaf] = BG_para(X,y,record_id)
num_folds = 5;
num_labels = size(y, 1);
num_record = size(record_id, 1);
  perm = randperm(num_record)';    % Select radomly index of records 
  start_record = 1;
    for i = 1:num_folds
       end_record = floor(num_record*i/num_folds);
       selected_record = sort(perm(start_record:end_record));
       num_observation_of_record = [1; cumsum(record_id)+1];
       t_record = [];
      for j=1:size(selected_record,1)
         t_record = [t_record; [num_observation_of_record(selected_record(j)):num_observation_of_record(selected_record(j)+1)-1]'];
      end
        t_folds{i} = t_record;
        start_record = end_record + 1;
    end  
NTREE = [10 20 30]; NLEAF = [10 20 30];
ber = zeros(length(NTREE),length(NLEAF));
for Ntree = 1:length(NTREE)
  for Nleaf = 1:length(NLEAF)
      params.Ntree = NTREE(Ntree); params.Nleaf = NLEAF(Nleaf);                         
    for k=1:num_folds
      % training data
      tr_record = setdiff((1:num_labels)', t_folds{k});
      tr_labels = y(tr_record,1); tr_data = X(tr_record,:);
      % Testing data    
      t_labels = y(t_folds{k},1); t_data = X(t_folds{k},:); 
      %%%Ktra xem co du 2 nhan khong, neu k du thi bo qua.
      if any(t_labels(:)==0) && any(t_labels(:)==1) 
      % Train the Bagging model          
       bg_tree = TreeBagger(params.Ntree,tr_data,tr_labels,'Method','classification','minleaf', params.Nleaf,'NvarToSample','all','prior', [0.7 0.3]);
      % Test the Bagging model 
       [t_pred_class, t_score] = bg_tree.predict(t_data);
       t_dec = t_score(:,2);
           % convert to double
            S = sprintf('%s*', t_pred_class{:});
            t_pred = sscanf(S, '%f*');
       stats(k,:) = compute_metrics(t_pred,t_labels,0);
      end
      end          
       ber(Ntree,Nleaf) = mean(stats(:,2)); % mean ber value                    
  end
end
[~,minI] = min(ber(:));
[I_row, I_col] = ind2sub(size(ber),minI);
bestNtree = NTREE(I_row); bestNleaf = NLEAF(I_col);
end

% RANDOM FOREST
function [bestNtree, bestNleaf] = RF_para(X,y,record_id)
num_folds = 5;
num_labels = size(y, 1);
num_record = size(record_id, 1);
  perm = randperm(num_record)';    % Select radomly index of records 
  start_record = 1;
    for i = 1:num_folds
       end_record = floor(num_record*i/num_folds);
       selected_record = sort(perm(start_record:end_record));
       num_observation_of_record = [1; cumsum(record_id)+1];
       t_record = [];
      for j=1:size(selected_record,1)
         t_record = [t_record; [num_observation_of_record(selected_record(j)):num_observation_of_record(selected_record(j)+1)-1]'];
      end
        t_folds{i} = t_record;
        start_record = end_record + 1;
    end
NTREE = [10 20 30]; NLEAF = [10 20 30];
ber = zeros(length(NTREE),length(NLEAF));
for Ntree = 1:length(NTREE)
  for Nleaf = 1:length(NLEAF)
      params.Ntree = NTREE(Ntree); params.Nleaf = NLEAF(Nleaf);          
    for k=1:num_folds
      % training data
      tr_record = setdiff((1:num_labels)', t_folds{k});
      tr_labels = y(tr_record,1);
      tr_data = X(tr_record,:);
      % Testing data    
      t_labels = y(t_folds{k},1);
      t_data = X(t_folds{k},:);   
      %%%Ktra xem co du 2 nhan khong, neu k du thi bo qua.
      if any(t_labels(:)==0) && any(t_labels(:)==1)     
      % Train the Random forest model          
       RF_tree = TreeBagger(params.Ntree,tr_data,tr_labels,'Method','classification','minleaf', params.Nleaf,'prior', [0.7 0.3]);
      % Test the Random forest model 
       [t_pred_class, t_score] = RF_tree.predict(t_data);
       t_dec = t_score(:,2);
           % convert to double
            S = sprintf('%s*', t_pred_class{:});
            t_pred = sscanf(S, '%f*');       
       stats(k,:) = compute_metrics(t_pred,t_labels,0);
      end
    end          
       ber(Ntree,Nleaf) = mean(stats(:,2)); % mean ber value                    
  end
end

[~,minI] = min(ber(:));
[I_row, I_col] = ind2sub(size(ber),minI);
bestNtree = NTREE(I_row); bestNleaf = NLEAF(I_col);
end

% K-NEAREST NEIGHBOURS
function bestk = KNN_para(X,y,record_id)
num_folds = 5;
num_labels = size(y, 1);
num_record = size(record_id, 1);
  perm = randperm(num_record)';    % Select radomly index of records 
  start_record = 1;
    for i = 1:num_folds
       end_record = floor(num_record*i/num_folds);
       selected_record = sort(perm(start_record:end_record));
       num_observation_of_record = [1; cumsum(record_id)+1];
       t_record = [];
      for j=1:size(selected_record,1)
         t_record = [t_record; [num_observation_of_record(selected_record(j)):num_observation_of_record(selected_record(j)+1)-1]'];
      end
        t_folds{i} = t_record;
        start_record = end_record + 1;
    end  
neighbors = 5:10:100;
ber = zeros(length(neighbors),1);
for NN = 1:length(neighbors)
    nb = neighbors(NN);
   for k=1:num_folds
      % training data
      tr_record = setdiff((1:num_labels)', t_folds{k});
      tr_labels = y(tr_record,1);
      tr_data = X(tr_record,:);
      % Testing data    
      t_labels = y(t_folds{k},1);
      t_data = X(t_folds{k},:);       
     %%%Ktra xem co du 2 nhan khong, neu k du thi bo qua.
      if any(t_labels(:)==0) && any(t_labels(:)==1) 
      % Train the KNN model
      kNN_model = fitcknn(tr_data,tr_labels,'NSMethod','exhaustive','Distance','euclidean');
      kNN_model.NumNeighbors= nb;
      % Test the KNN model
      [t_pred, t_score] = predict(kNN_model,t_data);
      t_dec = t_score(:,1);
      stats(k,:) = compute_metrics(t_pred,t_labels,0);    %#ok<AGROW>
      end
   end
      ber(NN) = mean(stats(:,2)); % mean ber value     
end
[~,minI] = min(ber);
bestk = neighbors(minI);
end

% BOOSTING TREES
function [bestLR, best_loop, best_leave] = BS_para(X,y,record_id)
num_folds = 5;
num_labels = size(y, 1);
num_record = size(record_id, 1);
  perm = randperm(num_record)';    % Select radomly index of records 
  start_record = 1;
    for i = 1:num_folds
       end_record = floor(num_record*i/num_folds);
       selected_record = sort(perm(start_record:end_record));
       num_observation_of_record = [1; cumsum(record_id)+1];
       t_record = [];
      for j=1:size(selected_record,1)
         t_record = [t_record; [num_observation_of_record(selected_record(j)):num_observation_of_record(selected_record(j)+1)-1]'];
      end
        t_folds{i} = t_record;
        start_record = end_record + 1;
    end
LR      = [0.1 0.5 1];               %learning rate
ITER    = [10 20 30];
MINLEAF = [10 20 40];
ber = zeros(length(LR),length(ITER),length(MINLEAF));
for lr = 1:length(LR)
  for iter = 1:length(ITER)
    for minleaf = 1:length(MINLEAF)    
      lrate = LR(lr); iteration = ITER(iter); mleaf = MINLEAF(minleaf);
      tree  = templateTree('Minleaf',mleaf);
      method  = 'LogitBoost';
     for k=1:num_folds
      % training data
      tr_record = setdiff((1:num_labels)', t_folds{k});
      tr_labels = y(tr_record,1);
      tr_data = X(tr_record,:);
      % Testing data    
      t_labels = y(t_folds{k},1);
      t_data = X(t_folds{k},:);    
      %%%Ktra xem co du 2 nhan khong, neu k du thi bo qua.
      if any(t_labels(:)==0) && any(t_labels(:)==1) 
      % Train the Boosting tree model          
      BT_model = fitensemble(tr_data,tr_labels,method,iteration,tree,'LearnRate',lrate,'type','classification');
      % Test the Boosting tree model 
      [t_pred, t_score] = predict(BT_model,t_data);
      t_dec = t_score(:,1);              
      stats(k,:) = compute_metrics(t_pred,t_labels,0);
      end
     end    
     ber(lr,iter,minleaf) = mean(stats(:,2)); % mean ber value                        
   end
 end
end

[~,minI] = min(ber(:));
[I_row, I_col, I_pag] = ind2sub(size(ber),minI);
bestLR = LR(I_row); best_loop = ITER(I_col); best_leave = MINLEAF(I_pag);
end

function stats_vector = compute_metrics(labels,scores,value)
fv = find(scores == 1);
tp = sum(labels(fv)==1);
fn = sum(labels(fv)==value);
pc = tp + fn;
rs = find(scores == value);
tn = sum(labels(rs)==value);
fp = sum(labels(rs)==1);
nc = tn + fp;
stats.acc = (tp + tn) / (pc + nc) * 100; 
stats.ber = 0.5* (fn/pc + fp/nc ) * 100 ;  

stats_vector = [stats.acc,stats.ber];
end