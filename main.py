import mysql.connector



username = input("Enter your MySQL username: ")
password = input("Enter your MySQL password: ")
try:
    cnx = mysql.connector.connect(user=username, password=password,
                                  host='localhost',
                                  database='LibraryDB')
    print("Connection successful!")

except mysql.connector.Error as err:
    print(f"Error connecting to MySQL: {err}")


cursor = cnx.cursor()

# Call the SQL procedure to delete an application
args = (1,)
cursor.callproc('delete_application', args)

# Commit the transaction
cnx.commit()

# Close the cursor and database connection
cursor.close()
cnx.close()