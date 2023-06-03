import random


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
        self.ingredients = [('', '', '') for x in range(15)]
        self.tags = ()
        self.constraints = ()
        self.comments = ()
        self.liked = None

        self.db = db
        self.user_id = user_id

    def load(self):
        self.name, self.author_name, self.utensil, self.timestamp, \
            self.body, self.difficulty, prep_time, self.likes = \
            self.get_body()
        self.prep_time = f'{prep_time.seconds // 3600:02d}:{prep_time.seconds % 3600 // 60:02d}'
        self.author_url = f'/user/{self.author_id}'
        self.ingredients = self.get_ingredients()
        self.tags = self.get_tags()
        self.constraints = self.get_constraints()
        self.comments = self.get_comments()
        self.liked = self.get_like()

    def get_body(self):
        # (name, author, likes, img, body)
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

        # ((name, amount, unit), ...)
        # res = (('ingredient_1', 200, 'ml'),
        #        ('ingredient_2', 150, 'g'),
        #        ('ingredient_3', 2, 'tsp'),
        #        ('ingredient_4', 1, 'piece'),
        #        ('ingredient_5', 1000, 'g'))
        res = [list(x) for x in query]
        res += [['', '', '']] * (15 - len(res))
        return res

    def get_tags(self):
        query = self.db.exec(
            f'''
                SELECT * from tags_from_recipe({self.id});
            '''
        )
        # (name, ...)
        # res = ('tag_1', 'tag_2', 'tag_3')
        res = [tag[0] for tag in query]
        return res

    def get_constraints(self):
        # (name, ...)
        # res = ('constraint_1', 'constraint_1', 'constraint_1')
        query = self.db.exec(
            f'''
                SELECT * from restrictions_from_recipe({self.id});
            '''
        )
        # (name, ...)
        # res = ('tag_1', 'tag_2', 'tag_3')
        res = [x[0] for x in query]
        return res

    def get_comments(self):
        # (comment_id, username, content, parent)
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
        self.liked = not self.liked
        if (self.liked):
            self.db.exec(
                f'''
                    SELECT add_like({self.id, self.user_id} 
                '''
            )
        else:
            self.db.exec(
                f'''
                    SELECT del_like({self.id, self.user_id} 
                '''
            )

    def get_like(self):
        if self.user_id is None:
            return False
        return self.db.exec(
            f'''
                SELECT is_liked({self.id, self.user_id}
            '''
        )
