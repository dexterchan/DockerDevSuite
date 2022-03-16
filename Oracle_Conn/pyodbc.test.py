import pyodbc 

server = 'oracle-test-python.cy3ylx59tk53.us-east-1.rds.amazonaws.com'
driver = "Oracle 21 ODBC driver"
database = 'ORCL' 
username = 'admin' 
password = "" 
servicename = f"{server}:1521/{database}"

cnxn = pyodbc.connect('DRIVER={{{}}};dbq={};uid={};pwd={}'\
						.format(driver, servicename,  username, password))
cursor = cnxn.cursor()

cursor.execute("SELECT 1+2 from dual") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()