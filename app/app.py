from flask import Flask, render_template
from db import Database

app = Flask(__name__)
db = Database()


@app.route('/')
def home():
    return render_template('index.html')


@app.route('/recipe/<rid>')
def recipe(rid):
    ingredients = db.get_recipe_ingredients(rid)
    res = db.get_recipe_body(rid)
    body = res[0]
    difficulty = res[1]
    return render_template('recipe.html', ingredients=ingredients, body=body, difficulty=difficulty)


@app.route('/edit/<rid>')
def edit(rid):
    ingredients = db.get_recipe_ingredients(rid)
    res = db.get_recipe_body(rid)
    body = res[0]
    difficulty = res[1]
    return render_template('recipe_form.html', ingredients=ingredients, body=body, difficulty=difficulty)


if __name__ == '__main__':
    app.run(debug=True)
