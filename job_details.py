from listings import job_id
from main import cnx

# create Cusror object
cursor = cnx.cursor()

# Execute SELECT query to retrieve job details for the entered ID
select_query = "SELECT * FROM job_posting WHERE job_id = %s"
data = (job_id,)
cursor.execute(select_query, data)
result = cursor.fetchone()

# Display job ID and job description
if result:
    print("Job ID:", result[0])
    print("Job Name:", result[1])
    print("Job Description:", result[2])
    print("Job Level:", result[3])
    print("Job Category", result[4])
    print("Job Location", result[5])
    print("Job Skills", result[6])
    print("Mode of Work", result[7])
    print("Posted by", result[8])
    print("Salary", result[9])
    print("level of work", result[10])
    print("Working hours", result[11])
    print("\n")
    print("Would you like to \n1.Apply \n2.Go Back ")
    option = input()
else:
    print("No job found with the entered ID.")

# Close the cursor and database connection
cursor.close()
cnx.close()