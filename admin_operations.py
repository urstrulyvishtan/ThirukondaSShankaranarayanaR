# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 06:58:11 2023

@author: ivarr
"""
from first import cnx
from create_job import createJob
from update_job_status import updateJob

def adminOperations(admin_username):
    
    while(True):
        cursor = cnx.cursor()
        emp_id_temp = "SELECT employer_id FROM employer WHERE user_name = %s"
        emp_id = cursor.execute(emp_id_temp, admin_username)
        print("Welcome " + emp_id + "! \n" )
        print("1. Create Applications \n")
        print("2. Update Application status \n")
        print("3. Logout \n")
        admin_operation = int(input("Enter a number from the above menu:"))
        if(admin_operation == 1):
           flag = createJob(admin_username) 
           if(flag == 1):
               continue
        
        elif(admin_operation == 2):
           updateJob(admin_username,cnx)
        
        elif(admin_operation == 3):
           return admin_operation
       
    cursor.commit()
    cursor.close()
