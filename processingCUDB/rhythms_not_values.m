function [signal] = rhythms_not_values(data)

data_N = length(data);
for k1 = 1:data_N
   I = data(k1);
   for  k2 = k1+1:data_N
      if isnan(data(k2))
          data(k2) = I;
      else
          I = data(k2);
      end
   end  
end
signal = data;