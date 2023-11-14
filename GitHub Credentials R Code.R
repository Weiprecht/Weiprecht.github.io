# Set a new authorization to GitHub
# In Developer Settings on GitHub, set a new Personal Access Token (see link below)
# Copy that new token to the clipboard
# Use this token (paste it) as the "password" that the code below prompts you for. 

install.packages("gitcreds")
library(gitcreds)
gitcreds_set()

#Thats it!  You should be able to Comit and Push from RStudio!


# Getting a Personal Access Token
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-personal-access-token-classic

# Reference:
#  https://stackoverflow.com/questions/66065099/how-to-update-github-authentification-token-on-rstudio-to-match-the-new-policy

