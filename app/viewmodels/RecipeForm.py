class RecipeForm:
    def __init__(self, db):
        self.id = None
        self.name = ''
        self.author = ''
        self.difficulty = ''
        self.utensil = ''
        self.body = ''
        self.ingredients = []
        self.tags = ()

        self.db = db

    def save(self):
        print(self.name, self.difficulty, self.utensil, self.body, self.ingredients, flush=True, sep="\n\n\ns")

