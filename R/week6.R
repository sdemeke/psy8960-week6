#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)



#Data Import
citations <- stri_read_lines("../data/citations.txt",encoding = "latin1")
citations_txt <- stri_isempty(citations)
length(citations[citations_txt])

