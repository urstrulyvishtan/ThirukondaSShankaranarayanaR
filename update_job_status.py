# -*- coding: utf-8 -*-
"""
Created on Thu Apr 20 20:13:41 2023

@author: ivarr
"""
from first import cnx

def updateJob(admin_username):
    cursor = cnx.cursor()
    job_id =int(input("Enter the job_id to change status: \n"))
    # Check if job_id exists in db
    cursor.callproc("update_job_status",[job_id,"Closed"])
    cursor.commit()
    cursor.close()
    