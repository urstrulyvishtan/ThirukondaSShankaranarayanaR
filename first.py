# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 07:26:59 2023

@author: ivarr
"""
from admin_login import adminLogin
from login import login
def first():
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
    
    