#install.packages("Rfacebook")
#install.packages("RCurl")
library(Rfacebook)
library(RCurl)
#Read the App ID and App Secret from the facebook file.
fileName <- "facebook.txt"
conn <- file(fileName,open="r")
lineArray <-readLines(conn)
for (lineNumber in 1:length(lineArray)){
  # print(lineArray[lineNumber])
  if(lineNumber==1)
  {
    app_id = lineArray[lineNumber]
  }
  if(lineNumber==2)
  {
    app_secret = lineArray[lineNumber]
  }
}
close(conn)
fb_oauth <- fbOAuth(app_id, app_secret, extended_permissions = TRUE)
#######################################################################
# fbOAuth <- function(app_id, app_secret, extended_permissions=FALSE, legacy_permissions=FALSE, scope=NULL)
# {
#   ## getting callback URL
#   full_url <- oauth_callback()
#   full_url <- gsub("(.*localhost:[0-9]{1,5}/).*", x=full_url, replacement="\\1")
#   message <- paste("Copy and paste into Site URL on Facebook App Settings:",
#                    full_url, "\nWhen done, press any key to continue...")
#   ## prompting user to introduce callback URL in app page
#   invisible(readline(message))
#   ## a simplified version of the example in httr package
#   facebook <- oauth_endpoint(
#     authorize = "https://www.facebook.com/dialog/oauth",
#     access = "https://graph.facebook.com/oauth/access_token") 
#   myapp <- oauth_app("facebook", app_id, app_secret)
#   if (is.null(scope)) {
#     if (extended_permissions==TRUE){
#       scope <- c("user_birthday", "user_hometown", "user_location", "user_relationships",
#                  "publish_actions","user_status","user_likes")
#     }
#     else { scope <- c("public_profile", "user_friends")}
#     
#     if (legacy_permissions==TRUE) {
#       scope <- c(scope, "read_stream")
#     }
#   }
#   
#   if (packageVersion('httr') < "1.2"){
#     stop("Rfacebook requires httr version 1.2.0 or greater")
#   }
#   ## with early httr versions
#   if (packageVersion('httr') <= "0.2"){
#     facebook_token <- oauth2.0_token(facebook, myapp,
#                                      scope=scope)
#     fb_oauth <- sign_oauth2.0(facebook_token$access_token)
#     if (GET("https://graph.facebook.com/me", config=fb_oauth)$status==200){
#       message("Authentication successful.")
#     }
#   }
#   ## less early httr versions
#   if (packageVersion('httr') > "0.2" & packageVersion('httr') <= "0.6.1"){
#     fb_oauth <- oauth2.0_token(facebook, myapp,
#                                scope=scope, cache=FALSE) 
#     if (GET("https://graph.facebook.com/me", config(token=fb_oauth))$status==200){
#       message("Authentication successful.")
#     } 
#   }
#   ## httr version from 0.6 to 1.1
#   if (packageVersion('httr') > "0.6.1" & packageVersion('httr') < "1.2"){
#     Sys.setenv("HTTR_SERVER_PORT" = "1410/")
#     fb_oauth <- oauth2.0_token(facebook, myapp,
#                                scope=scope, cache=FALSE)  
#     if (GET("https://graph.facebook.com/me", config(token=fb_oauth))$status==200){
#       message("Authentication successful.")
#     } 
#   }
#   ## httr version after 1.2
#   if (packageVersion('httr') >= "1.2"){
#     fb_oauth <- oauth2.0_token(facebook, myapp,
#                                scope=scope, cache=FALSE)  
#     if (GET("https://graph.facebook.com/me", config(token=fb_oauth))$status==200){
#       message("Authentication successful.")
#     } 
#   }
#   ## identifying API version of token
#   error <- tryCatch(callAPI('https://graph.facebook.com/pablobarbera', fb_oauth),
#                     error = function(e) e)
#   if (inherits(error, 'error')){
#     class(fb_oauth)[4] <- 'v2'
#   }
#   if (!inherits(error, 'error')){
#     class(fb_oauth)[4] <- 'v1'
#   }
#   return(fb_oauth)
# }
#######################################################################
me <- getUsers("me",token=fb_oauth, private_info=TRUE)
me$name
#The sample() function is used to list some 10 random pages you have liked.
likes = getLikes(user="me", token = fb_oauth)
sample(likes$names, 10)
#You can also update status in Facebook via R.
updateStatus("This is just a test using RScript.", token=fb_oauth)
#Search Pages that contain a particular keyword
pages <- searchPages( string="trump", token=fb_oauth, n=200)
head(pages$name)
#Extract list of posts from a Facebook page
#See the status posted by BBC News. The facebook page name of BBC News is bbcnews.
page <- getPage(page="bbcnews", token=fb_oauth, n=200) 
head(page)
#Get all the posts from a particular date
page <- getPage("bbcnews", token=fb_oauth, n=100, since='2016/06/01', until='2017/03/20')
str(page)
#Which of these posts got maximum likes?
summary = page[which.max(page$likes_count),]
summary
# Which of these posts got maximum comments?
summary1 = page[which.max(page$comments_count),]
summary1
#Which post was shared the most?
summary2 = page[which.max(page$shares_count),]
summary2
#Extract a list of users who liked the maximum liked posts
post <- getPost(summary$id[1], token=fb_oauth, comments = FALSE, n.likes=2000)
likes <- post$likes
head(likes)