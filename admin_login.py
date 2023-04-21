# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 06:22:34 2023

@author: ivarr
"""

from main import cnx
from admin_operations import adminOperations
import getpass

def adminLogin(cnx):
    while(True):
        
        # Create a cursor object
        admin_username = input("Enter your username: ")
        admin_password = getpass.getpass("Enter your password: ")
        cursor = cnx.cursor()
        
        # Call the SQL procedure
        args = (admin_username, admin_password)
        result_args = cursor.callproc('validate_admin_login_credentials', args)
        
        # Get the output parameter value
        valid_admin_login = result_args[2]
        
        if valid_admin_login:
            print("Login Successful \n")
            break
        else:
            print("Invalid username or password \n")
            print("Do you want to return to the previous page ? \n")
            selection = str(input("Y/N :" + "\n"))
            if((selection == 'Y') or (selection == 'y')):
                logout = 1
                return logout
    
    if valid_admin_login:
        while(True):
            admin_operation = adminOperations(admin_username,cnx)
            if (admin_operation == 3):
                logout = 1
                return logout
                        
    # Close the cursor and database connection
    cursor.close()
    cnx.close()
