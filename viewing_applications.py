from first_page import first_page
from main import cnx


def viewing_applications(nuid):
    cursor = cnx.cursor()
    cursor2 = cnx.cursor()
    args = nuid
    cursor = cursor.callproc('view_applications', args)
    withdraw_option = input("1. Withdraw any applications\n2. Go Back")
    if withdraw_option == 1:
        args_2 = input("Enter the application ID to Withdraw : ")
        cursor.callproc('delete_application', args_2)
        deleted = "SELECT * FROM application WHERE application_id = %s"
        if cursor2.execute(deleted, args_2) == 0:
            print("Application Withdrawn")
            viewing_applications(nuid)

    if withdraw_option == 2:
        first_page()
