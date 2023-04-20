# -*- coding: utf-8 -*-
#from main import cnx

def createJob(admin_username,cnx):
    job_lvl={"I":"Easy Job","II":"Medium Level Job","III":"Hard Job","IV":"Boss level job"}
    emp_id_temp = "SELECT employer_id FROM employer WHERE user_name = %s"
    cursor = cnx.cursor()
    
    
    while(True):
       print("Enter Job Details: \n")
       job_id = int(input("Enter job id: \n"))
       job_name = int(input("Enter job name: \n"))
       job_description = str(input("Enter the job description: \n"))
       
       while(True):
           job_lvl = str(input("Enter job level (I,II,III or IV): \n"))
           if (job_lvl == 'I'):
               job_level_desc = job_lvl.get('I')
               break
           elif(job_lvl == 'II'):
               job_level_desc = job_lvl.get('II')
               break
           elif(job_lvl == 'III'):
               job_level_desc = job_lvl.get('III')
               break
           elif(job_lvl == 'IV'):
               job_level_desc = job_lvl.get('IV')
               break
           else:
               print("Job level invalid, select a level from I,II,III and IV \n")
       
       while(True):
           job_category = str(input("Enter whether the job is for graduate or undergraduate students: \n"))
           
           if((job_category=='Graduate') or (job_category == 'Undergraduate') or (job_category=='graduate') or (job_category=='undergraduate')):
               break
           else:
               print("Enter a valid input \n")
               
       location = str(input("Enter the location of the job: \n"))
       skills = str(input("Enter the skills required for the job: \n"))
       
       
       while(True):
           mode_of_work = str(input("Enter the mode"))
           if((mode_of_work=='Online') or (mode_of_work == 'Offline') or (mode_of_work=='online') or (mode_of_work=='offline') or (mode_of_work == 'remote') or
              (mode_of_work == 'in person') or (mode_of_work == 'In person')):
               break
           else:
               print("Enter a valid input \n")
     
       created_by = "Username: " + admin_username + "Id: " + emp_id_temp + "\n"
       salary = int(input("Enter the hourly salary of the job: \n"))
       contract_period = int(input("Enter the contract period of this job: \n"))
       working_hrs = int(input("Enter the number of working hours per week: \n"))
       
       submit = int(input("Do you want to submit \n 1. Submit\n 2. Recreate job application \n 3.Return to Previous menu \n"))
       if submit == 1:
           args=(job_id,job_name,job_description,job_lvl,job_level_desc,job_category,location,skills,mode_of_work,created_by,salary,contract_period,working_hrs)
           cursor.callproc("create_job",args)
           print("Job successfully created")
           selection = int(input("Press 1 to return to previous menu \n"))
           if (selection == 1):
               return 1
       elif submit == 2:
           continue
       elif submit == 3:
           return 1
       
           
       



