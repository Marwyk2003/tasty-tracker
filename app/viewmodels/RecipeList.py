class RecipeList:
    def __init__(self, db):
        self.recipes = []
        self.db = db

    def load(self):
        self.recipes = self.get_recipes()

    def get_recipes(self):
        res = [[{
            'name': f'recipe_{x * 4 + y + 1}',
            'url': f'/recipe/{x * 4 + y + 1}',
            'img': ''
        } for y in range(4)] for x in range(5)]
        return res
