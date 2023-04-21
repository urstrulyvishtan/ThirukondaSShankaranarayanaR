from first import first
from listings import listings
from main import cnx
from login import login
from viewing_applications import viewing_applications


def first_page(username):
    cursor = cnx.cursor()
    nuid_temp = "SELECT nuid FROM employementseekers WHERE user_name = %s"
    nuid = cursor.execute(nuid_temp, username)
    print("Welcome " + nuid + "!")
    print("1. View Listings")
    print("2. View your Applications")
    print("3. logout")
    application_option = input()
    if application_option == 1:
        listings()
    if application_option == 2:
        viewing_applications(nuid)
    if application_option == 3:
        first()
