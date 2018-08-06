layer_1 = function(factor_cols,na_strings,nominal_cols,column = 1,na_pct = 0.3)
{
  setwd(choose.dir(caption = "Select the output folder"))
  data = read.csv(file.choose(),na.strings = na_strings)
  new_folder = paste0("Darwin_",gsub("\\:","_",gsub(" ","_",Sys.time())))
  dir.create(new_folder)
  setwd(new_folder)
  num_cols = colnames(data)
  num_cols = num_cols[!num_cols %in% factor_cols] 
  
  data[factor_cols] = lapply(data[factor_cols], as.factor)
  data[num_cols] = lapply(data[num_cols], as.numeric)
  dir.create("Layer_1")
  
  data = data[,!colnames(data) %in% nominal_cols]
  
  if(sum(is.na(data))>0)
  {
    if(column == 1)
    {
      data_col = Filter(function(x)(sum(is.na(x))<(na_pct*nrow(data))),data)
      if(ncol(data_col) != ncol(data))
      {
        write.csv(data_col,file = paste0("Layer_1/","columns_",na_pct,"_removed.csv"),
                  row.names = FALSE)
        print("NA cols greater than thereshold pct removed")
      }
    }else
    {
      data_row = data[which(rowSums(is.na(data))<(na_pct*ncol(data))),]
      if(nrow(data_row) != nrow(data))
      {
        write.csv(data_row,file = paste0("Layer_1/","rows_",na_pct,"_removed.csv"),
                  row.names = FALSE)
        print("NA rows greater than thereshold pct removed")
      }
    }
    print("NA pct not greater than threshold to remove the cols / rows")
    write.csv(data,file = "Layer_1/na_not_removed.csv",row.names = FALSE)
  }else
  {
    write.csv(data,file = "Layer_1/no_na.csv",row.names = FALSE) 
    print("no NA found to remove the cols / rows")
  }
}




