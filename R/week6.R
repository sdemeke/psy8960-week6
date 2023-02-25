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
   mutate(year = str_match(cite,pattern=regex("\\((\\d{4})[,\\s\\w+]*\\)\\."))[,2]) %>% 
   mutate(page_start = str_match(cite,pattern=regex("(?:,|p?p\\.)\\s(\\d+)-\\d+\\)?\\."))[,2]) %>% 
  # #above won't work if not APA, e.g. page:page or page?page or :page-page.
  #is :\\spage-page proper APA7? no idea. ignore for now. can add to or()
  #can something be letter, page-page? dont know but it can be ., page. so shouldn't specify what comes before comma
   mutate(perf_ref = str_detect(cite,pattern=fixed("performance", ignore_case = T))) %>% 
   mutate(title = str_match(cite,pattern=regex("\\)\\.\\s(.*?)[.?!][^.]*\\."))[,2]) %>%
  #messes up for website refs that don't end in full stop
   mutate(first_author = str_match(cite,pattern=regex("(^.*?)(?:\\.,\\s[&[A-Z]]|\\.\\s\\()"))[,2])
sum(!is.na(citations_tbl$first_author))   
#fix the 'and' names. and the ones that go on without spaces