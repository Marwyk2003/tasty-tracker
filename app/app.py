import time
import random

import psycopg2
import psycopg2 as psycopg2

db_name = 'database'
db_user = 'username'
db_pass = 'secret'
db_host = 'db'
db_port = '5432'

# Connect to the database
db_string = 'postgresql://{}:{}@{}:{}/{}'.format(db_user, db_pass, db_host, db_port, db_name)

if __name__ == '__main__':
    conn = psycopg2.connect(
        database=db_name, user=db_user,
        password=db_pass, host=db_host, port=db_port
    )
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO numbers VALUES (1,2);
    ''')
    conn.commit()

    cursor.execute('''
                SELECT * FROM numbers;
            ''')
    res = cursor.fetchall()
    print(res)

    if (conn):
        cursor.close()
        conn.close()
