from first_page import application_option, nuid
from main import cnx

if application_option == 2 :
    cursor = cnx.cursor()
    args = nuid
    result = cursor.callproc('view_applications', args)
    withdraw_option = input("1. Withdraw any applications\n2. Go Back")
    if withdraw_option == 1:
        args = input("Enter the application ID to Withdraw : ")
        cursor.callproc('delete_application', args)
