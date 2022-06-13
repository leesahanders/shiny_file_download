# Programmatic deployment example 

# Refer to: https://docs.rstudio.com/connect/admin/appendix/deployment-guide/ 
# and also: https://rstudiopbc.atlassian.net/wiki/spaces/SUP/pages/36212280/Troubleshooting+deployments+with+rsconnect 

# To programmatically publish content to RStudio Connect, use the functions deployDoc, deployApp, deployAPI, and deploySite from the rsconnect package. Each of these functions will require a user account and a connected server. To setup an account on a server use addConnectServer and connectUser. To view currently configured accounts use accounts. For more details visit the rsconnect reference pages.
# You can also do this through the IDE. This documentaion is great: https://docs.rstudio.com/how-to-guides/rsc/publish-rmd/ 


if(0){
library(rsconnect)

rsconnect::writeManifest()

# From here you could decide to use git backed deployment after saving to your git repo

# token = Sys.setenv("token" = )
# secret = Sys.setenv("secret")

# rsconnect::setAccountInfo(name = "lisa.anders", 
#                           token = Sys.getenv("token"), 
#                           secret = Sys.getenv("secret"))

rsconnect::deployApp(
  appDir = getwd(),
  #appFiles = list.files(recursive = TRUE),
  #appFiles = c("ui.R", "server.R"),
  account = "lisa.anders",
  server = "colorado.rstudio.com"
)

}
