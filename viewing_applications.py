from first_page import application_option, nuid
from main import cnx

if application_option == 2 :
    cursor = cnx.cursor()
    args = nuid
    result = cursor.callproc('view_applications', args)