class Recipe:
    def __init__(self, db, recipe_id, user_id):
        self.id = recipe_id
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
        self.ingredients = [('', '', '', False) for x in range(15)]
        self.tags = ()
        self.constraints = ()
        self.comments = ()
        self.liked = False

        self.db = db
        self.user_id = user_id

    def load(self):
        self.name, self.author_name, self.author_id, self.utensil, self.timestamp, \
            self.body, self.difficulty, prep_time, self.likes = \
            self.get_body()
        self.prep_time = f'{prep_time.seconds // 3600:02d}:{prep_time.seconds % 3600 // 60:02d}'
        self.author_url = f'/user/{self.author_id}'
        self.ingredients = self.get_ingredients()
        self.tags = self.get_tags()
        self.constraints = self.get_constraints()
        self.comments = self.get_comments()
        self.liked = self.is_liked()

    def load_empty(self):
        self.ingredients = [['.', '1.0', 'g', False]] * 15

    def get_body(self):
        query = self.db.exec(
            f'''
                SELECT * FROM basic_from_recipe({self.id});
            '''
        )
        body = query[0]
        return body

    def get_ingredients(self):
        query = self.db.exec(
            f'''
                SELECT * from products_from_recpie({self.id});
            '''
        )
        res = [list(x) + [True] for x in query]
        res += [['.', '1.0', 'g', False]] * (15 - len(res))
        return res

    def get_tags(self):
        query = self.db.exec(
            f'''
                SELECT * from tags_from_recipe({self.id});
            '''
        )
        res = [tag[0] for tag in query]
        return res

    def get_constraints(self):
        query = self.db.exec(
            f'''
                SELECT * from restrictions_from_recipe({self.id});
            '''
        )
        res = [x[0] for x in query]
        return res

    def get_comments(self):
        query = self.db.exec(
            f'''
                SELECT * FROM comments_from_recipe({self.id});
            '''
        )
        comments = []
        for x in query:
            comments += [list(x) + [None]]
        return comments

    def change_like(self):
        if self.user_id is None:
            return
        if self.liked:
            self.db.save(
                f'''
                    SELECT del_like({self.id}, {self.user_id})
                '''
            )
        else:
            self.db.save(
                f'''
                    SELECT add_like({self.id}, {self.user_id})
                '''
            )

    def is_liked(self):
        if self.user_id is None:
            return False
        return self.db.exec(
            f'''
                SELECT * from is_liked({self.id}, {self.user_id})
            '''
        )[0][0]

    def is_author(self):
        if self.user_id is None:
            return False
        return self.author_id == self.user_id
