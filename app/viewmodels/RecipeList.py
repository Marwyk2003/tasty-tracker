class RecipeList:
    def __init__(self, db, user_id):
        self.recipes = []
        self.user_id = user_id
        self.login_msg = 'Log in'

        self.db = db

    def load(self):
        self.login_msg = 'Log in' if self.user_id is None else 'Log out'
        query = self.db.exec(
            '''
                SELECT * FROM top_recipes
            '''
        )
        for x in query:
            [rid, name, difficulty, prep_time, _, likes] = x
            url = f'/recipe/{rid}'
            self.recipes += [[name, difficulty, prep_time, likes, url]]
        return query
