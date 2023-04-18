from main import cnx
from first_page import application_option


#create a cursor object
cursor = cnx.cursor()

if application_option == 1:
    # Display Job ID and Job Description
    display_query = "SELECT job_id, job_name FROM job_posting"

    # Prompt user to enter a job ID
    job_id = input("Enter a job ID to view details: ")


# Close the cursor and database connection
cursor.close()
cnx.close()