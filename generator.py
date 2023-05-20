import urllib.request
import random
import re

if __name__ == '__main__':
    difficulties = {1: 'very easy', 2: 'easy', 3: 'medium', 4: 'hard', 5: 'very hard'}

    recipes = {'strawberry-cardamom-traybake':'Strawberry Cardamon Cake',
               'blueberry-lemon-thyme-friands':'Bluberyry Lemon Thyme Friands',
               # 'raspberry-orange-cheesecake':'Raspberry Orange Cheescake',
               # 'chocolate-dipped-madeleines':'Chocolate Dipped Madeleines',
               # 'pane-di-pasqua':'Pane di Pasqua',
               # 'torta-caprese-with-amaretto-cream':'Tarta Caprese with Amaretto Cream',
               # 'revani':'Revani',
               # 'key-lime-pie-buns':'Lime Pie Buns',
               # 'sticky-coffee-pudding':'Sticky CoffeePudding',
               # 'chocolate-date-cake':'Chocolate Date Cake',
               # 'mincemeat-meringue-tarts':'Mincemeat Meringue Tarts',
               # 'lemon-blueberry-meringues':'Lemon Blueberry Meringues',
               # 'fresh-cherry-bakewell-tarts':'Fresh Cherry Bakewell Tarts',
               # 'cherry-chocolate-lava-puddings':'Cherry Chocolate Lava Puddings',
               # 'strawberry-cream-choux-buns':'Strawberry Cream Choux Buns',
               # 'nectarine-marzipan-tart':'Nectarine Marzipan Tart',
               # 'blueberry-lattice-pie':'Blueberry Lattice Pie',
               # 'jelly-and-custard-celebration-cake':'Jelly and Custard Celebration Cake',
               # 'mint-chocolate-cheesecake':'Mint Chocolate Cheesecake',
               # 'blueberry-burnt-basque-cheesecake':'Blueberry Burnt Basque Cheescake',
               # 'saffron-cardamom-pavlova':'Saffron Cardamon Pavlova',
               # 'chocolate-almond-simnel-cake':'Chocolate Almond Simnel Cake',
               # 'easter-carrot-patch-traybake':'Easter Carrot Patch Traybake',
               # 'choc-chip-cookie-cups':'Choc Chip Cookie Cups',
               # 'christmas-pudding-doughnuts':'Christmas Pudding Doughnuts',
               # 'grape-almond-clafoutis':'Grape Almond Clafoutis',
               # 'pumpkin-caramel-ginger-baked-cheesecake':'Pumpkin Caramel Ginger Baked Cheescake',
               # 'cinnamon-bun-pudding':'Cinnamon Bun Pudding',
               # 'deep-dish-apple-pie':'Deep Dish Apple Pie',
               # 'raspberry-almond-galette':'Raspberry Almond Galette',
               # 'avocado-chocolate-tart-with-candied-tangerine':'Avocade Chocolate Tart with Candied Tangerine',
               # 'icce-cream-cookie-cups':'Ice Cream Cookie Cups',
               # 'cherry-and-almond-baklava':'Cherry and Almond Baklava',
               'chocolate-and-salted-caramel-traybake':'Chocolate and Salted Caramel Traybake'
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
               'chocolate-and-salted-caramel-traybake': ['rectangular tin', '33', '22']
               }
    recipe_ids = {}

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

    sources = {}
    id = 1
    print('INSERT INTO sources VALUES ')
    for recipe in recipes:
        if recipe == [*recipes.keys()][-1]:
            source_type = 1
        else:
            source_type = random.randint(0, 2)
        id_source = 'null'
        if source_type == 1:
            source = 'https://www.waitrose.com/ecom/recipe/' + recipe
            id_source = str(id)
            id += 1
            if recipe != [*recipes.keys()][-1]:
                print('(' + id_source + ', \'' + source + '\'),')
            else:
                print('(' + id_source + ', \'' + source + '\')')
        elif source_type == 2:
            ids = [*range(1, len(recipes) + 1, 1)]
            ids.remove(id)
            id_source = str(random.choice(ids))
        sources[recipe] = [str(source_type), id_source]
    print(';')

    recipesIngredients = {}
    recipesTags = {}

    print('INSERT INTO categories VALUES (1, \'healthy\');')
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
        for instruction in instructionSteps:
            instruction = re.sub('"},', '', instruction)
            instruction = re.sub('"', '', instruction)
            instruction = re.sub(',text:', ': ', instruction)
            if len(instruction) > 0 and instruction[0] == ' ':
                instruction = instruction[1:]
            instructions += instruction + '\n'

        if recipe != [*recipes.keys()][-1]:
            print('(' + str(id) + ', \'' + recipes[recipe] + '\', ' + str(random.randint(1, 5)) + ', ' + str(formsList.index(forms[recipe]) + 1)
                  + ', current_timestamp-\'' + str(random.randint(2, 100)) + ' hours ' + str(random.randint(2, 60)) + ' minutes\'::interval, \''
                  + str(difficulties[random.randint(1, 5)]) + '\', \'' + str(preparationTime) + ' minutes \'::interval, \''
                  + instructions + '\', ' + sources[recipe][0] + ', ' + sources[recipe][1] + '),')
        else:
            print('(' + str(id) + ', \'' + recipes[recipe] + '\', ' + str(random.randint(1, 5)) + ', ' + str(formsList.index(forms[recipe])+1)
                  + ', current_timestamp-\'' + str(random.randint(2, 100)) + ' hours ' + str(random.randint(2, 60)) + ' minutes\'::interval, \''
                  + str(difficulties[random.randint(1, 5)]) + '\', \'' + str(preparationTime) + ' minutes \'::interval, \''
                  + instructions + '\', ' + sources[recipe][0] + ', ' + sources[recipe][1] + ')')
        recipe_ids[recipe] = id
        id += 1
    print(';')


    ingredientListAll = []
    for recipe in recipes:
        for ingredient in recipesIngredients[recipe]:
            ingredient = ingredient.lower()
            ingredientListAll.append(ingredient)
    ingredientList = []
    [ingredientList.append(x) for x in ingredientListAll if x not in ingredientList and x != '']
    print('INSERT INTO products VALUES ')
    id = 1
    ingredient_ids = {}
    for ingredient in ingredientList:
        ingredient_copy = ingredient
        ingredient_ids[ingredient] = id
        ingredient = re.sub('[0-9]* [a-zA-Z]* ', '', ingredient)
        ingredient = re.sub('[^a-zA-Z ]', '', ingredient)
        if ingredient_copy != ingredientList[-1]:
            print('(' + str(id) + ', \'' + ingredient + '\', 1),')
        else:
            print('(' + str(id) + ', \'' + ingredient + '\', 1)')
        id += 1
    print(';')
    print('INSERT INTO recipes_products VALUES ')
    for recipe in recipes:
        for ingredient in recipesIngredients[recipe]:
            if len(ingredient) == 0:
                continue
            ingredient = ingredient.lower()
            ingredient_copy = ingredient
            if ingredient[0].isdigit():
                amount = re.match('[0-91½]*', ingredient).group()
                amount = re.sub('½', '', amount)
                ingredient = re.sub('[0-9½]*', '', ingredient)
                units = re.findall(' g | ml | tsp | pinch | tbsp ', ingredient)
                if len(units) > 0:
                    unit = units[0]
                else:
                    unit = 'piece'
            elif ingredient[0] == '½':
                amount = 0.5
                ingredient = re.sub('[0-9½]*', '', ingredient)
                units = re.findall(' g | ml | tsp | pinch | tbsp ', ingredient)
                if len(units) > 0:
                    unit = units[0]
                else:
                    unit = 'piece'
            else:
                amount = 1
                unit = 'piece'
            unit = re.sub(' ', '', unit)
            if recipe != [*recipes.keys()][-1] or ingredient_copy != recipesIngredients[recipe][-2]:
                print('(' + str(recipe_ids[recipe]) + ', ' + str(ingredient_ids[ingredient_copy]) + ', \'' + unit + '\', ' + str(amount) + '),')
            else:
                print('(' + str(recipe_ids[recipe]) + ', ' + str(ingredient_ids[ingredient_copy]) + ', \'' + unit + '\', ' + str(amount) + ')')
    print(';')

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
            print('(' + str(id) + ', \'' + tag + '\'),')
        else:
            print('(' + str(id) + ', \'' + tag + '\')')
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