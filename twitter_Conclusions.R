me <- getUser("CJScharer", cainfo="cacert.pem")
me$getId()[1] "555580799"
getUser(555580799,cainfo="cacert.pem")[1] "CJScharer"
me$getFollowerIDs(cainfo="cacert.pem")
#or
me$getFollowers(cainfo="cacert.pem")
#you can also see what's trending
trend <- availableTrendLocations(cainfo="cacert.pem")
head(trend)
trend <- getTrends(1, cainfo="cacert.pem")
trend