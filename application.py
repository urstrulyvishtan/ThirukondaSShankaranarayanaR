from job_details import option
from main import cnx

cursor = cnx.cursor()

if option == 1:
    print("Enter your education details")
    school = input("School Name : ")
    degree = input("Degree :")
