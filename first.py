# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 07:26:59 2023

@author: ivarr
"""
from admin_login import adminLogin
from login import login
import mysql.connector

    
    
if '__main__' == True:
    def first():
        username = input("Enter your MySQL username: ")
        password = input("Enter your MySQL password: ")
        try:
            cnx = mysql.connector.connect(user=username, password=password,
                                          host='localhost',
                                          database='LibraryDB')
            print("Connection successful!")
    
        except mysql.connector.Error as err:
            print(f"Error connecting to MySQL: {err}")
        
        while(True):
            print ("Hello User!")
            print("Press 1 for student login")
            print("Press 2 for admin login")
            print("Press 3 for exit")
            login_selection = int(input("Enter a number: "+"\n"))
            if(login_selection == 1):
                login()
            elif(login_selection == 2):
                while(True):
                    logout = adminLogin()
                    if (logout == 1):
                        print("Thank you")
                        break
            elif(login_selection == 3):
                print("Thank you")
                exit(0)
    
    