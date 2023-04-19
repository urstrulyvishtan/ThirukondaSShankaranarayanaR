# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 06:58:11 2023

@author: ivarr
"""

def adminOperations(admin_username,cnx):
    cursor = cnx.cursor()
    emp_id_temp = "SELECT employer_id FROM employer WHERE user_name = %s"
    emp_id = cursor.execute(emp_id_temp, admin_username)
    print("Welcome " + emp_id + "! \n" )
    print("1. Create Applications \n")
    print("2. Update Application status \n")
    print("3. Logout \n")
    admin_operation = int(input("Enter a number from the above menu:"))
    return admin_operation