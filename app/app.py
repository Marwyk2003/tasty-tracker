from flask import Flask, render_template, request, redirect, url_for

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


@app.route('/edit/<rid>', methods=['GET', 'POST'])
def edit(rid):
    if request.method == 'GET':
        vm = Recipe(db)
        vm.load(rid)
        return render_template('recipe_form.html', vm=vm)

    if request.method == 'POST':
        vm = RecipeForm(db)
        vm.name = request.form.get('vm_name')
        vm.difficulty = request.form.get('vm_difficulty')
        vm.img = request.form.get('vm_img')
        vm.body = request.form.get('vm_body')
        vm.tags = request.form.getlist('vm_tags')
        vm.constraints = request.form.getlist('vm_constraints')
        vm.save()
        return redirect(url_for('recipe', rid=rid))


if __name__ == '__main__':
    app.run(debug=True)
