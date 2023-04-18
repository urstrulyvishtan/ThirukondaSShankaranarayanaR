from main import cnx
import getpass

# Create a cursor object
username = input("Enter your username: ")
password = getpass.getpass("Enter your password: ")
cursor = cnx.cursor()

# Call the SQL procedure
args = (username, password)
result_args = cursor.callproc('validate_login_credentials', args)

# Get the output parameter value
valid_login = result_args[2]

# Check if the login credentials are valid
if valid_login:
    print("Login successful!")
else:
    print("Invalid username or password.")


# Close the cursor and database connection
cursor.close()
cnx.close()
