class Recipe:
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

    def load(self, id):
        self.id = id
        self.name, self.author_id, self.author_name, self.difficulty, self.likes, self.img, self.body = self.get_body(id)
        self.author_url=f'/user/{self.author_id}'
        self.ingredients = self.get_ingredients(id)
        self.tags = self.get_tags(id)
        self.constraints = self.get_constraints(id)

    def get_body(self, id):
        # (name, author, likes, img, body)
        res = ('name', 1, 'author', 'easy', 172, '',
               '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean posuere nulla at massa cursus porta. Proin molestie sapien eget turpis aliquam, vel placerat neque cursus. Praesent in libero viverra, fringilla neque quis, porta lectus. Phasellus placerat leo eu urna euismod semper vel facilisis eros. Aenean ullamcorper eleifend leo, sed iaculis nisl gravida nec. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed ex vitae diam vestibulum elementum quis sit amet est. Nullam pretium diam ipsum, eget vehicula lacus accumsan ac. In hac habitasse platea dictumst. Mauris et fermentum nunc, eget consequat est.
               Etiam aliquet ut ante tempus tempor.Nam id scelerisque massa.Pellentesque sit amet dictum tellus.Curabitur non luctus eros, a varius ligula.Maecenas at semper ipsum.Quisque molestie ultrices libero sed maximus.Suspendisse non libero iaculis, scelerisque ante et, sodales leo.Proin eleifend, ex tincidunt mattis ultrices, sem tellus volutpat dui, sit amet accumsan nisi metus et arcu.Etiam suscipit velit vitae justo dictum, eu hendrerit elit feugiat.Nam elementum quis ex porta pretium.Duis vel lacus non dolor pretium malesuada at a lectus.Quisque in eros non odio venenatis ornare.Proin id rhoncus felis.Cras ac dui at metus finibus feugiat.
               Sed mollis risus eu orci sollicitudin, id condimentum turpis molestie.Phasellus vel risus massa.Proin tristique risus nunc.Nunc ullamcorper sapien ac nulla semper molestie.Ut et odio turpis.Vestibulum nulla justo, congue ut efficitur at, aliquam ac lectus.Mauris a mauris aliquet, volutpat nunc ac, porttitor nulla.Phasellus placerat ex quis dolor efficitur, ultricies tempus nibh egestas.Nullam varius in justo non euismod.Proin justo dolor, efficitur eget metus sed, mattis commodo enim.
               Ut vestibulum, sapien sed semper vestibulum, quam leo sodales massa, ac sagittis mi neque sed neque.Praesent efficitur luctus malesuada.Nullam nibh nunc, maximus eget volutpat eu, rutrum vel leo.Phasellus elementum dui ligula, eget finibus risus hendrerit eget.Phasellus fringilla ante eget massa posuere hendrerit.Sed in nulla in risus convallis porta.Sed sed tincidunt magna.
               Morbi nec ex quis sapien ultrices placerat.Nunc sed imperdiet ex.Quisque maximus volutpat rhoncus.Donec cursus tellus vel dui rutrum, nec scelerisque orci feugiat.Aenean eget cursus velit.Vivamus sed ex at ex ullamcorper faucibus nec id turpis.Praesent est tellus, maximus quis massa in, rhoncus cursus augue.Curabitur libero sapien, imperdiet et ultricies nec, interdum sed lectus.'''.split(
                   '\n'))
        return res

    def get_ingredients(self, id):
        # ((name, amount, unit), ...)
        res = (('ingredient_1', 200, 'ml'),
               ('ingredient_2', 150, 'g'),
               ('ingredient_3', 2, 'tsp'),
               ('ingredient_4', 1, 'piece'),
               ('ingredient_5', 1000, 'g'))
        return res

    def get_tags(self, id):
        # (name, ...)
        res = ('tag_1', 'tag_2', 'tag_3')
        return res

    def get_constraints(self, id):
        # (name, ...)
        res = ('constraint_1', 'constraint_1', 'constraint_1')
        return res
