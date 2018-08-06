layer_3 = function(factor_cols,na_strings)
{
  library(vegan)
  file_names = list.files(path = 'Layer_2')
  file_names = paste0('Layer_2/',file_names)
  dir.create("Layer_3")
  
  i = 1
  for(file1 in file_names)
  {
    data = read.csv(file1,na.strings = na_strings)
    factor_cols = factor_cols[factor_cols %in% colnames(data)]
    num_cols = colnames(data)
    num_cols = num_cols[!num_cols %in% factor_cols] 
    
    data[factor_cols] = lapply(data[factor_cols], as.factor)
    data[num_cols] = lapply(data[num_cols], as.numeric)
    
    if(length(num_cols)>0)
    {
      data_zscore = data
      data_zscore[num_cols] = decostand(data_zscore[num_cols],"standardize") 
      
      data_range = data
      data_range[num_cols] = decostand(data_range[num_cols],"range")
      
      write.csv(data_zscore,file = paste0("Layer_3/d",i,"_zscore.csv"),row.names = FALSE)
      write.csv(data_range,file = paste0("Layer_3/d",i,"_range.csv"),row.names = FALSE)
      write.csv(data,file = paste0("Layer_3/d",i,"_no_standardization.csv"),row.names = FALSE)
      i = i+1
    }else
    {
      write.csv(data,file = paste0("Layer_3/d",i,"_no_num.csv"),row.names = FALSE)
      i = i+1
    }
  }
  print("standardization completed")
}
