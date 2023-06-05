class RecipeList:
    def __init__(self, db):
        self.recipes = []

        self.db = db

    def load(self):
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
