class RecipeList:
    def __init__(self, db):
        self.recipes = []
        self.db = db

    def load(self):
        self.recipes = self.get_recipes()

    def get_recipes(self):
        names = self.db.exec(
            '''
                SELECT * FROM recipe_list;
            '''
        )
        print(names, flush=True)
        return names
