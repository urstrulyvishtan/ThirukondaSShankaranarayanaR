from login import username
from main import cnx

cursor = cnx.cursor()
nuid_temp = "SELECT nuid FROM employementseekers WHERE user_name = %s"
nuid = cursor.execute(nuid_temp, username)
print("Welcome " + nuid + "!") 
print("1. View Listings")
print("2. View your Applications")
application_option = input()