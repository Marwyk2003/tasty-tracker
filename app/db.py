import psycopg2

db_name = 'database'
db_user = 'username'
db_pass = 'secret'
db_host = 'db'
db_port = '5432'

# Connect to the database
db_string = 'postgresql://{}:{}@{}:{}/{}'.format(db_user, db_pass, db_host, db_port, db_name)


class Database:
    def __init__(self):
        pass

    def exec(self, query):
        connection = psycopg2.connect(
            database=db_name, user=db_user,
            password=db_pass, host=db_host, port=db_port
        )
        cursor = connection.cursor()
        try:
            cursor.execute(query)
            return cursor.fetchall()
        finally:
            connection.commit()
            cursor.close()
            connection.close()

    def save(self, query):
        connection = psycopg2.connect(
            database=db_name, user=db_user,
            password=db_pass, host=db_host, port=db_port
        )
        cursor = connection.cursor()
        try:
            cursor.execute(query)
        finally:
            connection.commit()
            cursor.close()
            connection.close()

    def insert(self, query):
        connection = psycopg2.connect(
            database=db_name, user=db_user,
            password=db_pass, host=db_host, port=db_port
        )
        cursor = connection.cursor()
        try:
            cursor.execute(query)
            return cursor.fetchone()
        finally:
            connection.commit()
            cursor.close()
            connection.close()
