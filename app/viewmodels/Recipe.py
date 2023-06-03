class Recipe:
    def __init__(self, db):
        self.id = None
        self.name = ''
        self.author_id = None
        self.author_name = ''
        self.utensil = ''
        self.timestamp = ''
        self.difficulty = ''
        self.prep_time = ''
        self.likes = 0
        self.img = ''
        self.body = ''
        self.author_url = ''
        self.ingredients = [('', '', '') for x in range(15)]
        self.tags = ()
        self.constraints = ()
        self.comments = ()

        self.db = db

    def load(self, id):
        self.id = id
        self.name, self.author_name, self.utensil, self.timestamp, \
            self.body, self.difficulty, prep_time, self.likes = \
            self.get_body(id)
        self.prep_time = f'{prep_time.seconds // 3600:02d}:{prep_time.seconds % 3600 // 60:02d}'
        self.author_url = f'/user/{self.author_id}'
        self.ingredients = self.get_ingredients(id)
        self.tags = self.get_tags(id)
        self.constraints = self.get_constraints(id)
        self.comments = self.get_comments(id)

    def get_body(self, id):
        # (name, author, likes, img, body)
        query = self.db.exec(
            f'''
                SELECT * FROM basic_from_recipe({id});
            '''
        )
        body = query[0]
        return body

    def get_ingredients(self, id):
        query = self.db.exec(
            f'''
                SELECT * from products_from_recpie({id});
            '''
        )

        # ((name, amount, unit), ...)
        # res = (('ingredient_1', 200, 'ml'),
        #        ('ingredient_2', 150, 'g'),
        #        ('ingredient_3', 2, 'tsp'),
        #        ('ingredient_4', 1, 'piece'),
        #        ('ingredient_5', 1000, 'g'))
        res = [list(x) for x in query]
        res += [['', '', '']] * (15 - len(res))
        return res

    def get_tags(self, id):
        query = self.db.exec(
            f'''
                SELECT * from tags_from_recipe({id});
            '''
        )
        # (name, ...)
        # res = ('tag_1', 'tag_2', 'tag_3')
        res = [tag[0] for tag in query]
        return res

    def get_constraints(self, id):
        # (name, ...)
        # res = ('constraint_1', 'constraint_1', 'constraint_1')
        query = self.db.exec(
            f'''
                SELECT * from restrictions_from_recipe({id});
            '''
        )
        # (name, ...)
        # res = ('tag_1', 'tag_2', 'tag_3')
        res = [x[0] for x in query]
        return res

    def get_comments(self, id):
        # (comment_id, username, content, parent)
        query = self.db.exec(
            f'''
                SELECT * FROM comments_from_recipe({id});
            '''
        )
        comments = []
        for x in query:
            comments += [list(x) + [None]]
        return comments
