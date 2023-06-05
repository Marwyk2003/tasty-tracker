import urllib.request
import random
import re

if __name__ == '__main__':

    # utensils
    needed = [1, 7, 15, 20, 29]
    cakes = [1, 50, 10, 18, 22, 35, 37, 39, 41, 44, 46, 48, 55, 56, 60, 63, 66, 72, 77, 78, 83, 84, 85, 89, 93, 97, 100, 102]
    lemon = [2, 12, 39, 51, 54, 73, 74, 77, 78, 102]
    biscuits = [76, 87]
    print('INSERT INTO recipes_utensils VALUES ')
    for c in cakes:
        print('(' + str(c) + ', 17),')
        print('(' + str(c) + ', 18),')
        print('(' + str(c) + ', 26),')
        if random.choice([True, False]):
            print('(' + str(c) + ', 12),')
        if random.choice([True, False]):
            print('(' + str(c) + ', 25),')
    
    for l in lemon:
        print('(' + str(l) + ', 6),')
        if random.choice([True, False]):
            print('(' + str(l) + ', 19),')
    
    for b in biscuits:
        print('(' + str(b) + ', 13),')
        print('(' + str(b) + ', 23),')
    
    for i in range(1, 104):
        myneeded = needed + [random.choice([8, 9, 10])] + [random.choice([4, 11])]
        for n in myneeded:
            if i < 103 or n != myneeded[-1]:
                print('(' + str(i) + ', ' + str(n) + '),')
            else:
                print('(' + str(i) + ', ' + str(n) + ')')
    print(';')

    # notes
    notes = ['Maybe less sugar', 'Maybe less sugar', 'A bit too sweet', 'Add a pinch of salt to the dough', 'Bake 10 minutes longer', 'Tastes best in two days after preparation',
             'Tastes best on first after preparation', 'Tastes best on third days after preparation', 'Add more sugar', 'Try with whole grain flour', 'Replace sugar with powdered sugar',
             'Try adding spices', 'Try adding cocoa powder', 'Try for family gathering', 'Try different tin shape', 'Try different tin shape', 'Try different tin shape', 'Add less sugar', 'Looks nice decorated with rose petals',
             'Be careful not to overbake', 'Keep the exact baking time', 'Add chocolate for decoration', 'Decorate with fresh mint leaves', 'Decorate with edible flowers',
             'May be decorated with flower petals', 'Use powdered sugar for smoother pastry', 'Experiment with tin shape', 'Possible to add food colouring',
             'Do not bake longer than said in the recipe!', 'You can use brown sugar', 'Try with rice flour', 'Tastes well with brown sugar', 'Try with out flour', 'Slightly less sugar', 'Not very sweet', 'Semi sweet',
             'Good proportions for bigger tin', 'Yummy, repeat', 'Works well with vegan substitutes', 'Try replacing sugar with honey', 'Add white chocolate for sweetness',
             'Add white chocolate', 'Easy to overbake', 'Keep exact proportions', 'Add some chocolate', 'May taste good with chopped almonds', 'Add food fragrant',
             'Consider adding a fragrant', 'Add a fragrant if for Christmas', 'Easy to overbake', 'Easy to underbake', 'Very easy to overbake', 'Good for friend celebrations',
             'Check carefully if baked well when taking out from the oven', 'Nice for family celebrations', 'Aunt Velma did not like it', 'Good to go', 'Nice with ice cream',
             'Good match with ice cream', 'Prepare double portion for whole family', 'Prepare double portion for five people', 'Single portion is not enough', 'Single portion is not enough',
             'Use bigger tin', 'Keep exact proportions', 'Keep exact proportions', 'Not so easy', 'Not so hard to do', 'Add decorations', 'Maybe add nuts', 'Maybe add some seasonings', 'try with fragrant',
             'Medium difficulty', 'Medium difficulty', 'Medium difficulty', 'Medium preparation time', 'Does not take so much time if ingredients prepared before', 'Prepare ingredients before', 'Start preparation before',
             'Take ingredients from the fridge before', 'Keep ingredients in room temperature', 'Keep ingredients in room temperature', 'Keep ingredients in room temperature', 'Keep ingredients in room temperature',
             'Pastry is quite dense', 'Not so easy to do', 'Quite complex', 'Low difficulty', 'Try again, give it a chance', 'Give it another chance', 'Very good, always works', 'Always perfect', 'hildren liked it', 'Good for children',
             'Try with seasonal fruit', 'Try with seasonal fruit', 'Try with seasonal fruit', 'Try with seasonal fruit', 'A bit dry', 'Good dessert for gatherings', 'It maybe a picnic dessert idea', 'Very nice, certainly sth to prepare again',
             'Give it another chance', 'Try one more time with altered proportion of dry ingredients', 'Sift dry ingredients!', 'Sift dry ingredients for better consistency', 'Sift dry ingredients for better consistency',
             'Sift dry ingredients for better consistency', 'Give it one more try', 'Give it one more try', 'Give it one more try', 'Prepare at least 4 hours before serving',
             'Prepare at least 1 hour before serving', 'Prepare at least 2 hours before serving', 'Can be a to go dessert', 'Not as good as to-go-dessert', 'Might be a to go dessert', 'Not so good as to-go',
             'Sift all dry ingredients!', 'Sift the flour', 'Use mixer instead of whisk', 'Using whisk is enough', 'Very nice for parties', 'Liked by kids', 'Left for some time before serving', 'Quite experimental']
    print('INSERT INTO notes VALUES ')
    for n in notes:
        if n != notes[-1]:
            print('(DEFAULT, ' + str(random.randint(1, 103)) + ', \'' + n + '\'),')
        else:
            print('(DEFAULT, ' + str(random.randint(1, 103)) + ', \'' + n + '\')')
    print(';')
