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
        self.prep_time = ''

        self.db = db

    def update(self):
        body = self.body.split('\r\n\r\n')
        prep_time = (f'{self.prep_time[:2]} hours '
                     if self.prep_time[:2] != '00' else '') + f'{self.prep_time[3:]} minutes'
        print(prep_time, flush=True)

        # update body
        self.db.save(
            f'''
                UPDATE RECIPES
                SET name='{self.name}', difficulty='{self.difficulty}', body=array{body}, preparation_time=interval '{prep_time}'
                WHERE id_recipe={self.id};
            '''
        )

        # update utensil
        # TODO

        # update ingredients
        # TODO

        # update tags
        # TODO

    def insert(self):
        # TODO
        pass
