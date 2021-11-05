# Run once only to install
install.packages("mallet")

# Need to download Java if you don't already have it
# https://java.com/en/download/
# on Mac look for it in System Preferences

setwd("~/Documents/text_mining_r_data/")

# R mallet info and most of this code hacked from 
# https://htmlpreview.github.io/?https://raw.githubusercontent.com/mimno/RMallet/master/mallet/inst/doc/mallet.html

# Here's a Stack Overflow on loading data https://stackoverflow.com/questions/43564288/reading-documents-with-r-tm-to-use-with-r-mallet

library(mallet)
library(tidyverse)

# Found a list of Mallet English stopwords at: https://github.com/mengjunxie/ae-lda/blob/master/misc/mallet-stopwords-en.txt
# Downloaded them and just put them in the working directory

# From the R Mallet manual (PDF) page 4
# https://cran.r-project.org/web/packages/mallet/mallet.pdf
# transcripts_plain_text is a subdirectory of the working directory containing Sandra's 41 plain text files
# unzipped (and removing the transcriptsALL.txt file).
documents <- mallet.read.dir("transcripts_plain_text")

# The mallet.read.dir function read the files into a data frame with a column called "id" for the file paths
# and a column called "text" containing a single character object with all the text from the file
# I haven't figured out how the token regex works, but just used what was in the example.
transcripts.instances <- mallet.import(documents$id, documents$text, "mallet-stopwords-en.txt",
          token.regexp = "\\p{L}[\\p{L}\\p{P}]+\\p{L}")

# The rest of the code mostly follows the example, except as noted
topic.model <- MalletLDA(num.topics=10, alpha.sum = 1, beta = 0.1)

topic.model$loadDocuments(transcripts.instances)

# vocabulary is a vector containing all of the words in the documents
vocabulary <- topic.model$getVocabulary()
head(vocabulary)

# word.freqs is a data frame with columns for the words, their frequence, and number of docs present
word.freqs <- mallet.word.freqs(topic.model)
head(word.freqs)

# Here I used the arrange() function from dplyr to sort descending. Pipe characters %>% are from magrittr library
# Both libraries are included in tidyverse
sorted <- word.freqs %>% arrange(desc(term.freq))
head(sorted) # show the six most common words. Ha-ha, "yeah" is second most common!
