layer_4 = function(factor_cols,na_strings,factor_levels = 10)
{
  library(vegan)
  file_names = list.files(path = 'layer_3')
  file_names = paste0('layer_3/',file_names)
  dir.create("Layer_4")
  
  i = 1
  for(file1 in file_names)
  {
    data = read.csv(file1,na.strings = na_strings)
    factor_cols = factor_cols[factor_cols %in% colnames(data)]
    num_cols = colnames(data)
    num_cols = num_cols[!num_cols %in% factor_cols] 
    
    data[factor_cols] = lapply(data[factor_cols], as.factor)
    data[num_cols] = lapply(data[num_cols], as.numeric)
    
    if(length(factor_cols)>0)
    {
      data_fact_levels = data[sapply(data, nlevels) <= factor_levels]
      if(ncol(data_fact_levels) != ncol(data))
      {
        write.csv(data_fact_levels,file = paste0("Layer_4/d",i,"_fact_variable_dropped.csv"),row.names = FALSE)
      }
      write.csv(data,file = paste0("Layer_4/d",i,"_fact_variables_not_dropped.csv"),row.names = FALSE)
      i = i+1
    }else
    {
      write.csv(data,file = paste0("Layer_4/d",i,"_no_cat_variables.csv"),row.names = FALSE)
      i = i+1
    }
  }
  print("factor variable levels check completed")
}
