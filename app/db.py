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
        self.connection = psycopg2.connect(
            database=db_name, user=db_user,
            password=db_pass, host=db_host, port=db_port
        )
        self.cursor = self.connection.cursor()

    def quit(self):
        if self.connection:
            self.cursor.close()
            self.connection.close()

    def get_recipe_body(self, id):
        pass

    def get_recipe_ingredients(self, id):
        pass

    def get_recipe_tags(self, id):
        pass

    def get_recipe_constraints(self, id):
        pass
