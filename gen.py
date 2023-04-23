from random import randint, choice, sample
from bcrypt import hashpw, gensalt
from datetime import timedelta, datetime


def random_date(start, end):
    return start + timedelta(
        seconds=randint(0, int((end - start).total_seconds())),
    )


users = {}
forms = {}
recipes = {}
products = {}
tags = {}
utensils = {}


def generateForms(n):
    query = []
    for id_form in range(n):
        shape = choice(['rectangular', 'round', 'round with chimney'])
        dimension1 = randint(15, 50)
        dimension2 = dimension1 if shape == 'round' else randint(15, 50)
        forms[id_form] = (shape, dimension1, dimension2)
        query += [f'({id_form}, \'{shape}\', {dimension1}, {dimension2})']
    sep = ',\n\t'
    return f'INSERT INTO forms VALUES {sep.join(query)};\n'


def generateProducts(n):
    query = []
    for id_product in range(n):
        name = f'product_{id_product}'
        category = choice(['diary', 'fruits', 'vegetables', 'dried fruits', 'nuts',
                           'cereal products', 'sweets', 'eggs', 'olives', 'butters and oils'])
        products[id_product] = (name, category)
        query += [f'({id_product}, \'{name}\', \'{category}\')']
    sep = ',\n\t'
    return f'INSERT INTO products VALUES {sep.join(query)};\n'


def generateTags(n):
    query = []
    for id_tag in range(n):
        name = f'tag_{id_tag}'
        tags[id_tag] = (name)
        query += [f'({id_tag}, \'{name}\')']
    sep = ',\n\t'
    return f'INSERT INTO tags VALUES {sep.join(query)};\n'


def generateUser(n):
    query = []
    for id_user in range(n):
        username = f'user_{id_user}'
        hash_password = str(hashpw(username.encode('ascii'), gensalt()))
        created_at = random_date(
            datetime(2010, 1, 1, 0, 0, 1), datetime(2023, 4, 23, 19, 44, 0))
        users[id_user] = (username, hash_password, created_at)
        query += [f'({id_user}, \'{username}\', {hash_password[1:]}, \'{created_at}\')']
    sep = ',\n\t'
    return f'INSERT INTO users VALUES {sep.join(query)};\n'


def generateUtensils(n):
    query = []
    for id_utensil in range(n):
        name = f'utensil_{id_utensil}'
        utensils[id_utensil] = (name)
        query += [f'({id_utensil}, \'{name}\')']
    sep = ',\n\t'
    return f'INSERT INTO utensils VALUES {sep.join(query)};\n'


def generateRecipes(n):
    query = []
    for id_recipe in range(n):
        name = f'recipe_{id_recipe}'
        id_user = choice(list(users.keys()))
        id_form = choice(list(forms.keys()))
        added_at = random_date(
            users[id_user][2], datetime(2023, 4, 24, 19, 44, 0))
        difficulty = choice(
            ['very easy', 'easy', 'medium', 'hard', 'very hard'])
        preparation_time = f'{choice([5,10,15,20,30,45,60])} minutes'
        body = '{}'
        visit_counter = randint(10, 10000)
        recipes[id_recipe] = (id_recipe, name, id_user, id_form, added_at,
                              difficulty, preparation_time, body, visit_counter)
        query += [f'({id_recipe}, \'{name}\', {id_user}, {id_form}, \'{added_at}\', \'{difficulty}\', \'{preparation_time}\', \'{body}\', {visit_counter})']
    sep = ',\n\t'
    return f'INSERT INTO recipes VALUES {sep.join(query)};\n'


def generateRecipesProducts():
    query = []
    for rid in recipes.keys():
        id_recipe = rid
        id_product = sample(list(products.keys()), randint(
            3, min(len(products.keys()), 20)))
        count = len(id_product)
        unit = [choice(['ml', 'l', 'tsp', 'tbsp', 'pinch', 'g'])
                for x in range(count)]
        amount = [choice([50, 100, 250, 500]) if unit[x] in (
            'ml', 'g') else randint(1, 3) for x in range(count)]
        for x in range(count):
            query += [
                f'({id_recipe}, {id_product[x]}, \'{unit[x]}\', {amount[x]})']
    sep = ',\n\t'
    return f'INSERT INTO recipes_products VALUES {sep.join(query)};\n'


def generateRecipesTags():
    query = []
    for rid in recipes.keys():
        id_recipe = rid
        id_tag = sample(list(tags.keys()), randint(
            0, min(len(tags.keys()), 4)))
        count = len(id_tag)
        for x in range(count):
            query += [
                f'({id_recipe}, {id_tag[x]})']
    sep = ',\n\t'
    return f'INSERT INTO recipes_tags VALUES {sep.join(query)};\n'


def generateRecipesUtensils():
    query = []
    for rid in recipes.keys():
        id_recipe = rid
        id_utensil = sample(list(utensils.keys()), randint(
            1, min(len(utensils.keys()), 2)))
        count = len(id_utensil)
        for x in range(count):
            query += [f'({id_recipe}, {id_utensil[x]})']
    sep = ',\n\t'
    return f'INSERT INTO recipes_utensils VALUES {sep.join(query)};\n'


def generateUsersLikes():
    query = []
    for uid in users.keys():
        id_user = uid
        id_recipe = sample(list(recipes.keys()), randint(
            1, min(len(recipes.keys()), 100)))
        count = len(id_recipe)
        for x in range(count):
            query += [
                f'({id_recipe[x]}, {id_user})']
    sep = ',\n\t'
    return f'INSERT INTO users_liked VALUES {sep.join(query)};\n'


if __name__ == '__main__':
    print(generateForms(5))
    print(generateProducts(50))
    print(generateTags(10))
    print(generateUser(15))
    print(generateUtensils(5))
    print(generateRecipes(20))
    print(generateRecipesProducts())
    print(generateRecipesTags())
    print(generateRecipesUtensils())
    print(generateUsersLikes())
