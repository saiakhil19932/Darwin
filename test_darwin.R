rm(list = ls())
setwd("C:/Users/Bharath Narla/Desktop/Darwin")

target = "Customer.Lifetime.Value"
nominal_cols = c('CustomerID','Location.Geo')
factor_cols = c('Coverage','Education','EmploymentStatus','Gender',
                'Location.Code','Marital.Status','Policy.Type','Policy',
                'Renew.Offer.Type','Sales.Channel','Vehicle.Class','Vehicle.Size')
na_strings = c("NA","")

source("code_layer_1.R")
source("code_layer_2.R")
source("code_layer_3.R")
source("code_layer_4.R")

layer_1(factor_cols = factor_cols,na_strings = na_strings,nominal_cols = nominal_cols,column = 1,na_pct = 0.3)
layer_2(factor_cols = factor_cols,na_strings = na_strings,knn_k = 10,target = target)
layer_3(factor_cols = factor_cols,na_strings = na_strings)
layer_4(factor_cols = factor_cols,na_strings = na_strings,factor_levels = 10)



layer_1(column = 0,na_pct = 0.3,
        factor_cols = factor_cols,
        na_strings = na_strings)


test = read.csv('Layer_4/d1_fact_variables_not_dropped.csv')
