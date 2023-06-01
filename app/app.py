from flask import Flask, render_template, request, redirect, url_for

from viewmodels.RecipeList import RecipeList
from viewmodels.RecipeForm import RecipeForm
from viewmodels.Recipe import Recipe
from db import Database

app = Flask(__name__)
db = Database()

USER_ID = None


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
        vm.utensil = request.form.get('vm_utensil')
        vm.body = request.form.get('vm_body')
        vm.recipes = []
        for x in range(15):
            vm.ingredients += [[request.form.get(f'vm_ingredient_name_{x}'),
                                request.form.get(f'vm_ingredient_amount_{x}'),
                                request.form.get(f'vm_ingredient_unit_{x}')]]
        vm.save()
        return redirect(url_for('recipe', rid=rid))


@app.route('/login/', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')

    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        print(username, password, flush=True)
        return redirect('/')


if __name__ == '__main__':
    app.run(debug=True)
