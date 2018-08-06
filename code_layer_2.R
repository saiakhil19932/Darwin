layer_2 = function(factor_cols,na_strings,knn_k = 10,target)
{
  library(DMwR)
  file_names = list.files(path = 'Layer_1')
  file_names = paste0('Layer_1/',file_names)
  dir.create("Layer_2")
  
  i = 1
  for(file1 in file_names)
  {
    data = read.csv(file1,na.strings = na_strings)
    factor_cols = factor_cols[factor_cols %in% colnames(data)]
    num_cols = colnames(data)
    num_cols = num_cols[!num_cols %in% factor_cols] 
    
    data[factor_cols] = lapply(data[factor_cols], as.factor)
    data[num_cols] = lapply(data[num_cols], as.numeric)
    
    if(sum(is.na(data))>0)
    {
      data_ci = centralImputation(data)
      data_knn = knnImputation(data,k = knn_k) # do knn without target variable
      data_noimpute = na.omit(data)
      
      write.csv(data_ci,file = paste0("Layer_2/d",i,"_CI.csv"),row.names = FALSE)
      write.csv(data_knn,file = paste0("Layer_2/d",i,"_knn.csv"),row.names = FALSE)
      write.csv(data_noimpute,file = paste0("Layer_2/d",i,"_no_impute.csv"),row.names = FALSE)
      i = i+1
    }else
    {
      write.csv(data,file = paste0("Layer_2/d",i,"_no_na.csv"),row.names = FALSE)
      i = i+1
    }
  }
  print("NA imputation completed")
}
