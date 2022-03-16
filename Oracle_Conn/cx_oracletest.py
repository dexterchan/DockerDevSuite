import cx_Oracle
password = ""
connection = cx_Oracle.connect(user="admin", password=password,
                               dsn="oracle-test-python.cy3ylx59tk53.us-east-1.rds.amazonaws.com/ORCL")

# Obtain a cursor
cursor = connection.cursor()

cursor.execute("SELECT 1+2 FROM dual")

for v in cursor:
    print("Values:", v)