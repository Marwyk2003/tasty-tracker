class RecipeList:
    def __init__(self, db):
        self.recipes = []

        self.db = db

    def load(self):
        query = self.db.exec(
            '''
                SELECT * FROM recipe_list;
            '''
        )
        for x in query:
            [rid, name, difficulty, prep_time, _, likes] = x
            url = f'/recipe/{rid}'
            self.recipes += [[name, difficulty, prep_time, likes, url]]
        print(self.recipes, flush=True, sep=', ')
        return query
