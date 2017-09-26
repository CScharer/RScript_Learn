bioinformatics <- searchTwitter("#bioinformatics", n=1500, cainfo="cacert.pem")
bioinformatics_text <- sapply(bioinformatics, function(x) x$getText())
bioinformatics_text_corpus <- Corpus(VectorSource(bioinformatics_text))
bioinformatics_text_corpus <- tm_map(bioinformatics_text_corpus,
                                     content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                                     mc.cores=1
)
bioinformatics_text_corpus <- tm_map(bioinformatics_text_corpus, content_transformer(tolower), mc.cores=1)
bioinformatics_text_corpus <- tm_map(bioinformatics_text_corpus, removePunctuation, mc.cores=1)
bioinformatics_text_corpus <- tm_map(bioinformatics_text_corpus, function(x)removeWords(x,stopwords()), mc.cores=1)
wordcloud(bioinformatics_text_corpus)

#if you're getting the error:
#could not be fit on page. It will not be plotted.
#try changing the scale, like
#wordcloud(bioinformatics_text_corpus, scale=c(2,0.2))

library(RColorBrewer)
pal2 <- brewer.pal(8,"Dark2")
wordcloud(bioinformatics_text_corpus,min.freq=2,max.words=100, random.order=T, colors=pal2)