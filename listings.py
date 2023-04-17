from main import cnx

#create a cursor object
cursor = cnx.cursor()

# Display Job ID and Job Description
display_query = "SELECT job_id, job_name FROM job_posting"

# Prompt user to enter a job ID
job_id = input("Enter a job ID to view details: ")


# Close the cursor and database connection
cursor.close()
cnx.close()