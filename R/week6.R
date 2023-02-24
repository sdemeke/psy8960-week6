#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)
library(rebus)


#Data Import
citations <- stri_read_lines("../data/citations.txt",encoding = "WINDOWS-1252") #latin1 adds 4 non-empty lines but also keeps accents in unicode..
citations_txt <- citations[!stri_isempty(citations)]
length(citations)-length(citations_txt)
mean(str_length(citations_txt))

#Data Cleaning
sample(citations_txt, size = 10)

citations_tbl <- tibble(line = 1:length(citations_txt), cite = citations_txt) %>% 
   mutate(cite = str_remove_all(cite,pattern=regex("[\"']"))) %>% 
   mutate(year = str_match(cite,pattern=regex("\\((\\d{4})\\)?\\.?"))[,2]) %>% 
  # #11,153 cases don't match because year is outside parentheses or not present. not APA so ignore?
  # #one of matches has 'year' = 5955. ignore for now
  # #some are (XXXX, month) - matching with \\)?
   mutate(page_start = str_match(cite,pattern=regex("(\\d+)[-?]\\d+"))[,2]) %>% 
  # #above won't work if misspecified APA, e.g. page:page. ignore these cases
  # #captures some wrong numbers from DOI. fix?
   mutate(perf_ref = str_detect(cite,pattern=fixed("performance", ignore_case = T))) %>% 
  # #works well
   mutate(title = str_match(cite,pattern=regex("\\)\\.?.(.*?)[.?!]\\s?[A-Z]"))[,2]) %>% 
  #.*? as non-greedy. will take first instance of where .* is followed by [.?!]\\s?[A-Z]
  mutate(first_author = str_match(cite,pattern=regex("(^.*?)(?:\\.,| \\(| and)"))[,2])
sum(!is.na(citations_tbl$first_author))   
