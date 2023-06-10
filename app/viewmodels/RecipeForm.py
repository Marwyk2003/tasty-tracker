from datetime import datetime


class RecipeForm:
    def __init__(self, db, id, user_id, edit):
        self.id = id
        self.name = ''
        self.author = user_id
        self.difficulty = ''
        self.utensil = ''
        self.body = ''
        self.ingredients = []
        self.tags = ()
        self.prep_time = ''

        self.edit_mode = edit
        self.db = db

    def update(self):
        body = [x.replace('\n', '<br/>') for x in self.body.replace('\r', '').split('\n\n')]
        prep_time = (f'{self.prep_time[:2]} hours '
                     if self.prep_time[:2] != '00' else '') + f'{self.prep_time[3:]} minutes'

        # update body
        if self.edit_mode:
            self.db.save(
                f'''
                    UPDATE RECIPES
                    SET name='{self.name}', difficulty='{self.difficulty}', body=array{body}, preparation_time=interval '{prep_time}'
                    WHERE id_recipe={self.id};
                '''
            )
        else:
            self.id = self.db.insert(
                f'''
                    INSERT INTO RECIPES
                    VALUES (DEFAULT, '{self.name}', {self.author}, 1, '{datetime.now()}', '{self.difficulty}', interval '{prep_time}', array{body}, 1, 1)
                    RETURNING id_recipe
                '''
            )[0]

        # update utensil
        # TODO

        # update ingredients
        ing = [x for x in self.ingredients if x != ['.', '1.0', 'g']]
        if len(ing) > 0:
            names, amounts, units = zip(*ing)
            names = list(names)
            amounts = [float(x) for x in amounts]
            units = list(units)
            category = [1 for x in range(len(names))]  # TODO
            self.db.save(
                f'''
                    SELECT add_all_ingredients({self.id}, array{names}::varchar(60)[], array{category}::integer[], array{amounts}::numeric(6,2)[], array{units}::unit_enum[])
                '''
            )

        # update tags
        # TODO

    def insert(self):
        # TODO
        pass
