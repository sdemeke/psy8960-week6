#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)



#Data Import
citations <- stri_read_lines("../data/citations.txt",encoding = "latin1")
citations_txt <- citations[!stri_isempty(citations)]
length(citations)-length(citations_txt)
mean(str_length(citations_txt))

#Data Cleaning
sample(citations_txt, size = 10)
