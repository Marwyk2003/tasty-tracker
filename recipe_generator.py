import urllib.request
import random
import re

if __name__ == '__main__':
    difficulties = {1: 'very easy', 2: 'easy', 3: 'medium', 4: 'hard', 5: 'very hard'}

    recipes = {'strawberry-cardamom-traybake':'Strawberry Cardamon Cake',
               'blueberry-lemon-thyme-friands':'Bluberry Lemon Thyme Friands',
               'raspberry-orange-cheesecake':'Raspberry Orange Cheescake',
               'chocolate-dipped-madeleines':'Chocolate Dipped Madeleines',
               'pane-di-pasqua':'Pane di Pasqua',
               'torta-caprese-with-amaretto-cream':'Tarta Caprese with Amaretto Cream',
               'revani':'Revani',
               'key-lime-pie-buns':'Lime Pie Buns',
               'sticky-coffee-pudding':'Sticky CoffeePudding',
               'chocolate-date-cake':'Chocolate Date Cake',
               'mincemeat-meringue-tarts':'Mincemeat Meringue Tarts',
               'lemon-blueberry-meringues':'Lemon Blueberry Meringues',
               'fresh-cherry-bakewell-tarts':'Fresh Cherry Bakewell Tarts',
               'cherry-chocolate-lava-puddings':'Cherry Chocolate Lava Puddings',
               'strawberry-cream-choux-buns':'Strawberry Cream Choux Buns',
               'nectarine-marzipan-tart':'Nectarine Marzipan Tart',
               'blueberry-lattice-pie':'Blueberry Lattice Pie',
               'jelly-and-custard-celebration-cake':'Jelly and Custard Celebration Cake',
               'mint-chocolate-cheesecake':'Mint Chocolate Cheesecake',
               'blueberry-burnt-basque-cheesecake':'Blueberry Burnt Basque Cheescake',
               'saffron-cardamom-pavlova':'Saffron Cardamon Pavlova',
               'chocolate-almond-simnel-cake':'Chocolate Almond Simnel Cake',
               'easter-carrot-patch-traybake':'Easter Carrot Patch Traybake',
               'choc-chip-cookie-cups':'Choc Chip Cookie Cups',
               'christmas-pudding-doughnuts':'Christmas Pudding Doughnuts',
               'grape-almond-clafoutis':'Grape Almond Clafoutis',
               'pumpkin-caramel-ginger-baked-cheesecake':'Pumpkin Caramel Ginger Baked Cheescake',
               'cinnamon-bun-pudding':'Cinnamon Bun Pudding',
               'deep-dish-apple-pie':'Deep Dish Apple Pie',
               'raspberry-almond-galette':'Raspberry Almond Galette',
               'avocado-chocolate-tart-with-candied-tangerine':'Avocade Chocolate Tart with Candied Tangerine',
               'icce-cream-cookie-cups':'Ice Cream Cookie Cups',
               'cherry-and-almond-baklava':'Cherry and Almond Baklava',
               'chocolate-and-salted-caramel-traybake':'Chocolate and Salted Caramel Traybake',
               'passion-fruit-drizzle-cake': 'Passion Fruit Drizzle Cake',
               'apple-and-vanilla-babka': 'Apple and Vanilla Babka',
               'marthas-raspberry-ripple-cake': 'Raspberry Ripple Cake',
               'strawberry-praline-roulade': 'Strawberry Praline Roulade',
               'marthas-lemon-blueberry-bundt-cake': 'Lemon Blueberry Boundt Cake',
               'baked-strawberry-cheesecake': 'Baked Strawberry Cheescake',
               'flourless-chocolate-cloud-cake': 'Flourless Chocolate Cloud Cake',
               'guinness-and-chocolate-cupcakes': 'Guinness and Chocolate Cupcakes',
               'raspberry-cream-shortbreads': 'Raspberry Cream Shortbreads',
               'festive-spiced-apple-bundt-cake': 'Festive Spiced Apple Boundt Cake',
               'mince-pie-streusel-tart': 'Mince Pie Streusel Tart',
               'banana-cinnamon-cake': 'Banana Cinnamon Cake',
               'mini-pear-strudels': 'Mini Pear Strudels',
               'plum-and-almond-cake': 'Plum and Almond Cake',
               'meringue-kisses': 'Meringue Kisses',
               'coconut-and-raspberry-loaf-cake': 'Coconut and Raspberry Loaf Cake',
               'lemon-cheesecake-with-summer-berries': 'Lemon Cheescake with Summer Berries',
               'caramelised-chocolate-blondies': 'Caramelised Chocolate Blondies',
               'strawberry-camomile-shortcakes': 'Strawberry Camomile Shortcake',
               'strawberry-mascarpone-lemon-curd-tart': 'Strawberry Mascarpone Lemon Curt Tart',
               'chocolate-cardamom-and-coffee-mini-bundt-cakes': 'Chocolate Cardamom and Coffee Mini Boundt Cakes',
               'nutty-simnel-cake': 'Nutty Simnel Cake',
               'black-velvet-brownies': 'Black Velvet Brownies',
               'martha-collisons-christmas-pudding-macarons': 'Christmas Pudding Macarons',
               'martha-collisons-gingerbread-yule-log-recipe-waitrose': 'Gingerbread Yule Log',
               'caribbean-black-cake-recipe-waitrose': 'Caribbean Black Cake',
               'mini-peanut-butter-oreo-cups-recipe-waitrose': 'Mini Peanut butter Oreo Cups',
               'marthas-smarties-cookies': 'Smarties Cookies',
               'sticky-chocolate-plum-cake': 'Sticky Chocolate Plum Cake',
               'marthas-perfect-peanut-butter-chocolate-chip-cookies': 'Peanut butter Chocolate chip Cookies',
               'chocolate-dipped-sea-salt-and-rye-digestives': 'Chocolate dipeed Sea salt and Rye Digestives',
               'martha-collisons-plum-streusel-cake': 'Plum Streusel Cake',
               'mini-bakewell-tarts': 'Mini Bakewell Tarts',
               'summer-currant-meringues': 'Summer Currant Meringues',
               'martha-collisons-fondant-fancies': 'Fondant Fancies',
               'martha-collisons-viennese-whirls': 'Viennese Whirls',
               'hot-cross-bun-cinnamon-rolls': 'Hot Cross Bun Cinnamon Rolls',
               'mocha-loaf-cake': 'Mocha Loaf Cake',
               'lemon-simnel-cupcakes': 'Lemon Simnel Cupcakes',
               'blueberry-lemon-poppy-seed-muffins': 'Blueberry Lemon Poppy Seed Muffins',
               'pecan-mocha-brownies': 'Pecan Mocha Brownies',
               'martha-collisons-gingerbread-smore-biscuits': 'Gingerbread Smore Biscuits',
               'vegan-frosted-lemon-cake': 'Vegan Frosted Lemon Cake',
               'marthas-lemon-and-elderflower-loaf-cake': 'Lemon and Elderflower Loaf Cake',
               'chocolate-cherry-brownies': 'Chocolate Cherry Brownies',
               'bruleed-cheesecake': 'Bruleed Cheesecake',
               'martha-collisons-meringue-topped-mince-pies': 'Meringue Topped Mince Pies',
               'date-and-tahini-cookies': 'Tahini Cookies',
               'blackberry-and-bramley-layer-cake': 'Blackberry and Bramley Layer Cake',
               'pomegranate-and-pistachio-cake': 'Pomegranate and Pistachio Cake',
               'end-of-summer-cake': 'End of summer Cake',
               'chocolate-soured-cream-loaf':' Chocolate Soured Cream Loaf',
               'orange-cardamom-shortbread-biscuits': 'Orange Cardamom Shortbread Biscuits',
               'banana-muesli-morning-loaf': 'Banana Muesli Morning Loaf',
               'old-school-cake-recipe': 'Old School Cake',
               'blueberry-frangipane-tart': 'Blueberry Frangipane Tart',
               'double-chocolate-chip-cookies': 'Double Chocolate chip Cookies',
               'ginger-crunch-creams': 'Ginger Crunch Creams',
               'toffee-apple-loaf-cake': 'Toffee Apple Loaf Cake',
               'chocolate-brownie-cookies': 'Chocolate Brownie Cookies',
               'apple-and-blackberry-crumble-pie': 'Apple and Blackberry Crumble Pie',
               'sticky-plum-and-almond-tart': 'Sticky Plum and Almond Tart',
               'banana-cake-with-peanut-butter-frosting': 'Banana Cake with Peanut Butter Frosting',
               'dark-chocolate-persian-lime-tart': 'Dark Chocolate Persian Lime Tart',
               'the-best-eclairs': 'The best Eclairs',
               'chocolate-and-cranberry-cake-recipe-waitrose': 'Chocolate and Cranberry Cake',
               'znud-al-snit-crispy-cream-filled-rolls': 'Znud al sit (Crispy Cream filled Rolls)',
               'lemon-poppyseed-cake': 'Lemon Poppyseed Cake',
               'strawberry-brown-butter-frangipane-tart': 'Strawberry Brown Butter Frangipane Tart'
    }
    forms = {'strawberry-cardamom-traybake': ['rectangular tin', '30', '20'],
               'blueberry-lemon-thyme-friands': ['muffin tin', '36', '26'],
               'raspberry-orange-cheesecake': ['round tin', '22', '22'],
               'chocolate-dipped-madeleines': ['rectangular tin', '36', '26'],
               'pane-di-pasqua': ['round tin with chimney', '22', '22'],
               'torta-caprese-with-amaretto-cream': ['round tin', '22', '22'],
               'revani': ['rectangular tin', '30', '20'],
               'key-lime-pie-buns': ['rectangular tin', '40', '25'],
               'sticky-coffee-pudding': ['ovenproof dish', '30', '19'],
               'chocolate-date-cake': ['round tin', '20', '20'],
               'mincemeat-meringue-tarts': ['rectangular tin', '37', '27'],
               'lemon-blueberry-meringues': ['rectangular tin', '36', '26'],
               'fresh-cherry-bakewell-tarts': ['muffin tin', '36', '26'],
               'cherry-chocolate-lava-puddings': ['rectangular tin', '36', '26'],
               'strawberry-cream-choux-buns': ['rectangular tin', '36', '26'],
               'nectarine-marzipan-tart': ['rectangular tin', '36', '26'],
               'blueberry-lattice-pie': ['tart tin', '23', '23'],
               'jelly-and-custard-celebration-cake': ['round tin', '20', '20'],
               'mint-chocolate-cheesecake': ['round tin', '20', '20'],
               'blueberry-burnt-basque-cheesecake': ['round tin', '20', '20'],
               'saffron-cardamom-pavlova': ['rectangular tin', '36', '26'],
               'chocolate-almond-simnel-cake': ['round tin', '20', '20'],
               'easter-carrot-patch-traybake': ['rectangular tin', '33', '23'],
               'choc-chip-cookie-cups': ['muffin tin', '36', '26'],
               'christmas-pudding-doughnuts': ['rectangular tin', '50', '40'],
               'grape-almond-clafoutis': ['round tin', '25', '25'],
               'pumpkin-caramel-ginger-baked-cheesecake': ['round tin', '23', '23'],
               'cinnamon-bun-pudding': ['ovenproof dish', '30', '19'],
               'deep-dish-apple-pie': ['round tin', '20', '20'],
               'raspberry-almond-galette': ['round tin', '30', '30'],
               'avocado-chocolate-tart-with-candied-tangerine': ['round tin', '26', '26'],
               'icce-cream-cookie-cups': ['muffin tin', '36', '26'],
               'cherry-and-almond-baklava': ['rectangular tin', '23', '23'],
               'chocolate-and-salted-caramel-traybake': ['rectangular tin', '33', '22'],
               'passion-fruit-drizzle-cake': ['loaf tin', '24', '12'],
               'apple-and-vanilla-babka': ['round tin', '20', '20'],
               'marthas-raspberry-ripple-cake': ['round tin', '23', '23'],
               'strawberry-praline-roulade': ['rectangular tin', '32', '23'],
               'marthas-lemon-blueberry-bundt-cake': ['round tin with chimney', '23.5', '23.5'],
               'baked-strawberry-cheesecake': ['round tin', '23', '23'],
               'flourless-chocolate-cloud-cake': ['round tin', '23', '23'],
               'guinness-and-chocolate-cupcakes': ['muffin tin', '36', '26'],
               'raspberry-cream-shortbreads': ['rectangular tin', '36', '26'],
               'festive-spiced-apple-bundt-cake': ['round tin', '23', '23'],
               'mince-pie-streusel-tart': ['tart tin', '24', '24'],
               'banana-cinnamon-cake': ['loaf tin', '24', '12'],
               'mini-pear-strudels': ['rectangular tin', '36', '26'],
               'plum-and-almond-cake': ['round tin', '20', '20'],
               'meringue-kisses': ['rectangular tin', '50', '40'],
               'coconut-and-raspberry-loaf-cake': ['loaf tin', '24', '12'],
               'lemon-cheesecake-with-summer-berries': ['round tin', '23', '23'],
               'caramelised-chocolate-blondies': ['rectangular tin', '30', '20'],
               'strawberry-camomile-shortcakes': ['rectangular tin', '36', '26'],
               'strawberry-mascarpone-lemon-curd-tart': ['tart tin', '23', '23'],
               'chocolate-cardamom-and-coffee-mini-bundt-cakes': ['muffin tin', '36', '26'],
               'nutty-simnel-cake': ['round tin', '20', '20'],
               'black-velvet-brownies': ['rectangular tin', '30', '20'],
               'martha-collisons-christmas-pudding-macarons': ['rectangular tin', '36', '26'],
               'martha-collisons-gingerbread-yule-log-recipe-waitrose': ['rectangular tin', '30', '20'],
               'caribbean-black-cake-recipe-waitrose': ['round tin', '25', '25'],
               'mini-peanut-butter-oreo-cups-recipe-waitrose': ['muffin tin', '36', '26'],
               'marthas-smarties-cookies': ['rectangular tin', '36', '26'],
               'sticky-chocolate-plum-cake': ['round tin', '23', '23'],
               'marthas-perfect-peanut-butter-chocolate-chip-cookies': ['rectangular tin', '50', '40'],
               'chocolate-dipped-sea-salt-and-rye-digestives': ['rectangular tin', '50', '40'],
               'martha-collisons-plum-streusel-cake': ['roung tin with chimney', '22', '22'],
               'mini-bakewell-tarts': ['muffin tin', '36', '26'],
               'summer-currant-meringues': ['rectangular tin', '50', '40'],
               'martha-collisons-fondant-fancies': ['rectangular tin', '20', '20'],
               'martha-collisons-viennese-whirls': ['rectangular tin', '50', '40'],
               'hot-cross-bun-cinnamon-rolls': ['rectangular tin', '50', '40'],
               'mocha-loaf-cake': ['loaf tin', '24', '12'],
               'lemon-simnel-cupcakes': ['muffin tin', '36', '26'],
               'blueberry-lemon-poppy-seed-muffins': ['muffin tin', '36', '26'],
               'pecan-mocha-brownies': ['rectangular tin', '20', '20'],
               'martha-collisons-gingerbread-smore-biscuits': ['rectangular tin', '50', '40'],
               'vegan-frosted-lemon-cake': ['loaf tin', '24', '12'],
               'marthas-lemon-and-elderflower-loaf-cake': ['loaf tin', '24', '12'],
               'chocolate-cherry-brownies': ['rectangular tin', '20', '20'],
               'bruleed-cheesecake': ['round tin', '20', '20'],
               'martha-collisons-meringue-topped-mince-pies': ['muffin tin', '36', '26'],
               'date-and-tahini-cookies': ['rectangular tin', '50', '40'],
               'blackberry-and-bramley-layer-cake': ['round tin', '20', '20'],
               'pomegranate-and-pistachio-cake': ['round tin', '20', '20'],
               'end-of-summer-cake': ['round tin', '20', '20'],
               'chocolate-soured-cream-loaf': ['loaf tin', '24', '12'],
               'orange-cardamom-shortbread-biscuits': ['rectangular tin', '50', '40'],
               'banana-muesli-morning-loaf': ['loaf tin', '24', '12'],
               'old-school-cake-recipe': ['rectangular tin', '33', '22'],
               'blueberry-frangipane-tart': ['tart tin', '25', '25'],
               'double-chocolate-chip-cookies': ['rectangular tin', '50', '40'],
               'ginger-crunch-creams': ['rectangular tin', '50', '40'],
               'toffee-apple-loaf-cake': ['loaf tin', '24', '12'],
               'chocolate-brownie-cookies': ['rectangular tin', '50', '40'],
               'apple-and-blackberry-crumble-pie': ['round tin', '20', '20'],
               'sticky-plum-and-almond-tart': ['round tin', '23', '23'],
               'banana-cake-with-peanut-butter-frosting': ['loaf tin', '24', '12'],
               'dark-chocolate-persian-lime-tart': ['tart tin', '20', '20'],
               'the-best-eclairs': ['rectangular tin', '50', '40'],
               'chocolate-and-cranberry-cake-recipe-waitrose': ['round tin', '25', '25'],
               'znud-al-snit-crispy-cream-filled-rolls': ['rectangular tin', '50', '40'],
               'lemon-poppyseed-cake': ['round tin', '23', '23'],
               'strawberry-brown-butter-frangipane-tart': ['tart tin', '23', '23']
               }
    recipe_ids = {}

    # forms
    allFormsList = [i for i in forms.values()]
    formsList = []
    [formsList.append(x) for x in allFormsList if x not in formsList]
    print('INSERT INTO forms VALUES ')
    id = 1
    for form in formsList:
        if form != formsList[-1]:
            print('(' + str(id) + ', \'' + form[0] + '\', ' + form[1] + ', ' + form[2] + '),')
        else:
            print('(' + str(id) + ', \'' + form[0] + '\', ' + form[1] + ', ' + form[2] + ')')
        id += 1
    print(';')

    # sources
    sources = {}
    id = 1
    print('INSERT INTO sources VALUES ')
    for recipe in recipes:
        if recipe == [*recipes.keys()][-1]:
            source_type = 1
        else:
            source_type = random.randint(0, 1)
        id_source = 'null'
        if source_type == 1:
            source = 'https://www.waitrose.com/ecom/recipe/' + recipe
            id_source = str(id)
            id += 1
            if recipe != [*recipes.keys()][-1]:
                print('(' + id_source + ', \'' + source + '\'),')
            else:
                print('(' + id_source + ', \'' + source + '\')')
        sources[recipe] = [str(source_type), id_source]
    print(';')

    # recipes
    recipesIngredients = {}
    recipesTags = {}

    print('INSERT INTO recipes VALUES ')
    id = 1
    for recipe in recipes:
        content = urllib.request.urlopen('https://www.waitrose.com/ecom/recipe/' + recipe).read().decode("utf8")
        beg, end = content.find('datePublished'), content.find('aggregateRating')
        content = content[beg:end]

        preparationTime = re.findall('"totalTime":"PT[0-9]*H?[0-9]*M?"', content)[0]
        preparationTime = re.sub('"totalTime":"PT', '', preparationTime)
        preparationTime = preparationTime[:-1]
        in_hours = False
        if preparationTime.find('H') != -1:
            in_hours = True
        times = re.sub('[HM]', ' ', preparationTime).split(' ')
        preparationTime = 0
        if in_hours:
            preparationTime += int(times[0]) * 60
            if len(times) >= 2 and times[1] != '':
                preparationTime += int(times[1])
        else:
            preparationTime += int(times[0])

        beg, end = content.find('keywords'), content.find('recipeYield')
        tags = content[beg:end]
        tags = re.sub('keywords":"', '', tags)
        tags = re.sub('","', '', tags)
        tagList = tags.split(', ')
        p = re.compile('[a-zA-Z]*')
        tagList = [tag for tag in tagList if len(tag) > 3 and p.fullmatch(tag)]
        for tag in tagList:
            tag = tag.lower()
        recipesTags[recipe] = tagList

        beg, end = content.find('recipeIngredient'), content.find('recipeInstructions')
        ingredients = content[beg:end]
        ingredients = re.sub('recipeIngredient":\[', '', ingredients)
        ingredients = re.sub(', [0-9a-zA-Z ,/()]*"', '', ingredients)
        ingredients = re.sub('"\],"', '', ingredients)
        ingredients = re.sub(' {2,}', ' ', ingredients)
        ingredientList = ingredients.split(',"')
        recipesIngredients[recipe] = []
        for ingredient in ingredientList:
            ingredient = re.sub('["\]]', '', ingredient)
            if len(ingredient) > 0 and ingredient[0] == ' ':
                ingredient = ingredient[1:]
            ingredient = ingredient.lower()
            recipesIngredients[recipe].append(ingredient)

        instructions = content[end:]
        instructions = re.sub('recipeInstructions":\[', '', instructions)
        instructions = re.sub('"}],"', '', instructions)
        instructions = instructions.replace('\\r\\n', ' ')
        instructionSteps = instructions.split('{"@type":"HowToStep","name":')
        instructions = ''
        instructionList = []
        for instruction in instructionSteps:
            instruction = re.sub('"},', '', instruction)
            instruction = re.sub('"', '', instruction)
            instruction = re.sub(',text:', ': ', instruction)
            if len(instruction) > 0 and instruction[0] == ' ':
                instruction = instruction[1:]
            instructionList += ['"' + instruction + '"']
        instructions = '\'{' + ', '.join(instructionList[1:]) + '}\''

        coma = ''
        if recipe != [*recipes.keys()][-1]:
            coma = ','
        print('(DEFAULT, \'' + recipes[recipe] + '\', ' + str(random.randint(1, 360)) + ', ' + str(formsList.index(forms[recipe])+1)
              + ', current_timestamp-\'' + str(random.randint(2, 100)) + ' hours ' + str(random.randint(2, 60)) + ' minutes\'::interval, \''
              + str(difficulties[random.randint(1, 5)]) + '\', \'' + str(preparationTime) + ' minutes\'::interval, '
              + instructions + ', ' + sources[recipe][0] + ', ' + sources[recipe][1] + ')' + coma)
        recipe_ids[recipe] = id
        id += 1
    print(';')

    # archival recipes
    id = 0
    for recipe in recipes:
        id += 1
        if random.choice([True, True, True, True, True, False]):
            continue;

        content = urllib.request.urlopen('https://www.waitrose.com/ecom/recipe/' + recipe).read().decode("utf8")
        beg, end = content.find('datePublished'), content.find('aggregateRating')
        content = content[beg:end]

        beg = content.find('recipeInstructions')
        instructions = content[beg:]
        instructions = re.sub('recipeInstructions":\[', '', instructions)
        instructions = re.sub('"}],"', '', instructions)
        instructions = instructions.replace('\\r\\n', ' ')
        instructionSteps = instructions.split('{"@type":"HowToStep","name":')
        instructions = ''
        instructionList = []
        for instruction in instructionSteps:
            instruction = re.sub('"},', '', instruction)
            instruction = re.sub('"', '', instruction)
            instruction = re.sub(',text:', ': ', instruction)
            if len(instruction) > 0 and instruction[0] == ' ':
                instruction = instruction[1:]
            instructionList += ['"' + instruction + '"']
        instructions = '\'{' + ', '.join(instructionList[1:]) + '}\''

        print('UPDATE recipes SET body = ' + instructions + ' WHERE id_recipe = ' + str(id) + ';')

    # ingredients
    for recipe in recipes:
        for ingredient in recipesIngredients[recipe]:
            if len(ingredient) == 0:
                continue
            ingredient = ingredient.lower()
            ingredient_name = ingredient
            ingredient_name = re.sub('[0-9]*', '', ingredient_name)
            ingredient_name = re.sub(' g | ml | tsp | pinch | tbsp ', '', ingredient_name)
            ingredient_name = re.sub('[^a-z ]', '', ingredient_name)
            ingredient_name = re.sub(' {2}', ' ', ingredient_name)
            if ingredient_name[0] == ' ':
                ingredient_name = ingredient_name[1:]
            if ingredient[0].isdigit():
                amount = re.match('[0-91½]*', ingredient).group()
                amount = re.sub('½', '', amount)
                units = re.findall(' g | ml | tsp | pinch | tbsp ', re.sub('[0-9½]*', '', ingredient))
                if len(units) > 0:
                    unit = units[0]
                else:
                    unit = 'piece'
            elif ingredient[0] == '½':
                amount = 0.5
                units = re.findall(' g | ml | tsp | pinch | tbsp ', re.sub('[0-9½]*', '', ingredient))
                if len(units) > 0:
                    unit = units[0]
                else:
                    unit = 'piece'
            else:
                amount = 1
                unit = 'piece'
            unit = re.sub(' ', '', unit)
            print('SELECT add_ingredient(' + str(recipe_ids[recipe]) + ', \'' + ingredient_name + '\', 1, ' + str(amount) + ', \'' + unit + '\');')

    # tags
    tagListAll = []
    for recipe in recipes:
        for tag in recipesTags[recipe]:
            tag = tag.lower()
            tagListAll.append(tag)
    tagList = []
    [tagList.append(x) for x in tagListAll if x not in tagList]
    print('INSERT INTO tags VALUES ')
    id = 1
    tag_ids = {}
    for tag in tagList:
        tag_ids[tag] = id
        if tag != tagList[-1]:
            print('(DEFAULT, \'' + tag + '\'),')
        else:
            print('(DEFAULT, \'' + tag + '\')')
        id += 1
    print(';')
    print('INSERT INTO recipes_tags VALUES ')
    for recipe in recipes:
        for tag in recipesTags[recipe]:
            tag = tag.lower()
            if recipe != [*recipes.keys()][-1] or tag != recipesTags[recipe][-1]:
                print('(' + str(recipe_ids[recipe]) + ', ' + str(tag_ids[tag]) + '),')
            else:
                print('(' + str(recipe_ids[recipe]) + ', ' + str(tag_ids[tag]) + ')')
    print(';')
