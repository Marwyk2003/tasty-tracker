from flask import Flask, render_template

from templates.viewmodels.RecipeList import RecipeList
from templates.viewmodels.RecipeForm import RecipeForm
from templates.viewmodels.Recipe import Recipe
from db import Database

app = Flask(__name__)
db = Database()


@app.route('/')
def home():
    vm = RecipeList(db)
    vm.load()
    return render_template('index.html', vm=vm)


@app.route('/recipe/<rid>')
def recipe(rid):
    vm = Recipe(db)
    vm.load(rid)
    return render_template('recipe.html', vm=vm)


@app.route('/edit/<rid>')
def edit(rid):
    vm = RecipeForm(db)
    vm.load(rid)
    return render_template('recipe_form.html', vm=vm)


if __name__ == '__main__':
    app.run(debug=True)
