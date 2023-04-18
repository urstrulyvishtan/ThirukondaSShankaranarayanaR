from job_details import option
from listings import job_id
from main import cnx
import os

cursor = cnx.cursor()

if option == 1:
    # while True:
    print("Enter your education details")
    school = input("School Name : ")
    degree = input("Degree :")
    gpa = input("GPA : ")

    add_edu = input(" Do you want to add another Education? Yes/No")

    #   if add_edu == "No":
    #      break

    # while True:
    print("Enter your Work experience")
    company = input("Company Name : ")
    role = input("Role : ")
    months_of_exp = input("Experience in Months : ")
    role_desription = input(" Give short description of your role")

    add_exp = input(" Do you want to add another Experience? Yes/No")

    #   if add_exp == "No":
    #      break

    # while True:
    print("Enter your projects")
    project_title = input("title of project")
    project_description = input("Description of Project")

    add_proj = input(" Do you want to add another project? Yes/No")

    #   if add_proj == "No":
    #      break

    resume_file = input("Enter the path to your resume file: ")

    # Save the resume file in the resume table
    if os.path.isfile(resume_file):
        with open(resume_file, 'rb') as f:
            resume_data = f.read()
            print("Review your responses : ")
            print("Job ID", job_id)
            print("School", school)
            print("degree", degree)
            print("gpa", gpa)
            print("\n")
            print("Company", company)
            print("Role", role)
            print("Months of Experience", months_of_exp)
            print("Role Description", role_desription)
            print("\n")
            print("Projects")
            print("Project title", project_title)
            print("Project description", project_description)
            print("Attached resume", resume_file)

            submit = input("Do you want to submit \n 1. Submit\n 2. Go Back")
            if submit == 1:
                insert_query = "INSERT INTO resume (job_id, school, degree, gpa, company, role, months_of_exp, " \
                               "role_desc, " \
                               "project_title, project_description, resume_file) VALUES (%s, %s, %s, %s, %s, %s, %s, " \
                               "%s, " \
                               "%s, %s, %s) "
                cursor.execute(insert_query, (
                    job_id, school, degree, gpa, company, role, months_of_exp, role_desription, project_title,
                    project_description, resume_data))
                cnx.commit()
                print("Resume file saved successfully.")
            #else :

    else:
        print("Invalid file path. Please enter a valid path.")
