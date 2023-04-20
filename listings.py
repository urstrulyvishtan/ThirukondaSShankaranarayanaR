from first_page import first_page
from job_details import job_details
from main import cnx


def listings():
    # create a cursor object
    cursor = cnx.cursor()

    # Display Job ID and Job Description
    display_query = "SELECT job_id, job_name FROM job_posting"
    cursor.execute(display_query)

    # Prompt user to enter a job ID
    job_id = input("Enter a job ID to view details OR Enter 0 to go back")
    if job_id == 0:
        first_page()
    else :
        job_details(job_id)

    # Close the cursor and database connection
    cursor.close()
    cnx.close()
