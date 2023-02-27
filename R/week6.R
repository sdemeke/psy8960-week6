#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)
# library(rebus)


#Data Import
citations <- stri_read_lines("../data/citations.txt",encoding = "WINDOWS-1252") 
citations_txt <- citations[!stri_isempty(citations)]
length(citations)-length(citations_txt)
mean(str_length(citations_txt))

#Data Cleaning
sample(citations_txt, size = 10)

citations_tbl <- tibble(line = 1:length(citations_txt), cite = citations_txt) %>% 
   mutate(cite = str_remove_all(cite,pattern=regex("[\"']"))) %>% 
   mutate(year = str_match(cite,pattern=regex("\\((\\d{4})[,\\s\\w+]*\\)\\."))[,2]) %>% 
   mutate(page_start = str_match(cite,pattern=regex("(?:,|p?p\\.)\\s(\\d+)-\\d+\\)?\\."))[,2]) %>% 
   mutate(perf_ref = str_detect(cite,pattern=fixed("performance", ignore_case = T))) %>% 
   mutate(title = str_match(cite,pattern=regex("\\((\\d{4})[,\\s\\w+]*\\)\\.\\s([^(?].*?[.?!])[^.]*\\."))[,3]) %>%
   mutate(first_author = str_extract(cite,pattern=regex("^[^.,\\d:]*(?:,(?:\\s?[A-Z][,\\.\\s])+|\\.\\s\\()")))

sum(!is.na(citations_tbl$first_author)) 
