#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)
library(rebus)


#Data Import
citations <- stri_read_lines("../data/citations.txt",encoding = "latin1")
citations_txt <- citations[!stri_isempty(citations)]
length(citations)-length(citations_txt)
mean(str_length(citations_txt))

#Data Cleaning
writeLines(sample(citations_txt, size = 10))

citations_tbl <- tibble(line=1:length(citations_txt),cite=citations_txt) %>% 
  str_remove_all(citations_txt[1:5],'["\']') %>% 
  mutate(year = str_extract(cite,pattern = "(" %R% one_or_more(DGT) %R% ")"))  
  
  