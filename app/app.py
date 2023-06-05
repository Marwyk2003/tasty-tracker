from flask import Flask, render_template, request, redirect, url_for

from viewmodels.RecipeList import RecipeList
from viewmodels.RecipeForm import RecipeForm
from viewmodels.Recipe import Recipe
from viewmodels.Login import Login
from db import Database

app = Flask(__name__)
db = Database()

USER_ID = None


@app.route('/', methods=['GET', 'POST'])
def home():
    global USER_ID
    if request.method == 'GET':
        vm = RecipeList(db, USER_ID)
        vm.load()
        return render_template('index.html', vm=vm, login_msg=login_msg())
    elif request.method == 'POST' and 'btn_login' in request.form:
        if USER_ID is None:
            return redirect(url_for('login'))
        else:
            USER_ID = None
            return redirect(url_for('home'))
    elif request.method == 'POST' and 'btn_new' in request.form:
        return redirect(url_for('new'))
    elif request.method == 'POST':
        return redirect(url_for('home'))


@app.route('/recipe/<rid>', methods=['GET', 'POST'])
def recipe(rid):
    global USER_ID
    vm = Recipe(db, int(rid), USER_ID)
    vm.load()
    if request.method == 'GET':
        return render_template('recipe.html', vm=vm, login_msg=login_msg())
    elif request.method == 'POST' and 'btn_login' in request.form:
        if USER_ID is None:
            return redirect(url_for('login'))
        else:
            USER_ID = None
            return redirect(url_for('home'))
    elif request.method == 'POST' and 'btn_new' in request.form:
        return redirect(url_for('new'))
    elif request.method == 'POST' and 'btn_like' in request.form:
        vm.change_like()
        return redirect(url_for('recipe', rid=rid))
    elif request.method == 'POST' and 'btn_edit' in request.form:
        return redirect(url_for('edit', rid=rid))


@app.route('/edit/<rid>', methods=['GET', 'POST'])
def edit(rid):
    global USER_ID
    if request.method == 'GET':
        vm = Recipe(db, rid, USER_ID)
        vm.load()
        return render_template('recipe_form.html', vm=vm, login_msg=login_msg())
    elif request.method == 'POST' and 'btn_login' in request.form:
        if USER_ID is None:
            return redirect(url_for('login'))
        else:
            USER_ID = None
            return redirect(url_for('home'))
    elif request.method == 'POST' and 'btn_new' in request.form:
        return redirect(url_for('new'))
    elif request.method == 'POST':
        vm = RecipeForm(db, int(rid), USER_ID, edit=True)
        vm.name = request.form.get('vm_name')
        vm.difficulty = request.form.get('vm_difficulty')
        vm.utensil = request.form.get('vm_utensil')
        vm.body = request.form.get('vm_body')
        vm.prep_time = request.form.get('vm_time')
        vm.recipes = []
        for x in range(15):
            vm.ingredients += [[request.form.get(f'vm_ingredient_name_{x}'),
                                request.form.get(f'vm_ingredient_amount_{x}'),
                                request.form.get(f'vm_ingredient_unit_{x}')]]
        vm.update()
        return redirect(url_for('recipe', rid=rid))


@app.route('/new', methods=['GET', 'POST'])
def new():
    global USER_ID
    if request.method == 'GET':
        vm = Recipe(db, None, USER_ID)
        return render_template('recipe_form.html', vm=vm, login_msg=login_msg())
    elif request.method == 'POST' and 'btn_login' in request.form:
        if USER_ID is None:
            return redirect(url_for('login'))
        else:
            USER_ID = None
            return redirect(url_for('new'))
    elif request.method == 'POST' and 'btn_new' in request.form:
        return redirect(url_for('new'))
    elif request.method == 'POST':
        vm = RecipeForm(db, None, USER_ID, edit=False)
        vm.name = request.form.get('vm_name')
        vm.difficulty = request.form.get('vm_difficulty')
        vm.utensil = request.form.get('vm_utensil')
        vm.body = request.form.get('vm_body')
        vm.prep_time = request.form.get('vm_time')
        vm.recipes = []
        for x in range(15):
            vm.ingredients += [[request.form.get(f'vm_ingredient_name_{x}'),
                                request.form.get(f'vm_ingredient_amount_{x}'),
                                request.form.get(f'vm_ingredient_unit_{x}')]]
        vm.update()
        return redirect(url_for('recipe', rid=vm.id))


@app.route('/login/', methods=['GET', 'POST'])
def login():
    global USER_ID
    if request.method == 'GET':
        return render_template('login.html')
    elif request.method == 'POST':
        login = Login(db)
        username = request.form.get('username')
        password = request.form.get('password')
        USER_ID = login.login(username, password)
        print(f'Now logged in as: {USER_ID}', flush=True)
        if USER_ID is None:
            return redirect(url_for('login'))
        USER_ID = int(USER_ID)
        return redirect(url_for('home'))


def login_msg():
    return 'Log in' if USER_ID is None else 'Log out'


if __name__ == '__main__':
    app.run(debug=True)
