class RecipeForm:
    def __init__(self, db):
        self.id = None
        self.name = ''
        self.author_id = None
        self.author_name = ''
        self.difficulty = ''
        self.likes = 0
        self.img = ''
        self.body = ''
        self.author_url = ''
        self.ingredients = ()
        self.tags = ()
        self.constraints = ()

        self.db = db

    def save(self):
        pass