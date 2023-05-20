CREATE TYPE unit_enum AS ENUM ('ml','l', 'tsp', 'tbsp', 'pinch', 'g', 'piece');
CREATE TYPE shape_enum AS ENUM ('rectangular tin', 'round tin', 'round tin with chimney', 'ovenproof dish', 'tart tin', 'muffin tin');
CREATE TYPE difficulty_enum AS ENUM ('very easy', 'easy', 'medium', 'hard', 'very hard');

CREATE TABLE forms (
	id_form              serial,
	shape                shape_enum NOT NULL,
	dimension1           integer NOT NULL,
	dimension2           integer NOT NULL,
	CONSTRAINT pk_forms PRIMARY KEY (id_form)
);
ALTER TABLE forms ADD CONSTRAINT positive_dimensions CHECK (dimension1 > 0 AND dimension2 > 0);

CREATE TABLE products (
	id_product           serial,
	name                 varchar(30) NOT NULL,
	id_category          integer NOT NULL,
	CONSTRAINT pk_products PRIMARY KEY (id_product)
);

CREATE TABLE categories (
	id_category 	     serial,
	category 	     varchar(60) NOT NULL, 
	CONSTRAINT pk_category PRIMARY KEY (id_category)
);

CREATE TABLE tags (
	id_tag               serial,
	tag                  varchar(60) NOT NULL,
	CONSTRAINT pk_tags PRIMARY KEY (id_tag)
);

CREATE TABLE restrictions(
	id_restriction 	     serial,
	restriction 	     varchar(60) NOT NULL,
	CONSTRAINT pk_restrictions PRIMARY KEY (id_restriction)
);

CREATE TABLE users (
	id_user              serial,
	username             varchar(20) NOT NULL,
	hash_password        char(60) NOT NULL,
	created_at           timestamp DEFAULT CURRENT_DATE NOT NULL,
	CONSTRAINT pk_users PRIMARY KEY (id_user)
);

CREATE TABLE utensils (
	id_utensil           serial,
	utensil              varchar(30) NOT NULL,
	CONSTRAINT pk_utensils PRIMARY KEY (id_utensil)
);

CREATE TABLE recipes (
	id_recipe            serial,
	name		     varchar(100) NOT NULL,
	id_user              integer,
	id_form              integer,
	added_at             timestamp DEFAULT CURRENT_DATE NOT NULL,
	difficulty           difficulty_enum,
	preparation_time     interval,
	body                 text NOT NULL,
	source_type 	     integer,
	id_source 	     integer,
	CONSTRAINT pk_recipes PRIMARY KEY (id_recipe)
);

CREATE TABLE sources (
	id_source            serial,
	source 		     varchar(300) NOT NULL,
	CONSTRAINT pk_source_external PRIMARY KEY(id_source)
);

CREATE TABLE archival_recipes (
	id_archival_reicpe   serial,
	id_recipe            integer NOT NULL,
	name		     varchar(100) NOT NULL,
	id_user              integer,
	id_form              integer,
	added_at             timestamp NOT NULL,
	difficulty           difficulty_enum,
	preparation_time     interval,
	body                 text NOT NULL,
	CONSTRAINT pk_archival_recipes PRIMARY KEY (id_archival_reicpe)
);
ALTER TABLE recipes ADD CONSTRAINT positive_time CHECK (preparation_time > '0 seconds');

CREATE TABLE recipes_products (
	id_recipe            integer NOT NULL,
	id_product           integer NOT NULL,
	unit                 unit_enum NOT NULL,
	amount               integer NOT NULL,
	CONSTRAINT pk_recipe_products PRIMARY KEY(id_recipe, id_product)
);
ALTER TABLE recipes_products ADD CONSTRAINT positive_amount CHECK (amount > 0);

CREATE TABLE recipes_tags (
	id_recipe            integer NOT NULL,
	id_tag               integer NOT NULL,
	CONSTRAINT pk_recipe_tags PRIMARY KEY(id_recipe, id_tag)
);

CREATE TABLE products_restrictions (
	id_product	     integer NOT NULL,
	id_restriction	     integer NOT NULL,
	CONSTRAINT pk_products_restrictions PRIMARY KEY(id_product, id_restriction)
);

CREATE TABLE recipes_utensils (
	id_recipe      	     integer NOT NULL,
	id_utensil	     integer NOT NULL,
	CONSTRAINT pk_recipes_utensils PRIMARY KEY (id_recipe, id_utensil)
);

CREATE TABLE users_liked (
	id_recipe            integer NOT NULL,
	id_user              integer NOT NULL,
	CONSTRAINT pk_users_liked PRIMARY KEY(id_recipe, id_user)
);

CREATE TABLE users_liked_comments (
	id_comment  	     integer NOT NULL,
	id_user 	     integer NOT NULL,
	CONSTRAINT pk_users_liked_comments PRIMARY KEY(id_comment, id_user)
);

CREATE TABLE notes (
	id_note              serial,
	id_recipe 	     integer NOT NULL,
	id_user 	     integer NOT NULL,
	body 		     text NOT NULL,
	CONSTRAINT pk_notes PRIMARY KEY (id_note)
);

CREATE TABLE comments (
	id_comment 	     serial,
	id_recipe 	     integer NOT NULL,
	id_user 	     integer NOT NULL,
	id_parent 	     integer,
	body 		     text NOT NULL,
	CONSTRAINT pk_comments PRIMARY KEY(id_comment)
);

ALTER TABLE recipes ADD CONSTRAINT fk_recipes_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE SET NULL;
ALTER TABLE recipes ADD CONSTRAINT fk_recipes_form FOREIGN KEY (id_form) REFERENCES forms(id_form);

ALTER TABLE products ADD CONSTRAINT fk_products_category FOREIGN KEY (id_category) REFERENCES categories(id_category);

ALTER TABLE recipes_products ADD CONSTRAINT fk_recipes_products_recipe FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe);
ALTER TABLE recipes_products ADD CONSTRAINT fk_recipes_products_product FOREIGN KEY (id_product) REFERENCES products(id_product);

ALTER TABLE archival_recipes ADD CONSTRAINT fk_archival_recipes FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe);

ALTER TABLE recipes_tags ADD CONSTRAINT fk_recipes_tags_tag FOREIGN KEY (id_tag) REFERENCES tags(id_tag);
ALTER TABLE recipes_tags ADD CONSTRAINT fk_recipes_tags_recipe FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe);

ALTER TABLE products_restrictions ADD CONSTRAINT fk_products_restrictions_product FOREIGN KEY (id_product) REFERENCES products(id_product);
ALTER TABLE products_restrictions ADD CONSTRAINT fk_products_restrictions_restriction FOREIGN KEY (id_restriction) REFERENCES restrictions(id_restriction);

ALTER TABLE recipes_utensils ADD CONSTRAINT fk_recipes_utensils_recipe FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe) ON DELETE CASCADE;
ALTER TABLE recipes_utensils ADD CONSTRAINT fk_recipes_utensils_utensil FOREIGN KEY (id_utensil) REFERENCES utensils(id_utensil);

ALTER TABLE notes ADD CONSTRAINT fk_notes_recipe FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe);
ALTER TABLE notes ADD CONSTRAINT fk_notes_user FOREIGN KEY (id_user) REFERENCES users(id_user);

ALTER TABLE comments ADD CONSTRAINT fk_comment_recipe FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe);
ALTER TABLE comments ADD CONSTRAINT fk_comment_user FOREIGN KEY (id_user) REFERENCES users(id_user);

ALTER TABLE users_liked ADD CONSTRAINT fk_users_liked_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE;
ALTER TABLE users_liked ADD CONSTRAINT fk_users_liked_recipe FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe) ON DELETE CASCADE;

ALTER TABLE users_liked_comments ADD CONSTRAINT fk_users_liked_user_comments FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE;
ALTER TABLE users_liked_comments ADD CONSTRAINT fk_users_liked_recipe_comments FOREIGN KEY (id_comment) REFERENCES comments(id_comment) ON DELETE CASCADE;

INSERT INTO utensils VALUES
(DEFAULT, 'spatula'),
(DEFAULT, 'whisk'),
(DEFAULT, 'mixer');

INSERT INTO forms VALUES 
(1, 'rectangular tin', 30, 20),
(2, 'muffin tin', 36, 26),
(3, 'round tin', 22, 22),
(4, 'rectangular tin', 36, 26),
(5, 'round tin with chimney', 22, 22),
(6, 'rectangular tin', 40, 25),
(7, 'ovenproof dish', 30, 19),
(8, 'round tin', 20, 20),
(9, 'rectangular tin', 37, 27),
(10, 'tart tin', 23, 23),
(11, 'rectangular tin', 33, 23),
(12, 'rectangular tin', 50, 40),
(13, 'round tin', 25, 25),
(14, 'round tin', 23, 23),
(15, 'round tin', 30, 30),
(16, 'round tin', 26, 26),
(17, 'rectangular tin', 23, 23),
(18, 'rectangular tin', 33, 22)
;
INSERT INTO sources VALUES 
(1, 'https://www.waitrose.com/ecom/recipe/strawberry-cardamom-traybake'),
(2, 'https://www.waitrose.com/ecom/recipe/blueberry-lemon-thyme-friands'),
(3, 'https://www.waitrose.com/ecom/recipe/chocolate-dipped-madeleines'),
(4, 'https://www.waitrose.com/ecom/recipe/revani'),
(5, 'https://www.waitrose.com/ecom/recipe/chocolate-date-cake'),
(6, 'https://www.waitrose.com/ecom/recipe/mincemeat-meringue-tarts'),
(7, 'https://www.waitrose.com/ecom/recipe/cherry-chocolate-lava-puddings'),
(8, 'https://www.waitrose.com/ecom/recipe/nectarine-marzipan-tart'),
(9, 'https://www.waitrose.com/ecom/recipe/blueberry-burnt-basque-cheesecake'),
(10, 'https://www.waitrose.com/ecom/recipe/saffron-cardamom-pavlova'),
(11, 'https://www.waitrose.com/ecom/recipe/chocolate-almond-simnel-cake'),
(12, 'https://www.waitrose.com/ecom/recipe/choc-chip-cookie-cups'),
(13, 'https://www.waitrose.com/ecom/recipe/christmas-pudding-doughnuts'),
(14, 'https://www.waitrose.com/ecom/recipe/cinnamon-bun-pudding'),
(15, 'https://www.waitrose.com/ecom/recipe/deep-dish-apple-pie'),
(16, 'https://www.waitrose.com/ecom/recipe/cherry-and-almond-baklava'),
(17, 'https://www.waitrose.com/ecom/recipe/chocolate-and-salted-caramel-traybake')
;
INSERT INTO categories VALUES (1, 'healthy'), (2, 'vegetarian'), (3, 'dairy');
INSERT INTO users VALUES
(1, 'polly12', 'xyz'),
(2, 'cooking_prince', 'xyz'),
(3, 'BillyBobbyJoe', 'xyz'),
(4, 'samantha1220', 'xyz'),
(5, 'user', 'xyz');

    INSERT INTO recipes VALUES 
    (1, 'Strawberry Cardamon Cake', 2, 1, current_timestamp-'29 hours 4 minutes'::interval, 'hard', '55 minutes '::interval, '
    Step 1: Preheat the oven to 190°C, gas mark 5. Grease and line a 30cm x 20cm cake tin. In a mixing bowl, use an electric hand mixer to beat the butter and sugar for 5-8 minutes until pale and fluffy. Beat in the eggs, one at a time, with 1 tbsp flour. Sieve in the remaining flour, baking powder and salt, then fold to combine. Fold in the milk, cardamom, vanilla and strawberry chunks.
    Step 2: Pour into the cake tin and bake for 20-30 minutes until golden and risen; a skewer inserted into the centre should come out clean. Cool in the tin for 15 minutes, then remove from the tin; transfer to a wire rack to cool completely.
    Step 3: To make the icing, in a large mixing bowl, use an electric hand mixer to beat the butter for 5 minutes until pale and fluffy. Working in 3 batches, gradually beat in the icing sugar. Add the salt, vanilla and milk; beat for 1 minute. Spread over the top of the cooled cake. It will keep in the fridge for 4 days; cut the remaining strawberries into wedges and arrange on top before serving.
    ', 1, 1),
    (2, 'Bluberyry Lemon Thyme Friands', 3, 2, current_timestamp-'66 hours 32 minutes'::interval, 'very easy', '60 minutes '::interval, '
    Step 1: Preheat the oven to 180°C, gas mark 4. Melt 200g butter in a small saucepan over a low heat, then tip into a bowl and set aside to cool for 15 minutes. Meanwhile, melt the remaining 10g butter in the same pan and use to grease a 12-hole muffin tin. Dust the muffin holes with flour, tilting to coat the sides, then tap out the excess; chill.
    Step 2: Sift the flour and icing sugar into a large bowl, then add the ground almonds and salt; mix to combine. Put the egg whites in a separate bowl and use a fork to froth them up for a few seconds. Pour into the dry ingredients with the cooled, melted butter. Stir until incorporated, then add the lemon zest, juice and lemon thyme. Mix into a batter. Fold through 50g blueberries.
    Step 3: Remove the muffin tin from the fridge and divide the batter between the 12 holes. Scatter over the flaked almonds and add a few blueberries to each. Bake for 30-35 minutes until golden and a skewer inserted comes out clean. Leave to cool for 10-15 minutes before easing the friands from the tin. Allow to cool completely. 
    Step 4: For the icing, sift the icing sugar into a bowl and stir in the lemon juice. Drizzle over the cakes and scatter over extra lemon thyme leaves. 
    ', 1, 2),
    (3, 'Raspberry Orange Cheescake', 1, 3, current_timestamp-'67 hours 32 minutes'::interval, 'easy', '40 minutes '::interval, '
    Step 1: Grease and base-line a 22cm round springform cake tin with baking parchment. Mix all the base ingredients and press into the tin. Chill. In the bowl of a freestanding mixer with a paddle attachment (or in a bowl using an electric hand mixer), beat the soft cheese, condensed milk, ½ the orange zest and the cream, starting on a medium speed.
    Step 2: Meanwhile, put the orange juice in a small pan with the gelatine powder and heat until the gelatine is fully dissolved; remove from the heat. While the filling is being beaten, slowly pour over the orange juice mixture until well combined. Pour onto the chilled base, flatten with a spatula and chill to set for at least 1 hour.
    Step 3: For the jelly topping, bring a kettle to the boil. Set aside 10-12 raspberries, then put the remaining berries, the lemon juice and caster sugar in a small pan with 250ml just-boiled water. Bring to the boil and crush the raspberries lightly. Remove from the heat and strain through a fine sieve over a bowl, pushing the fruit through with the back of a spoon. Discard the seeds, then stir in the gelatine until dissolved. Set aside to cool (not in the fridge, so it doesn’t set) and stir occasionally. After an hour, carefully pour it over the back of a spoon all over the top of the cheesecake and return to the fridge to set for at least 2 hours. To serve, decorate with the reserved raspberries and orange zest.
    ', 2, 19),
    (4, 'Chocolate Dipped Madeleines', 1, 4, current_timestamp-'16 hours 8 minutes'::interval, 'very easy', '25 minutes '::interval, '
    Step 1: Line a large baking tray with baking parchment. Melt the dark, milk and white chocolate in separate bowls in the microwave or set over a pan of gently simmering water. Finely chop the coconut chips and pistachios. 
    Step 2: Remove the Madeleine cakes from their packaging, dip ½ of each madeleine into the melted chocolate and sprinkle over toppings as follows: dark chocolate with coconut chips; milk chocolate with pistachios and a few sea salt flakes; and white chocolate with rose petals. Transfer to the prepared baking tray and leave to set in the fridge for 30 minutes.
    ', 1, 3),
    (5, 'Pane di Pasqua', 4, 5, current_timestamp-'67 hours 37 minutes'::interval, 'very hard', '75 minutes '::interval, '
    Step 1: Coarsely crush the star anise using a pestle and mortar or rolling pin. Put the milk in a pan over a low-medium heat, then add the star anise and heat gently until just below boiling point. Remove from the heat; set aside to cool to room temperature.
    Step 2: Put the flour in the bowl of a freestanding mixer with a dough hook, along with the salt, sugar and yeast. Mix together, then break in 3 eggs and strain in the cooled milk (discard the star anise). Mix and knead for 5 minutes until smooth.
    Step 3: Gradually add the butter, 1-2 cubes at a time, followed by the zest, then knead for 5-10 minutes to make a soft and silky dough. Lightly butter a large bowl, then scrape in the dough, cover and leave for 2 hours until doubled in size. Knead the dough for 2 minutes, then return to the bowl; cover and chill for at least 1 hour or up to 8 hours.
    Step 4: Divide the chilled dough into 3 even pieces, then roll into 75cm-long ropes, ensuring they’re of even thickness along the length. If necessary, very lightly dust the work surface with flour.
    Step 5: Carefully plait the 3 ropes of dough together, wrapping them gently to ensure the thickness of the ropes remains even. Line a large baking sheet with baking parchment.
    Step 6: Lift the plait onto the lined tray and shape into a ring, tucking the ends underneath. Cover the dough loosely with baking parchment and leave to prove for 1-2 hours until well risen.
    Step 7: Preheat the oven to 180˚C, gas mark 4. Beat the remaining egg with a large pinch of salt and 2 tbsp water. Carefully brush the eggwash over the dough, then scatter with the coloured sprinkles and bake for 25-30 minutes until the bread is dark golden and risen. Cool on a wire rack before decorating with chocolate eggs.
    ', 0, null),
    (6, 'Tarta Caprese with Amaretto Cream', 3, 3, current_timestamp-'90 hours 44 minutes'::interval, 'hard', '50 minutes '::interval, '
    Step 1: Preheat the oven to 180ºC, gas mark 4. Butter a 22-23cm springform cake tin, then line the base with baking parchment.
    Step 2: Toast the almonds in a dry frying pan over a medium heat. Toss them around every so often. If I do this in the oven, I forget about them so I toast them in a pan on the hob. Leave to cool, then blitz in a food processor in short spurts – if you over process the nuts they become oily.
    Step 3: Put the butter and chocolate in a bowl set over a pan of simmering water. The bottom of the bowl must not touch the water. It’s easy for the chocolate to get too hot. Melt together, stirring with a wooden spoon to help it along. Remove the bowl and set aside to cool.
    Step 4: In a large bowl, beat the egg yolks and caster sugar until pale and increased in volume. Slowly add the melted chocolate and butter, a pinch of salt and the cocoa powder
    Step 5: Beat the whites in another scrupulously clean large bowl until at medium peak stage. The egg whites should hold their shape but, when you hold the beaters up, the peaks should slightly droop. Using a large metal spoon, fold the almonds into the cake with ½ the whites, followed by the other ½. 
    Step 6: Scrape the batter into the tin and bake for 35-40 minutes, until coming away from the sides of the tin. To test for doneness, push a skewer into the middle of the cake. It should be almost clean when it comes out, but this cake stays soft in the middle so is harder to gauge.
    Step 7:  Leave to cool for 15 minutes, then unclasp the ring on the tin. Leave the cake on the base to cool completely. Carefully turn the cake over and remove the base and paper. Transfer to a serving plate. The cake will deflate, but that’s normal. Sift cocoa powder or icing sugar over the top. Scatter with the toasted almond flakes.
    Step 8: Whip the cream until holding its shape, then beat in the soft sugar. Slowly add the amaretto, whisking on low speed. Taste so you don’t add more than you need. Serve with the torta.
    ', 2, 30),
    (7, 'Revani', 3, 1, current_timestamp-'28 hours 26 minutes'::interval, 'easy', '65 minutes '::interval, '
    Step 1: For the syrup, put the sugar in a medium saucepan with 200ml water. Bring to the boil, stirring to dissolve the sugar. Reduce the heat to low and simmer for 3-4 minutes. Add the lemon juice, remove from the heat and set aside to cool.
    Step 2: Preheat the oven to 180ºC, gas mark 4. Grease and line a 20cm x 30cm x 4cm tin with baking parchment. Beat the egg yolks and sugar in a large bowl with an electric hand whisk until fluffy (3-4 minutes). Beat in the oil, yogurt, orange zest and vanilla. Fold in the flour, semolina, salt and baking powder until combined.
    Step 3: In a separate large bowl, whisk the egg whites until they form soft peaks, then fold into the batter in three additions. Pour the cake mixture into the prepared tin and bake for 25-30 minutes until golden, risen and a skewer inserted comes out clean.
    Step 4: Poke holes all over the cake with a skewer and pour the syrup over the cake, allowing it to soak in before adding more. Leave to cool in the tin. Cut into 5cm diamonds, sprinkle with chopped pistachios and enjoy with clotted cream, if liked.
    ', 1, 4),
    (8, 'Lime Pie Buns', 3, 6, current_timestamp-'31 hours 24 minutes'::interval, 'hard', '70 minutes '::interval, '
    Step 1: Warm the milk over a low heat until just starting to steam. Tip into a jug with 50g brown sugar and the yeast, whisk, then set aside. Melt 100g butter. In the bowl of a freestanding mixer or mixing bowl, whisk the flour and salt. Make a well and pour in the milk mixture, melted butter and eggs. Add the zest and juice of 1 lime; mix well. Knead the dough in a mixer or by hand until smooth and elastic (8 - 10 minutes). Transfer to a clean bowl, cover with a tea towel and leave for 2 hours or until doubled in size.
    Step 2: When the dough has risen, knock it back onto a clean work surface and roll into a rectangle about 25 x 40cm. Spread with 75g butter, the zest of 1 lime and all the lemon zest. Sprinkle evenly with the remaining 200g light brown soft sugar, patting it onto the dough, then roll into a log, starting at the longer side. Cut into 12 evenly sized pieces.
    Step 3: Grease a 25cm x 30cm roasting tin and put the buns in it, cut-side up. Leave to prove for 20 minutes. Meanwhile, preheat the oven to 190ºC, gas mark 5. When the buns are ready and just touching, bake for 20-25 minutes until golden and cooked through.
    Step 4: Meanwhile, beat the cheese with the remaining 25g butter. Sift in the icing sugar; beat until smooth. Add most of the remaining lime zest and all the remaining juice. Ice the buns as soon as they come out of the oven. Cool, then sprinkle over the remaining zest.
    ', 2, 28),
    (9, 'Sticky CoffeePudding', 2, 7, current_timestamp-'42 hours 12 minutes'::interval, 'very easy', '65 minutes '::interval, '
    Step 1: Preheat the oven to 190ºC, gas mark 5. Grease a 1.5L ovenproof dish with butter. Place the dates into a small bowl with the bicarbonate of soda. Pour over the coffee, stir and leave to soak while you make the pudding batter.
    Step 2: Beat the butter and sugar together with a wooden spoon or electric hand whisk in a large bowl for a few minutes, until light and fluffy. Add the eggs one at a time, beating well between each addition, then add the golden syrup. Stir in the flour until well incorporated, then pour in the milk. Fold the soaked dates, along with any excess soaking liquid, into the batter. Pour the mixture evenly into the buttered dish and bake for 40-45 minutes until risen, golden and firm.
    Step 3: While the pudding bakes, make the sauce by combining all the ingredients in a small saucepan. Stir constantly over a low heat until the butter melts, then turn the heat up to medium and allow to bubble for 2-3 minutes.
    Step 4: Once the pudding has come out of the oven, use a skewer to punch holes through the top of the sponge. Pour the warm coffee caramel sauce over the pudding and leave to soak in for 10 minutes before serving.
    ', 0, null),
    (10, 'Chocolate Date Cake', 3, 8, current_timestamp-'77 hours 56 minutes'::interval, 'very easy', '55 minutes '::interval, '
    Step 1: Preheat the oven to 180°C, gas mark 4. Grease a 20cm round, springform cake tin and line with baking parchment. Soak the dates in 150ml just-boiled water for 10 minutes, then whizz in a blender until smooth.
    Step 2: Put the egg whites in one mixing bowl and the yolks in another. Using electric beaters, beat the egg whites to just-stiff peaks, then beat in the sugar until combined; set aside. 
    Step 3: Add the oil to the egg yolks and beat for 1 minute until combined (there’s no need to clean the beaters). Next, beat in the puréed dates and the melted chocolate. Fold in the ground almonds, cocoa, baking powder and a pinch of salt, then fold in the egg whites until just combined.
    Step 4: Tip the mixture into the cake tin, gently smooth the top and bake for about 30 minutes or until just set on top with a slight wobble in the middle. Cool completely in the tin, then serve with a dusting of cocoa powder and whipped cream on the side, if liked.
    ', 1, 5),
    (11, 'Mincemeat Meringue Tarts', 3, 9, current_timestamp-'84 hours 53 minutes'::interval, 'easy', '60 minutes '::interval, '
    Step 1: Preheat the oven to 180ºC, gas mark 4. Roll the pastry out to a 37cm x 27cm rectangle, then cut it into 6 even rectangles and use to line 6 x 9cm diameter tart cases, leaving the excess pastry hanging over the edges. Prick the bases a few times with a fork, then line with baking parchment and put on a baking tray. Fill the cases with baking beans and bake for 15 minutes.
    Step 2: Meanwhile, in a food processor, whizz together the marzipan and 2 egg yolks until thick and smooth (put the third yolk in the fridge or freezer to use at a later date); set aside. Remove the baking beans and parchment from the pastry and bake for another 5 minutes, until crisp and golden. Divide the marzipan mixture between the pastry cases and bake for a further 10 minutes.
    Step 3: Use a serrated knife to trim the excess pastry from the tart cases. Spoon 2 heaped tbsp mincemeat on top of the marzipan for each case. In a clean bowl using electric beaters, whisk the egg whites to soft peaks, then add the sugar 1 tbsp at a time, whisking constantly, until the mixture is shiny and stiff. Spread the meringue on top of the mincemeat and bake for 6-8 minutes, until golden.
    ', 1, 6),
    (12, 'Lemon Blueberry Meringues', 1, 4, current_timestamp-'97 hours 6 minutes'::interval, 'very hard', '110 minutes '::interval, '
    Step 1: Place all the curd ingredients into a small saucepan and whisk together over a medium heat. Cook, stirring often, for about 20 minutes, or until the mixture thickens. It will thicken more as it cools. Cool completely, then chill for at least 2 hours before using. It will be runnier than a traditional lemon curd but the perfect consistency for drizzling. If not using within a day or two, pour into a sterilised jar and keep in the fridge for up to a week.
    Step 2: For the vegan meringues, make sure your bowl and whisk attachments are clean and free of oil, as any grease will stop meringue peaks from forming. Preheat the oven to 110°C, gas mark ¼ and line a baking tray with parchment paper or a reusable silicone mat. Use 2 lined trays if necessary. 
    Step 3: Pour the aquafaba into a large mixing bowl (if using an electric hand mixer) or the bowl of a stand mixer. Beat on low until medium peaks form. Add the cream of tartar. Increase the speed to high and whisk until stiff peaks form. Once you have firmish peaks, start adding the sugar, a spoonful at a time, while continuing to whisk. Scrape down the sides of the bowl with a flexible spatula to make sure all the sugar is incorporated. Whisk until you have firm peaks that do not move at all.
    Step 4: Take a large, heaped spoonful of mixture and place on the lined tray. Use the back of a tablespoon to shape into a circle approx 10cm wide. Make a dent in the centre with the tip of the spoon, creating a nest shape. Repeat until all the mixture is used up, leaving about 2cm space between the nests. You should have 8 nests.
    Step 5: Bake for 1½ hours. Do not open the oven during that time. Turn the oven off and leave the meringues in there to dry for at least another 2 hours. They’re done when they are completely dry and peel off the baking parchment/silicone mat easily.
    Step 6: Softly whip the vegan cream alternative, then serve on top of the meringues. Top with a little vegan lemon curd and some blueberries, then decorate with mint leaves.
    ', 2, 29),
    (13, 'Fresh Cherry Bakewell Tarts', 5, 2, current_timestamp-'55 hours 29 minutes'::interval, 'very easy', '55 minutes '::interval, '
    Step 1: To make the pastry, mix the flour and icing sugar together in a large bowl. Rub in the 125g butter until the mixture looks like fine breadcrumbs. Stir in 3-4 tbsp cold water with a round-bladed knife until it all clumps together. Turn the dough onto a large piece of clingfilm and knead briefly until it comes together into a ball, then wrap and chill for 30 minutes.
    Step 2: Place the cherries and sugar for the filling into a small saucepan and heat gently, until the cherry juices are released and the sugar has dissolved. Turn up the heat and allow to bubble, stirring often, for 5 minutes, until jammy. Set aside to cool slightly.
    Step 3: Preheat the oven to 190ºC, gas mark 5, then put a baking tray in to heat up. Make the frangipane filling by beating together the softened butter and sugar in a bowl until light and fluffy. Add the egg, then fold through the ground almonds and almond extract.
    Step 4: Roll the chilled pastry out between 2 pieces of parchment to a thickness of about 2mm. Cut 10 x 10cm circles out of the dough, rerolling if necessary, then press the pastry into 10 holes of a 12-hole muffin tin (I use the base of a small cylindrical jar, such as a spice jar, to help push it into the edges). Prick the bases with a fork to remove any air pockets.
    Step 5: Spread 1 tsp cherry compote into the bottom of each pastry case. Top with the frangipane, making sure it completely covers the jam. Place onto the preheated baking tray and bake for 20-25 minutes. The frangipane will be golden on top but may feel a little squidgy in the middle. Allow to cool completely on a wire rack.
    Step 6:  Make the topping by mixing the icing sugar with enough water, around 1-2 tbsp, to make a thick paste. Transfer to a piping bag if you like, or use a teaspoon. Drizzle or spread the icing onto the top of the tarts and finish each one with a fresh cherry. These tarts will keep for up to 1 week in a sealed container, but I recommend adding the fresh fruit just before serving.
    ', 2, 16),
    (14, 'Cherry Chocolate Lava Puddings', 4, 4, current_timestamp-'95 hours 19 minutes'::interval, 'hard', '30 minutes '::interval, '
    Step 1: Preheat the oven to 200ºC, gas mark 6. Liberally butter 8 mini pudding moulds or large dariole moulds and lightly dust the insides with cocoa powder. This means the puddings will be easier to turn out once they are cooked. Cut a small circle of baking parchment, the same size as the base of each mould, and place inside each one to stop the top of the pudding from sticking.
    Step 2: Melt the chocolate and butter together in a large heatproof bowl set over a pan of barely simmering water. Stir until the mixture is smooth.
    Step 3: Crack the 2 whole eggs and add the 2 yolks into another large bowl, then add the sugar. Use a handheld electric beater to whisk the mixture until thick, fluffy and very pale. Fold in the melted chocolate using a spatula, then sieve over the flour and mix well to combine.
    Step 4: Place a spoonful of the mixture into each of the prepared moulds. Add a spoonful of cherries to the centre of each one. Cover with the remaining mixture – the moulds should be about ²/³ full. You can chill the puddings for up to 2 days at this stage.
    Step 5: Bake the puddings for 8-10 minutes. When ready, there should be a thin crust on the top but the centre should still have a slight wobble. Leave the puddings to stand for 2 minutes before turning out – I run a small palette knife around the inside of each mould to loosen it slightly first. Serve dusted with extra cocoa powder, if liked, a generous pouring of cream and a few extra cherries.
    ', 1, 7),
    (15, 'Strawberry Cream Choux Buns', 1, 4, current_timestamp-'100 hours 30 minutes'::interval, 'very hard', '75 minutes '::interval, '
    Step 1: Preheat the oven to 220°C, gas mark 7, and line a large baking tray with parchment. For the choux pastry, sift the flour into a large bowl and add a pinch of salt. Put the butter and 120ml water in a medium pan; melt over a medium heat. Increase the heat, bring to the boil, then very quickly tip in all the flour, take off the heat and beat really well with a wooden spoon until smooth and glossy (1⁄2-1 minute). It should come away from the sides of the pan and cling to the spoon; if it doesn’t, put it back over a high heat for up to 1 minute, beating constantly, until it does.
    Step 2: Off the heat, add a little beaten egg and beat well. Gradually add more, beating continuously, until the mixture is thick, shiny and drops off the spoon in 3 seconds (you may not need it all). Use a large spoon to dollop 6 mounds of the mixture onto the baking tray. Don’t worry about any little peaks. (If making in advance, cover and chill for up to 2 days.) 
    Step 3: Bake for 20 minutes, then reduce the oven temperature to 190oC, gas mark 5, and bake for a further 15-18 minutes, until puffed up, golden and hollow-sounding when tapped. Use a serrated knife to carefully cut each warm bun in half horizontally, then arrange on the tray, cut-side up. Return to the oven for 1-2 minutes, to ensure the centres are dry. Set aside until cooled completely. (They will keep in an airtight container for up to 2 days, but will benefit from being crisped up in the oven.)
    Step 4: Meanwhile, put the berries in a pan with 4 tbsp icing sugar, the lemon juice and a pinch of salt. Heat gently, stirring to dissolve the sugar, then bring to a simmer. Cover and cook for 3 minutes until syrupy. Transfer to a bowl and set aside to cool. (If making ahead, cover and chill for up to 3 days.) 
    Step 5: In a bowl, use a balloon whisk to whip the cream and remaining 2 tbsp icing sugar to almost firm peaks, then fold through the custard and 1 tbsp syrup from the strawberries. Spoon some of the syrupy strawberries onto the base of each bun, then top with cream, followed by the lids. Dust over a little extra icing sugar and serve right away. 
    ', 0, null),
    (16, 'Nectarine Marzipan Tart', 3, 4, current_timestamp-'82 hours 52 minutes'::interval, 'easy', '55 minutes '::interval, '
    Step 1: Preheat the oven to 240ºC, gas mark 9. Unroll the pastry onto a baking tray lined with baking parchment, reserving the paper it’s wrapped in. Use the back of a knife to score a 2cm margin around the rectangle (without cutting through). Fold the paper in half, put the marzipan in between, then use a rolling pin to flatten and roll it into a very thin sheet. Cut into long strips and arrange these randomly within the scored rectangle (there will be gaps, which is fine). Arrange the nectarine slices widthways in 3 long lines, again within the rectangle. A little overlap between the slices is good.
    Step 2: Brush the melted butter over the nectarines, then slide the tray into the top of the oven. Lower the temperature to 200ºC, gas mark 6, and bake for 20 minutes. Remove from the oven, scatter over the hazelnuts (rotate the tray if your oven cooks unevenly) and cook for a final 5-10 minutes. Meanwhile, melt the apricot conserve in a small pan over a low heat.
    Step 3: When the tart is ready (the pastry should be golden and the fruit soft but not burned), remove it from the oven. Brush the melted apricot conserve all over the pastry and fruit, then leave to cool. Serve at room temperature with Greek style yogurt or crème fraîche.
    ', 1, 8),
    (17, 'Blueberry Lattice Pie', 5, 10, current_timestamp-'28 hours 17 minutes'::interval, 'medium', '100 minutes '::interval, '
    Step 1: Divide the pastry into 200g and 300g pieces. Wrap the smaller piece and chill for later. On a lightly floured surface, roll the larger piece to the thickness of a £1 coin and use to line a 23cm fluted tart tin, 2-4cm deep. Trim the edges so there’s about 1-2cm pastry overhanging; chill for 30 minutes.
    Step 2: Preheat the oven to 200oC, gas mark 6. Prick the base of the pastry all over with a fork, then line with baking parchment and fill with baking beans. Blind bake for 10 minutes, then remove the parchment and beans. Brush all over with egg white (reserve the remainder) and bake for 10 minutes more. Cool fully; trim the overhanging pastry with a serrated knife.
    Step 3: Mix the cornflour, 4 tbsp sugar, the lemon zest, 1⁄2 tsp cinnamon and a pinch of salt in a large mixing bowl. In another bowl, use a fork to very lightly crush 100g blueberries with the lemon juice, then toss with the remaining berries into the cornflour mixture, ensuring everything is evenly mixed. Tip this mixture into the cooled tart case.
    Step 4: Roll the reserved chilled pastry into a rectangle at least 28cm long and about 20cm wide. Cut 10 long, equal strips and arrange these over the blueberries in a lattice formation. Trim the edges level with the tin. Chill for 30 minutes.
    Step 5: Lightly whisk the reserved egg white until frothy and brush over the top of the lattice. Mix the remaining 1⁄2 tbsp sugar and 1⁄4 tsp cinnamon and sprinkle over the lattice pastry. Bake for 35-45 minutes, until golden and bubbling. Cool completely before serving with crème fraîche, if liked.
    ', 0, null),
    (18, 'Jelly and Custard Celebration Cake', 4, 8, current_timestamp-'62 hours 49 minutes'::interval, 'easy', '95 minutes '::interval, '
    Step 1: Preheat the oven to 180ºC, gas mark 4. Grease 3 x 20cm loose-bottomed sandwich tins and line the bases with baking parchment. For the cake, put the sugar and baking spread (or butter) into the bowl of a freestanding mixer and beat until pale and fluffy. (Alternatively, put everything in a large bowl and use an electric hand mixer.)
    Step 2: Add the eggs, 1 at a time, beating after each addition until completely incorporated. Once added, the mixture may look a little split, but that’s normal. Heat the milk in a small pan until hot. Add the hot milk, which may help bring the mixture back together. Don’t worry if it makes it look worse. 
    Step 3: Sift the flour, custard powder, baking powder and ½ tsp fine salt into a bowl. Fold 1 / 3 of this into the egg mixture using a large metal spoon or spatula, then repeat twice more. Once you have a smooth batter, divide it between the cake tins as evenly as possible, then bake for 20-25 minutes, or until a skewer inserted into the centre of each cake comes out clean. Remove the cakes from the oven and allow to cool completely in their tins.
    Step 4: While the cakes bake, make the custard. Put the milk, 50g of the sugar and the vanilla pod and seeds into a medium saucepan and set over a medium heat. In a heatproof bowl, whisk together the egg yolks and the remaining 50g sugar, then add the custard powder and whisk until pale and the sugar is more or less dissolved. Increase the heat to high and allow the milk to come to a boil, then pour the milk onto the egg yolk mixture in a steady stream as you whisk constantly. Putting a damp tea towel underneath the bowl will keep it from rocking around while you whisk. 
    Step 5: Once the milk is well combined with the egg mixture remove the vanilla pod, then pour it back into the pan, off the heat. Whisk vigorously and return to a high heat. Do not stop whisking, and ensure the whisk is touching the base of the pan at all times. Allow the custard to boil and thicken, then pour into a shallow bowl or plate and cover the surface of the custard directly with clingfilm or damp baking parchment. Allow to cool completely, then pop into the fridge. 
    Step 6: For the frosting, dissolve the jelly crystals in 2 tbsp water and set aside. Put the egg whites into the bowl of a freestanding mixer fitted with a whisk attachment (or use a large heatproof bowl and an electric hand mixer). Put the sugar into a saucepan with 50ml water and stir over a low heat to dissolve, then turn the heat up to high. When the sugar syrup reaches 110ºC on a kitchen thermometer (I use an instant-read digital thermometer), set the mixer to a medium speed to start breaking down the egg whites. 
    Step 7: Add the jelly mixture to the sugar and swirl in the pan to combine. Continue to heat the sugar and jelly mixture to 118ºC, then pour it over the egg whites in a thin, steady stream running down the inside of the bowl, with the mixer still on medium. Once all the sugar syrup has been incorporated, turn the mixer to high and beat for a good 10 minutes to make a stiff, glossy meringue. You can also beat in ½ tsp fine salt, if liked, but this is optional. 
    Step 8: With the mixer still running on high speed, add the room temperature butter to the meringue 1 piece at a time, allowing each to incorporate before adding the next. This is a slow process, so enjoy it! As you add the butter, the mixture may deflate and look split and curdled, but be patient and keep going. Once you’ve added all the butter, it should start to thicken to a luscious pink buttercream. If it doesn’t, carefully heat the sides of the bowl with a chef’s blowtorch (or sit the bowl over a pan of just-boiled water) while beating.  The heat should help the mixture to emulsify.
    Step 9: To assemble, place 1 layer of cake onto the cake card and sit it on a cake turntable, or cake stand – a little blob of buttercream helps to stick the cake in place. Fill the piping bag with some buttercream and pipe a ring of buttercream around the edge of the cake. Spread 3 tbsp of the raspberry preserve across the cake, inside the ring of buttercream. Return the cold custard to a mixing bowl and beat until smooth (this takes some elbow grease), then spread a generous layer on top of the jam, still keeping within the buttercream boundary. Top with a second layer of cake and repeat. You may have a little custard left over – it’ll keep under wraps in the fridge for 5 days. Top with the final cake layer, flat side facing up. Pop the cake in the fridge for 20 minutes for the buttercream to firm up. 
    Step 10: Although not essential, I like to ensure the cake is even by taking a bread knife and trimming off the outside edge of the cake all the way around – just 0.5cm or so off the edge makes for a neater cake. Keep the knife straight and level as you cut. It doesn’t matter if the cake ends up more of a polygon than a perfect cylinder, because when you spread the icing on you can make it round again.
    Step 11: Spread a thin layer of buttercream over the sides and top to make a ‘crumb coat’ – using an angled palette knife and cake turntable makes it easier. Chill for 20 minutes to firm up, then spread the rest of the buttercream in a generous layer all over the sides and top of the cake. Get the icing as sharp and smooth as possible. I find a bench scraper or the base of a square cake tin helpful to get this as neat as possible. To create the messy crown effect on the rim, take small portions of buttercream on the end of the palette knife and pile them around the top edge of the cake. Smooth the top of the cake out first, shaving right up to the messy crown edge with the palette knife, then carefully smooth the sides. Pop the cake in the fridge to firm up for 20 minutes or so. 
    Step 12: To finish, mix the gold lustre with the vodka or lemon juice to create a thick paste. Paint the top edge of the crown to make it gold, then you’re ready to serve. Carefully transfer the cake to a cake stand if using a turntable.
    ', 2, 32),
    (19, 'Mint Chocolate Cheesecake', 3, 8, current_timestamp-'21 hours 54 minutes'::interval, 'easy', '35 minutes '::interval, '
    Step 1: Grease and line a 20cm round springform cake tin. Put the biscuits in a bowl and use the end of a rolling pin to crush them to fine crumbs. Pour the melted butter into the bowl; mix well. Spread the mixture into the prepared tin and refrigerate for 15 minutes. 
    Step 2: Bring a medium pan of water to the boil, then take it from the heat. Add most of the mint (reserving a few small leaves to decorate) and blanch for 1 minute, until bright green. Drain, then plunge into a bowl of ice-cold water for a few minutes. Pat dry with kitchen paper and put in a food processor with the soft cheese. Whizz very briefly until combined and flecked green, then transfer to a large bowl.
    Step 3: In a separate large bowl, use a balloon whisk to whip the cream and the icing sugar to soft peaks. Add the cheese mixture and chopped chocolate then fold together. Spread this evenly on top of the biscuit base, then chill for 4-5 hours or overnight. 
    Step 4: Loosen the sides with a knife before unclipping the sides of the tin. Lift from the base of the tin, remove the lining paper and transfer to a plate. Scatter the reserved mint leaves on top just before serving. 
    ', 2, 24),
    (20, 'Blueberry Burnt Basque Cheescake', 5, 8, current_timestamp-'97 hours 56 minutes'::interval, 'medium', '55 minutes '::interval, '
    Step 1: Preheat the oven to 240ºC, gas mark 9. Line a deep 20cm round cake tin with 2 large pieces of baking parchment, arranging them so the sides are fully covered and the parchment is visible over the top. Don’t worry if there are creases in the paper, this is part of the cheesecake’s rustic charm.
    Step 2: Tip the cream cheese into a large mixing bowl and beat until smooth. Add the soured cream, followed by 250g sugar, and mix again. Beat the eggs together in a separate bowl, then stir gently into the cream cheese mixture.
    Step 3: Stir a little of the runny batter into 2 tbsp of the cornflour to make a paste, then mix back into the main mixture, along with the lemon zest. Pour into the lined cake tin and remove any air bubbles by tapping against a flat surface.
    Step 4: Bake in the centre of the oven for 30-40 minutes. The top should be a deep brown, almost burnt colour when ready. The middle will be wobbly, but this will set as the cheesecake cools down. Allow to cool completely in the tin.
    Step 5: Combine the blueberries, the remaining 100g sugar and lemon juice in a small saucepan. Heat over a low heat for 5 minutes, stirring regularly, until the sauce is thick and the blueberries are beginning to burst. Mix the remaining ½ tbsp cornflour with 1 tbsp water to make a slurry, then add into the blueberry mixture. Heat for 1 minute more, or until glossy and thickened.
    Step 6: Once the cheesecake and sauce have cooled to room temperature, serve in generous slices with a spoonful of the sauce. You can also serve both chilled, if liked.
    ', 1, 9),
    (21, 'Saffron Cardamon Pavlova', 5, 4, current_timestamp-'67 hours 19 minutes'::interval, 'easy', '10 minutes '::interval, '
    Step 1: Put 2 tbsp of the whipping cream into a microwavable bowl and warm in the microwave for two 10-second bursts. Place the saffron in the warm cream to steep for a few minutes, or until cooled completely. 
    Step 2: Meanwhile, in a pestle and mortar, crush the cardamom pods and discard the outer green husks. You will be left with seeds from the insides. Crush until they resemble a powder
    Step 3: Pour the whipping cream into a large bowl, along with the cooled, saffron-steeped cream, icing sugar and cardamom powder. Whisk until you get beautiful soft, silky peaks of cream.
    Step 4: When ready to serve, slather the cream over the meringue, top with the strawberries, almonds, rose petals and add some gold leaf, if using. Serve immediately. 
    ', 1, 10),
    (22, 'Chocolate Almond Simnel Cake', 3, 8, current_timestamp-'50 hours 28 minutes'::interval, 'hard', '135 minutes '::interval, '
    Step 1: Preheat the oven to 160ºC, gas mark 3. Grease and line the base and sides of a 20cm round tin with baking parchment. 
    Step 2: In a large bowl, combine the butter and sugar and beat for a few minutes, until light and fluffy. Add the flour, cocoa powder, mixed spice and eggs and mix until smooth. Fold in the dried fruit, then place ½ the mixture into the prepared tin and smooth the surface.
    Step 3: Take 1/3 of the marzipan and roll out into a disc the same size as the cake tin. Place the disc on top of the mixture, then spoon the remaining batter over the marzipan. Use a spoon to push the mixture right to the edges of the tin.
    Step 4: Bake the cake in the preheated oven for 1 hour 30 minutes-1 hour 45 minutes, until the top is a dark golden brown and a skewer inserted into the centre comes out clean. Leave to cool in the tin before turning it out.
    Step 5: Roll ½ the remaining marzipan into a disc the same size as the cake. Make the remaining ½ into 11 equal-sized balls. Warm the marmalade, then brush it over the top of the cake. 
    Step 6: Crimp the edges of the marzipan disc and gently press it onto the cake. Arrange the marzipan balls evenly around in a circle. Place the whole cake under the grill (or use a blowtorch) to gently toast the marzipan. Keep a close eye on it because you don’t want to burn the cake right at the end. 
    Step 7: Allow the cake to cool for a few minutes, then press a chocolate coated almond into each ball. This cake will keep for up to 2 weeks stored in an airtight container. 
    ', 1, 11),
    (23, 'Easter Carrot Patch Traybake', 5, 11, current_timestamp-'81 hours 15 minutes'::interval, 'very easy', '85 minutes '::interval, '
    Step 1: Preheat the oven to 170°C, gas mark 3. Line a 23x33cm tray with baking parchment.
    Step 2: In a large bowl, whisk the sugars, oil and eggs together until smooth. Slowly add the flour, bicarbonate of soda, baking powder, cinnamon, ginger and ½ tsp salt, then beat until well mixed.
    Step 3: Stir in the carrots and walnuts until evenly dispersed. Pour into the lined tin and bake for 35-40 minutes, or until golden and a skewer inserted into the centre comes out clean. Allow to cool in the tin for 20 minutes, then turn out and cool completely on a wire rack before icing.
    Step 4: To make the icing, use an electric whisk to blend the soft cheese and butter together. Add the icing sugar in a few separate stages until it is all combined, then whisk on high speed for 5 minutes, or until the mixture is thick, pale and light.
    Step 5: For the chocolate soil, combine the caster sugar and 2 tbsp water in a small saucepan. Heat over a medium heat until the edges of the sugar syrup turn to a pale brown colour. Remove from the heat and add the chocolate, then stir vigorously until a soil-like powder forms. Spread onto a baking tray and leave to cool completely.
    Step 6: Place the cake onto a serving board and spread the top and sides with cream cheese icing. If needed, cut the chocolate sticks/fingers into lengths about the same depth as the cake, then use them to cover the outside edges to make a fence. Sprinkle the chocolate soil over the cake, then nestle in the fondant carrots. This cake will keep in the fridge for up to 4 days.
    ', 0, null),
    (24, 'Choc Chip Cookie Cups', 2, 2, current_timestamp-'97 hours 38 minutes'::interval, 'very hard', '45 minutes '::interval, '
    Step 1: Using electric beaters, mix the butter and sugars in a large bowl for 2 minutes until light and combined. Beat in the egg and vanilla paste, then add the flour, bicarbonate of soda and salt. Beat together for 2 minutes until completely combined. Finely chop 100g of the chocolate and stir through the dough. Cover and chill in the fridge for 1 hour.
    Step 2: Preheat the oven to 180 °C, gas mark 4. Lightly grease a 12-hole muffin tin and dust lightly with flour. Divide the chilled cookie dough into 12 equal portions. Take one portion and press it into a hole in the tin (1⁄3 of the mixture will be above the rim). Top with 2 squares of chocolate, then flatten out the dough above the rim and press over the top to seal at the edges. Repeat to make 12 cookie cups.
    Step 3: Bake the cookie cups for 15-18 minutes until golden on top. Remove from the oven and cool in the tin for 10 minutes, then use a knife to help ease them out onto a wire rack. Serve while they are still warm.
    ', 1, 12),
    (25, 'Christmas Pudding Doughnuts', 3, 12, current_timestamp-'24 hours 54 minutes'::interval, 'easy', '90 minutes '::interval, '
    Step 1: To make the dough, put the flour, yeast, sugar and salt into the bowl of a freestanding mixer and mix to combine. Add the milk and egg and stir together to form a shaggy dough. With the dough hook attached, knead on a low-medium speed for about 10 minutes, until the dough is smooth and elastic. With the mixer still running, add the butter a piece at a time and continue kneading until all the butter has been combined and the dough becomes smooth and elastic again (it should form a ball that clings to the dough hook). Scrape the dough into a lightly oiled bowl, cover with a damp clean tea towel and chill overnight.
    Step 2: For the filling, combine the apple, sugar and lemon juice in a small pan; cook over a medium heat until tender and lightly caramelised. Add the Christmas pudding and 50ml water; cook until the mixture forms a moist but not wet paste. Remove from the heat and set aside to cool.
    Step 3: Tip the dough out onto a lightly floured work surface and roll into a 50cm x 40cm rectangle. Spread the Christmas pudding paste over the entire surface of the dough, then sprinkle with a thin dusting of flour. Roll up from the longest side into a cylinder. Flatten the cylinder slightly, then use a sharp knife to cut the roll into long, thin strips. Slice again at a 45º angle to cut the dough into little diamonds. Sprinkle the pieces of dough with a little flour and gently push back together into a sausage shape that resembles the original roll (the flour will act as glue and stick the filling and sticky brioche dough together). It doesn’t have to be done too exactly. Cut the sausage into 6 slices widthways and put, cut-side down, on a lightly floured surface. Gently shape into discs. Cover the doughnuts with baking parchment and prove for 30 minutes, until slightly puffed.
    Step 4: When ready to cook, fill a medium-sized saucepan three-quarters full with vegetable oil and heat over a medium heat, until it reaches 170-180ºC on a sugar thermometer. Once at temperature, lower the temperature a little to maintain it within that range. Fry the doughnuts two at a time, cooking for 2-3 minutes until a deep golden brown, turning once halfway through cooking. Use a slotted spoon to carefully lift out onto a baking tray lined with kitchen paper, to absorb any excess oil.
    Step 5: To make the glaze, mix the icing sugar and cranberry juice together in a wide, shallow bowl. Dip the doughnuts one by one into the glaze, allowing the excess to fall back into the bowl, then set them aside for a few minutes until the glaze has set. As with all doughnuts, these are best served on the day they are cooked. However, the dough can be made in advance, covered and chilled for up to 2 days, if liked.
    ', 1, 13),
    (26, 'Grape Almond Clafoutis', 5, 13, current_timestamp-'56 hours 55 minutes'::interval, 'medium', '45 minutes '::interval, '
    Step 1: In a medium bowl, mix together the grapes, amaretto and 1 tbsp caster sugar, then leave to macerate for 2 hours.
    Step 2: Grease a 25cm round baking dish; sprinkle 1 tbsp sugar over to coat. Heat the oven to 180ºC, gas mark 4. Put the grape mixture into the baking dish. In a blender, whizz together 80g sugar with the eggs, milk, flour and vanilla until smooth. Pour the batter over the grapes; bake for 25-30 minutes, or until slightly risen and golden. Sprinkle over the almonds, dust with the icing sugar and serve.
    ', 0, null),
    (27, 'Pumpkin Caramel Ginger Baked Cheescake', 3, 14, current_timestamp-'90 hours 37 minutes'::interval, 'very easy', '190 minutes '::interval, '
    Step 1: Preheat the oven to 180ºC, gas mark 4. Toss the pumpkin or squash in a large roasting tin with the oil and roast for 1 hour-1 hour 30 minutes, until tender. Turn the oven off. Set aside to cool, then scoop the flesh into a food processor and whizz to a smooth purée.
    Step 2: Lightly grease the insides of a 23cm springform cake tin with butter and wrap the outside well with 2 sheets of foil, so it comes up the sides
    Step 3: Melt the butter then, in a food processor, whizz the ginger biscuits to a fine crumb. Mix in the melted butter and evenly press into the tin, so it comes a few centimetres up the sides; set aside. Put the soft cheese, cornflour and sugars in a large mixing bowl and, using electric beaters, beat until smooth and light. Beat in the eggs, pumpkin purée and double cream until smooth. Finally add the vanilla, ginger and sea salt. Mix together, then pour into the prepared cake tin. Heat the oven to 180ºC, gas mark 4.
    Step 4: Bring a kettle of water to the boil. Put the cake tin in a high-sided roasting tin and put in the oven, then carefully pour enough boiling water into the tin so that it comes almost halfway up the sides – don’t get any on the cheesecake. Bake for 1 hour. You want the cheesecake to be just set, with a very slight jiggle. If it is too wobbly, give it an extra 5-10 minutes. When it is ready, turn off the oven, leave the door ajar and allow the cheesecake to cool in the oven for 1 hour. Remove from the oven, cool to room temperature, then put in the fridge to firm up, ideally overnight, before serving. To serve, warm the caramel sauce according to pack instructions and drizzle over the cheesecake.
    ', 2, 3),
    (28, 'Cinnamon Bun Pudding', 3, 7, current_timestamp-'25 hours 35 minutes'::interval, 'very hard', '50 minutes '::interval, '
    Step 1: Preheat the oven to 170ºC, gas mark 3. Halve the cinnamon buns (as you would a burger bun) and arrange, overlapping, in an ovenproof dish (about 1 litre in capacity).
    Step 2: In a medium saucepan, heat the cream, vanilla and milk until steaming. Meanwhile, in a mixing bowl, use a balloon whisk to whisk the eggs and sugar. Slowly pour the hot milk mixture over the eggs, whisking continuously until combined. Pour this custard all over the buns, making sure they are well-soaked.
    Step 3: Bake for about 30 minutes until the pudding is just golden in places and set on top. Stand for 5 minutes before serving.
    ', 1, 14),
    (29, 'Deep Dish Apple Pie', 1, 8, current_timestamp-'67 hours 60 minutes'::interval, 'very hard', '90 minutes '::interval, '
    Step 1: On a lightly floured surface, roll out the pastry into a large rectangle, as thin as possible. Chop the butter into small cubes, then sprinkle evenly across the bottom ½ of the pastry. Fold the top of the pastry over the butter to trap it, and lightly roll with a rolling pin to fuse the sheets together. Fold the bottom ¹/³  up, then the top ¹/³ over the bottom to make a rectangle. Finally, fold in ½ to create a square shape, then wrap and return to the fridge for at least 15 minutes, or until ready to use.
    Step 2:  Preheat the oven to 180ºC, gas mark 4 and place a baking tray onto a shelf to heat up. Peel and core the apples for the filling, then slice into thin wedges. Place in a large bowl and add 100g sugar, the cinnamon, nutmeg, cornflour and lemon juice. Toss to coat, then set aside while you line the tin.
    Step 3: Take ²/³ of the pastry and roll it out into a large circle, then press into the base of a 5x20cm metal or enamel pie dish, leaving the excess overhanging. Fill the pie with the apple slices, using your hands to press them firmly into the dish. Some liquid will be left at the bottom of the bowl – don’t pour it all into the pie, or the pastry will be soggy. Take 3 tbsp of the liquid and drizzle it over the apples. Discard the remainder. 
    Step 4: Roll the remaining pastry into a circle slightly bigger than the dish, then drape over the top. Press it flush against the apple filling and crimp the edges to seal. Use a sharp knife to trim the edges. Brush the top of the pie with egg wash and decorate with any leftover pastry, if liked, with writing or shapes, for example. Brush the top of any decoration and cut 3 incisions into the pastry top to allow steam to escape. 
    Step 5: Sprinkle with 1 tsp sugar, then bake on the preheated baking tray for 1 hour. Cover with foil if the pie is browning too quickly. Allow to cool to almost room temperature before serving (or the pie won’t hold its shape). 
    ', 1, 15),
    (30, 'Raspberry Almond Galette', 4, 15, current_timestamp-'66 hours 19 minutes'::interval, 'easy', '55 minutes '::interval, '
    Step 1: For the pastry, whizz the almonds, flour, thyme, sugar and a pinch of salt in a food processor, until combined. Pulse in the butter until it resembles breadcrumbs, then gradually add ½ the beaten egg until it comes together into a ball. (Reserve the remaining egg.) Tip onto the work surface, shape into a disc and wrap. Chill for 30 minutes.
    Step 2: Preheat the oven to 180ºC, gas mark 4. Put a large, flat baking sheet into the oven to heat up. In a large bowl, toss the raspberries with the cornflour, 2 tbsp sugar and a pinch of salt. Put the pastry between 2 sheets of baking parchment and roll out to a 30cm circle, about 0.3cm thick (don’t worry if it’s imprecise). Lift off the top sheet of parchment and pile the fruit mixture into the middle of the pastry circle (leaving any juices behind in the bowl), allowing a 5cm border. Bring the pastry edges up around the fruit in a rustic fashion, leaving a gap in the middle. Brush the pastry rim with the reserved beaten  egg and scatter over the remaining 1 tbsp sugar. 
    Step 3: Slide the galette, on the parchment, onto the hot baking sheet. Bake for 30-35 minutes, until the pastry is golden and the fruit jammy. Remove from the oven and set aside to cool for 20 minutes (still on the baking sheet). Remove the parchment, scatter over more lemon  thyme leaves and serve warm or at room temperature with crème fraîche or cream, if liked.
    ', 2, 26),
    (31, 'Avocade Chocolate Tart with Candied Tangerine', 4, 16, current_timestamp-'53 hours 41 minutes'::interval, 'hard', '60 minutes '::interval, '
    Step 1: Put the biscuits in a large bowl. Crush into crumbs with the end of a rolling pin (or pulse in a food processor), then add the cocoa powder. Stir through the melted vegan butter alternative until the crumbs are well coated. Press into the base of a 23cm flan tin and chill for at least 30 minutes, or until set.
    Step 2: Meanwhile, to make the candied tangerines, put the sugar into a medium saucepan with 175ml cold water. Bring to a simmer. Stir until the sugar has dissolved, then add the tangerine slices. Simmer gently for 15-20 minutes, or until the tangerine begins to look translucent and the syrup has thickened. Remove using a slotted spoon (keep the syrup for later) and leave to cool and dry slightly on a cooling rack. 
    Step 3:  Melt the dark chocolate in the microwave or over a pan of barely simmering water. Scoop the flesh out of the avocados (discarding the stone) and place into a blender, then blitz until smooth. Drizzle in the melted chocolate, along with the tangerine zest and 100ml of reserved tangerine syrup. Blitz well until smooth, then spread into the tart case. Top with the candied tangerine and pistachios, then chill for at least 30 minutes.
    Step 4: Remove from the fridge and leave to stand at room temperature for 10 minutes before slicing. If there is any leftover syrup, you could drizzle a little over the top before serving. 
    ', 0, null),
    (32, 'Ice Cream Cookie Cups', 3, 2, current_timestamp-'87 hours 32 minutes'::interval, 'very hard', '40 minutes '::interval, '
    Step 1: To make the cookie dough, first brown the butter. Add the butter to a saucepan and set over a medium heat until the butter has completely melted, then increase the heat to high and allow the butter to come to a boil. Swirl the pan occasionally as the butter boils. When the bubbling stops and a fine cappuccino-like foam appears on the surface – accompanied by a nutty toffee aroma – pour the butter into the bowl of a freestanding electric mixer fitted with paddle attachment. Allow to cool. 
    Step 2: Once cooled, add the sugars, then beat until well combined. Add the vanilla bean paste and egg and beat again. Sift the flour, baking powder, bicarbonate of soda and salt together in a bowl, then add to the mixer and beat to a smooth dough. Cover and chill in the fridge for 20 minutes to firm up. 
    Step 3: Preheat the oven to 190ºC, gas mark 5. Grease the wells of a 12-hole muffin tin with a little butter. Divide the dough into 12 equal balls (I weigh the bulk of the dough, then divide this by 12 to be precise), then put 1 ball into each cavity of the greased tin. Use the end of a rolling pin or a small jar, dipped in flour, to press down onto each portion of dough, forcing it into a little cup shape. Neaten up the edges with your fingers, if needed. 
    Step 4: Bake for 15-18 minutes, until the cookie cups start to set. They will dramatically puff up while baking, so quickly press down again with the rolling pin when you remove them from the oven to reform the cup shapes. Take care as the tin and dough will be very hot. Allow to cool in the tin before transferring to a wire rack. Use a palette knife to gently release the cups if they are a little stuck. 
    Step 5: Once the cookie cups have cooled completely, move the ice cream to the fridge and let it soften for 10 minutes. Fill the cups with ice cream and spread it level with the edges of the cups using a small offset palette knife. Place onto a tray and into the freezer for the ice cream to firm up again. At this point, you could pop them into an airtight container and keep them in the freezer for up to 3 months, moving onto the next step just before serving. 
    Step 6: When ready to serve, melt the chocolate either in a heatproof bowl set over a pan of barely simmering water, stirring occasionally, or give it a couple of 10-second blasts in the microwave. Whip the whipping cream to soft, floppy peaks and either pile it on top of the ice cream in a heap or use a piping bag and star nozzle to pipe a more traditional sundae-style swirl. Drizzle over the melted chocolate and finish with a sprinkling of chopped peanuts (or sprinkles if you choose to use those instead). 
    ', 2, 31),
    (33, 'Cherry and Almond Baklava', 2, 17, current_timestamp-'66 hours 38 minutes'::interval, 'hard', '65 minutes '::interval, '
    Step 1: Heat a frying pan over a medium heat and add 100g sugar, covering the base evenly. Don’t touch it until it starts melting and caramelising, then add all the cherries and the star anise in one go. Take care as it will spit and seize up a bit. Use a wooden spoon to mix everything around to release some juice from the cherries, then add 80ml water. Bring to the boil and use the back of a spoon to smoosh some of the cherries and break up any remaining bits of caramel, which will dissolve. In a small cup, mix the cornflour with a little cold water to a paste, then pour into the boiling cherry liquid, mixing all the time. It should thicken at once so wait for the frst bubbles to appear, then take off the heat. Discard the star anise. 
    Step 2: Preheat the oven to 220ºC, gas mark 7. Melt the butter or ghee in a small pan. Unroll the filo onto the work surface. Brush half a sheet with melted butter or ghee and fold in half. Brush the base of a 23cm square cake tin with a little butter and lay in the first folded sheet.  Repeat with another 3 buttered, folded sheets, then sprinkle over 70g faked almonds. Cover with the cherry compote, spreading to the edges. Butter and fold the remaining 3 filo sheets in the same way and use to form a lid over the compote. Brush the top with more melted butter or ghee and sprinkle over the remaining almonds and sugar. 
    Step 3: Use a sharp knife to cut the pastry down the middle, then across to form 4 squares, then diagonally to form 8 triangles. Bake in the top of the oven for 15-20 minutes until golden. Serve warm or at room temperature, with cream or vanilla ice cream, if liked. 
    ', 1, 16),
    (34, 'Chocolate and Salted Caramel Traybake', 2, 18, current_timestamp-'13 hours 41 minutes'::interval, 'easy', '55 minutes '::interval, '
    Step 1: Preheat the oven to 180oC, gas mark 4; lightly grease a 33cm x 22cm cake tin and line with baking parchment. Using an electric hand mixer, cream together the butter and sugar in a large mixing bowl for 2-3 minutes until light and fluffy. Beat in the eggs, one at a time, then stir in the vanilla and melted chocolate. Next, stir in the buttermilk until combined.
    Step 2: Mix together the flour, bicarbonate of soda, cocoa powder and salt, then sift into the mixture and fold in until combined. Tip into the cake tin, level the top and bake for 22-25 minutes until risen and a skewer inserted into the centre comes out clean. Set aside to cool completely in the tin.
    Step 3: Remove the cooled caked from the tin. Spread the icing evenly over the top, then drizzle with the 30g melted chocolate for the topping. Allow to set for 5 minutes, then scatter over the raspberries, slice into squares and serve with crème fraîche or whipped cream, if liked.
    ', 1, 17)
    ;

INSERT INTO products VALUES 
(1, 'unsalted butter', 3),
(2, 'caster sugar', 1),
(3, 'blacktailfreeeggs', 1),
(4, 'selfraising flour', 1),
(5, 'baking powder', 1),
(6, 'fine salt', 1),
(7, 'milk', 3),
(8, 'pods', 1),
(9, 'vanilla extract', 1),
(10, 'pack no strawberries', 1),
(11, 'unsalted butter', 3),
(12, 'plain flour', 1),
(13, 'icing sugar', 1),
(14, 'ground almonds', 1),
(15, 'whites about g', 1),
(16, 'lemon', 2),
(17, 'lemonleaves', 1),
(18, 'packblueberries', 1),
(19, 'flaked almonds', 1),
(20, 'packs fullfatcheese', 1),
(21, 'condensed milk', 3),
(22, 'scrubbed', 1),
(23, 'double cream', 1),
(24, 'sachetpowder', 1),
(25, 'dark chocolate', 1),
(26, 'milk chocolate', 1),
(27, 'white chocolate', 1),
(28, 'packfruitchips', 1),
(29, 'pistachios', 1),
(30, 'packsmaman madeleine', 1),
(31, 'cooksrose petals', 1),
(32, 'seaflakes', 1),
(33, 'anise', 1),
(34, 'whole milk', 3),
(35, 'strongbread flour', 1),
(36, 'finesalt', 1),
(37, 'caster sugar', 1),
(38, 'sachet easybake yeast', 1),
(39, 'unsalted butter', 1),
(40, 'lemonscrubbed orange', 1),
(41, 'colouredandchocolate eggs', 1),
(42, 'butter', 3),
(43, 'blanchedalmonds', 1),
(44, 'dark chocolate', 1),
(45, 'blacktailrangeeggs', 1),
(46, 'caster sugar', 1),
(47, 'cocoa powder', 1),
(48, 'toastedalmonds', 1),
(49, 'double cream', 1),
(50, 'lightsoft sugar', 1),
(51, 'disaronno', 1),
(52, 'sunflower oil', 1),
(53, ' eggs', 1),
(54, 'caster sugar', 1),
(55, 'greekstyleyogurt', 1),
(56, 'vanillaextract', 1),
(57, 'selfraising flour', 1),
(58, 'fine semolina', 1),
(59, 'fine salt', 1),
(60, 'whole milk', 1),
(61, 'lightsoft sugar', 1),
(62, 'sachetbake yeast', 1),
(63, 'strongflour', 1),
(64, 'finesalt', 1),
(65, 'britishlargerange eggs', 1),
(66, 'limesof allof ', 1),
(67, 'fullfatcheese', 1),
(68, 'icing sugar', 1),
(69, 'choppeddates', 1),
(70, 'bicarbonatesoda', 1),
(71, 'fair trade strength brewed powder', 1),
(72, 'butter', 3),
(73, 'fairtradebrownsugar', 1),
(74, 'blacktailfreeeggs', 1),
(75, 'golden syrup', 1),
(76, 'selfraising flour', 1),
(77, 'milk', 3),
(78, 'essential olive oil', 1),
(79, 'about  pittedmedjool dates', 1),
(80, 'blacktailrangeeggs', 1),
(81, 'caster sugar', 1),
(82, 'belgianchocolate ', 1),
(83, 'cocoa powder', 1),
(84, 'baking powder', 1),
(85, 'pack rolled pastry sheet', 1),
(86, 'marzipan', 1),
(87, ' eggs', 1),
(88, 'mincemeat approx g', 1),
(89, 'caster sugar', 1),
(90, 'aquafaba from can chickpeas', 2),
(91, 'cream tartar', 1),
(92, 'oatly creamy cream alternative', 1),
(93, 'blueberries', 1),
(94, ' sprigs mint', 1),
(95, 'plain flour', 1),
(96, 'icing sugar', 1),
(97, 'butter', 1),
(98, 'cocoa powder', 1),
(99, 'dark chocolate', 1),
(100, 'blacktailrangeeggs', 1),
(101, 'plain flour', 1),
(102, 'cherries', 1),
(103, 'pouring cream', 1),
(104, 'strawberries', 1),
(105, 'icing sugar', 1),
(106, 'lemon juice', 1),
(107, 'essentialcream', 1),
(108, 'fresh custard', 1),
(109, 'readyrolledbutterpastry', 1),
(110, 'golden marzipan', 1),
(111, 'flesh nectarinesandinto cm slices', 1),
(112, 'salted butter', 1),
(113, 'roastedhazelnuts', 1),
(114, 'apricot conserve', 1),
(115, 'greekyogurtcrme frache', 1),
(116, 'packpastry block', 1),
(117, 'plain flour', 1),
(118, 'freewhitewhite', 1),
(119, 'cornflour', 1),
(120, 'caster sugar', 1),
(121, 'lemon', 1),
(122, 'ground cinnamon', 1),
(123, 'gwaitrose blueberries', 1),
(124, 'crme frache', 1),
(125, 'caster sugar', 1),
(126, 'bakingorunsalted butter', 1),
(127, 'blacktaileggs ', 1),
(128, 'whole milk', 1),
(129, 'selfraising flour', 1),
(130, 'birdspowder ', 1),
(131, 'baking', 1),
(132, 'packorchocolate digestives', 1),
(133, 'gorgrowingof mint', 1),
(134, 'soft cheese', 3),
(135, 'icing sugar', 1),
(136, 'dark chocolate', 1),
(137, 'waitroseorganiccheese', 1),
(138, 'soured cream', 1),
(139, 'caster sugar', 1),
(140, 'blacktailrangemedium', 1),
(141, 'cornflour', 1),
(142, 'blueberries', 1),
(143, 'whipping cream', 1),
(144, 'saffron', 1),
(145, 'cardamom pods', 1),
(146, 'icing sugar', 1),
(147, ' cooksmeringue base', 1),
(148, 'strawberries', 1),
(149, 'toastedalmonds', 1),
(150, 'cooksprettypetals', 1),
(151, 'gold leaf', 1),
(152, 'lightsugar', 1),
(153, 'selfraising flour', 1),
(154, 'mixed spice', 1),
(155, 'sultanas', 1),
(156, 'currants', 1),
(157, 'choppedpitted dates', 1),
(158, 'mixed peel', 1),
(159, 'marzipan', 1),
(160, 'nomarmalade', 1),
(161, 'coated almonds', 1),
(162, 'darksoft sugar', 1),
(163, 'goldensugar', 1),
(164, 'sunflower oil', 1),
(165, 'plain flour', 1),
(166, 'ground cinnamon', 1),
(167, 'ground ginger', 1),
(168, 'carrots', 2),
(169, 'walnuts', 2),
(170, 'gelizabethcappuccino flutes', 1),
(171, 'cookscarrotdecorations oryourfromandfondant icing', 1),
(172, 'fullsoft cheese', 1),
(173, 'unsalted butter', 1),
(174, 'unsalted butter', 1),
(175, 'lightsoft sugar', 1),
(176, 'blacktailrangeegg', 1),
(177, 'vanillapaste', 1),
(178, 'plain flour', 1),
(179, 'cadburymilk bar', 1),
(180, 'strongbread flour', 1),
(181, 'fastdried yeast', 1),
(182, 'caster sugar', 1),
(183, 'finesalt', 1),
(184, 'whole milk', 1),
(185, 'egg', 1),
(186, 'vegetable oil', 1),
(187, 'essentialgrapes greenred', 1),
(188, 'amaretto liqueur', 1),
(189, 'goldensugar', 1),
(190, 'unsalted butter', 1),
(191, 'freewhite eggs', 1),
(192, 'essentialfreemilk', 1),
(193, 'essentialflour', 1),
(194, 'vanilla extract', 1),
(195, 'toastedalmonds', 1),
(196, 'icing sugar', 1),
(197, 'pumpkinbutternut squash', 1),
(198, 'olive oil', 1),
(199, 'unsalted butter', 1),
(200, 'ginger biscuits', 1),
(201, 'fullfatcheese', 1),
(202, 'eggs', 1),
(203, 'double cream', 1),
(204, 'vanilla extract', 1),
(205, 'nocaramel sauce', 1),
(206, 'buns', 1),
(207, 'whipping cream', 1),
(208, 'essentialfreesemimilk', 1),
(209, 'blacktailrangeeggs', 1),
(210, 'caster sugar', 1),
(211, 'packpastry', 1),
(212, 'butter', 1),
(213, 'essential raspberries', 1),
(214, 'cornflour', 1),
(215, 'goldensugar', 1),
(216, 'crme frachedouble cream', 1),
(217, 'doveswholemealbiscuits', 1),
(218, 'cocoa powder', 1),
(219, 'veganalternative', 1),
(220, 'veganchocolate', 1),
(221, 'ripe avocados', 1),
(222, ' tangerine', 1),
(223, 'pistachio kernels', 1),
(224, 'essentialbutter', 1),
(225, 'lightmuscovado sugar', 1),
(226, 'goldensugar', 1),
(227, 'vanillapaste', 1),
(228, 'essentialflour', 1),
(229, 'baking powder', 1),
(230, 'bicarbonatesoda', 1),
(231, 'granulated sugar', 1),
(232, 'cherries', 1),
(233, 'star anise', 1),
(234, 'cornflour', 1),
(235, 'unsaltedor ghee', 1),
(236, 'packpastry', 1),
(237, 'flaked almonds', 1),
(238, 'singleorice cream', 1),
(239, 'unsalted butter', 1),
(240, 'waitrosebrownsugar', 1),
(241, 'dark chocolate', 1),
(242, 'buttermilk', 1),
(243, 'selfraising flour', 1),
(244, 'packraspberries', 1),
(245, 'crme frachewhipped cream', 1)
;
INSERT INTO recipes_products VALUES 
(1, 1, 'g', 250),
(1, 2, 'g', 250),
(1, 3, 'piece', 4),
(1, 4, 'g', 250),
(1, 5, 'tsp', 1),
(1, 6, 'tsp', 0.5),
(1, 7, 'tbsp', 6),
(1, 8, 'piece', 6),
(1, 9, 'tsp', 0.5),
(1, 10, 'g', 365),
(2, 11, 'g', 200),
(2, 12, 'g', 70),
(2, 13, 'g', 200),
(2, 14, 'g', 150),
(2, 6, 'tsp', 0.5),
(2, 15, 'piece', 5),
(2, 16, 'piece', 1),
(2, 17, 'tbsp', 1),
(2, 18, 'g', 150),
(2, 19, 'g', 10),
(3, 20, 'g', 280),
(3, 21, 'g', 350),
(3, 22, 'piece', 2),
(3, 23, 'ml', 150),
(3, 24, 'g', 12),
(4, 25, 'g', 75),
(4, 26, 'g', 75),
(4, 27, 'g', 75),
(4, 28, 'g', 18),
(4, 29, 'g', 10),
(4, 30, 'g', 175),
(4, 31, 'piece', 1),
(4, 32, 'piece', 1),
(5, 33, 'piece', 3),
(5, 34, 'ml', 200),
(5, 35, 'g', 500),
(5, 36, 'tsp', 1),
(5, 37, 'g', 50),
(5, 38, 'g', 7),
(5, 3, 'piece', 4),
(5, 39, 'g', 100),
(5, 40, 'piece', 1),
(5, 41, 'piece', 1),
(6, 42, 'g', 200),
(6, 43, 'g', 100),
(6, 44, 'g', 200),
(6, 45, 'piece', 4),
(6, 46, 'g', 150),
(6, 47, 'tbsp', 0.5),
(6, 48, 'tbsp', 3),
(6, 49, 'ml', 300),
(6, 50, 'tbsp', 2),
(6, 51, 'tbsp', 2),
(7, 52, 'ml', 100),
(7, 53, 'piece', 6),
(7, 54, 'g', 100),
(7, 55, 'g', 150),
(7, 22, 'piece', 2),
(7, 56, 'tsp', 0.5),
(7, 57, 'g', 280),
(7, 58, 'g', 100),
(7, 59, 'tsp', 1),
(7, 5, 'tsp', 1),
(8, 60, 'ml', 170),
(8, 61, 'g', 250),
(8, 62, 'g', 7),
(8, 11, 'g', 200),
(8, 63, 'g', 500),
(8, 64, 'piece', 1),
(8, 65, 'piece', 3),
(8, 66, 'piece', 4),
(8, 16, 'piece', 1),
(8, 67, 'g', 200),
(8, 68, 'g', 250),
(9, 69, 'g', 150),
(9, 70, 'tsp', 1),
(9, 71, 'ml', 100),
(9, 72, 'g', 100),
(9, 73, 'g', 100),
(9, 74, 'piece', 2),
(9, 75, 'tbsp', 1),
(9, 76, 'g', 175),
(9, 77, 'ml', 75),
(10, 78, 'ml', 150),
(10, 79, 'g', 100),
(10, 80, 'piece', 3),
(10, 81, 'tbsp', 3),
(10, 82, 'g', 100),
(10, 14, 'g', 150),
(10, 83, 'g', 50),
(10, 84, 'tsp', 0.5),
(11, 85, 'g', 320),
(11, 86, 'g', 200),
(11, 87, 'piece', 3),
(11, 88, 'tbsp', 12),
(11, 89, 'g', 120),
(12, 90, 'ml', 100),
(12, 91, 'piece', 1),
(12, 54, 'g', 100),
(12, 92, 'ml', 125),
(12, 93, 'g', 75),
(12, 94, 'piece', 8),
(13, 95, 'g', 225),
(13, 96, 'g', 25),
(13, 97, 'g', 125),
(14, 97, 'g', 125),
(14, 98, 'piece', 1),
(14, 99, 'g', 200),
(14, 100, 'piece', 4),
(14, 54, 'g', 100),
(14, 101, 'g', 25),
(14, 102, 'g', 75),
(14, 103, 'piece', 1),
(15, 104, 'g', 400),
(15, 105, 'tbsp', 6),
(15, 106, 'tbsp', 2),
(15, 107, 'ml', 150),
(15, 108, 'g', 50),
(16, 109, 'g', 380),
(16, 110, 'g', 100),
(16, 111, 'piece', 6),
(16, 112, 'g', 20),
(16, 113, 'g', 20),
(16, 114, 'tbsp', 2),
(16, 115, 'piece', 1),
(17, 116, 'g', 500),
(17, 117, 'piece', 1),
(17, 118, 'piece', 1),
(17, 119, 'tbsp', 2),
(17, 120, 'tbsp', 4),
(17, 121, 'piece', 0.5),
(17, 122, 'piece', 1),
(17, 123, 'g', 2),
(17, 124, 'piece', 1),
(18, 125, 'g', 340),
(18, 126, 'g', 340),
(18, 127, 'piece', 6),
(18, 128, 'g', 60),
(18, 129, 'g', 310),
(18, 130, 'g', 30),
(18, 131, 'tsp', 1),
(19, 39, 'g', 100),
(19, 132, 'g', 266),
(19, 133, 'g', 2),
(19, 134, 'g', 520),
(19, 49, 'ml', 300),
(19, 135, 'g', 100),
(19, 136, 'g', 100),
(20, 137, 'g', 750),
(20, 138, 'g', 200),
(20, 139, 'g', 350),
(20, 140, 'piece', 4),
(20, 141, 'tbsp', 2),
(20, 16, 'piece', 1),
(20, 142, 'g', 150),
(21, 143, 'ml', 150),
(21, 144, 'pinch', 1),
(21, 145, 'piece', 10),
(21, 146, 'tbsp', 2),
(21, 147, 'piece', 1),
(21, 148, 'g', 150),
(21, 149, 'tbsp', 1),
(21, 150, 'tsp', 1),
(21, 151, 'piece', 1),
(22, 42, 'g', 200),
(22, 152, 'g', 200),
(22, 153, 'g', 150),
(22, 83, 'g', 50),
(22, 154, 'tsp', 2),
(22, 80, 'piece', 3),
(22, 155, 'g', 125),
(22, 156, 'g', 125),
(22, 157, 'g', 125),
(22, 158, 'g', 50),
(22, 159, 'g', 500),
(22, 160, 'tbsp', 1),
(22, 161, 'piece', 11),
(23, 162, 'g', 125),
(23, 163, 'g', 175),
(23, 164, 'ml', 300),
(23, 80, 'piece', 3),
(23, 165, 'g', 300),
(23, 70, 'tsp', 1),
(23, 5, 'tsp', 1),
(23, 166, 'tsp', 1),
(23, 167, 'tsp', 0.5),
(23, 168, 'g', 275),
(23, 169, 'g', 75),
(23, 170, 'g', 2),
(23, 171, 'piece', 1),
(23, 172, 'g', 100),
(23, 173, 'g', 30),
(23, 13, 'g', 200),
(23, 54, 'g', 100),
(23, 25, 'g', 75),
(24, 174, 'g', 150),
(24, 175, 'g', 100),
(24, 54, 'g', 100),
(24, 176, 'piece', 1),
(24, 177, 'tsp', 1),
(24, 178, 'g', 250),
(24, 70, 'tsp', 1),
(24, 6, 'tsp', 0.5),
(24, 179, 'g', 360),
(25, 180, 'g', 225),
(25, 181, 'g', 3),
(25, 182, 'tbsp', 1),
(25, 183, 'tsp', 0.5),
(25, 184, 'ml', 120),
(25, 185, 'piece', 1),
(25, 173, 'g', 30),
(25, 186, 'piece', 1),
(26, 187, 'g', 250),
(26, 188, 'tbsp', 2),
(26, 189, 'g', 80),
(26, 190, 'piece', 1),
(26, 191, 'piece', 3),
(26, 192, 'ml', 250),
(26, 193, 'g', 80),
(26, 194, 'tsp', 1),
(26, 195, 'tbsp', 2),
(26, 196, 'tbsp', 1),
(27, 197, 'g', 600),
(27, 198, 'tbsp', 1),
(27, 199, 'g', 130),
(27, 200, 'g', 400),
(27, 201, 'g', 650),
(27, 119, 'tbsp', 2),
(27, 54, 'g', 100),
(27, 175, 'g', 100),
(27, 202, 'piece', 4),
(27, 203, 'ml', 200),
(27, 204, 'tbsp', 1),
(27, 167, 'tsp', 0.5),
(27, 183, 'tsp', 0.5),
(27, 205, 'tbsp', 4),
(28, 206, 'piece', 3),
(28, 207, 'ml', 300),
(28, 177, 'tsp', 1),
(28, 208, 'ml', 300),
(28, 209, 'piece', 3),
(28, 210, 'tbsp', 1),
(29, 211, 'g', 500),
(29, 117, 'piece', 1),
(29, 212, 'g', 35),
(30, 213, 'g', 300),
(30, 214, 'tsp', 1),
(30, 215, 'tbsp', 3),
(30, 216, 'piece', 1),
(31, 217, 'g', 200),
(31, 218, 'tbsp', 2),
(31, 219, 'g', 80),
(31, 220, 'g', 200),
(31, 221, 'piece', 2),
(31, 222, 'piece', 1),
(31, 223, 'g', 25),
(32, 224, 'g', 140),
(32, 225, 'g', 115),
(32, 226, 'g', 100),
(32, 227, 'tsp', 1),
(32, 185, 'piece', 1),
(32, 228, 'g', 200),
(32, 229, 'piece', 1),
(32, 230, 'tsp', 0.5),
(32, 183, 'tsp', 0.5),
(33, 231, 'g', 130),
(33, 232, 'g', 300),
(33, 233, 'piece', 1),
(33, 234, 'tbsp', 1),
(33, 235, 'g', 60),
(33, 236, 'g', 270),
(33, 237, 'g', 100),
(33, 238, 'piece', 1),
(34, 239, 'g', 225),
(34, 240, 'g', 200),
(34, 80, 'piece', 3),
(34, 194, 'tsp', 1),
(34, 241, 'g', 70),
(34, 242, 'ml', 150),
(34, 243, 'g', 225),
(34, 230, 'tsp', 0.5),
(34, 83, 'g', 50),
(34, 6, 'tsp', 0.5),
(34, 244, 'g', 150),
(34, 245, 'piece', 1)
;
INSERT INTO tags VALUES 
(1, 'strawberries'),
(2, 'cardamom'),
(3, 'vegetarian'),
(4, 'cake'),
(5, 'blueberry'),
(6, 'picnic'),
(7, 'raspberries'),
(8, 'cheesecake'),
(9, 'dessert'),
(10, 'summer'),
(11, 'chocolate'),
(12, 'french'),
(13, 'bread'),
(14, 'easter'),
(15, 'pudding'),
(16, 'italian'),
(17, 'semolina'),
(18, 'ramadan'),
(19, 'lime'),
(20, 'baking'),
(21, 'fairtrade'),
(22, 'dates'),
(23, 'christmas'),
(24, 'meringue'),
(25, 'mincemeat'),
(26, 'vegan'),
(27, 'cherries'),
(28, 'cream'),
(29, 'pastry'),
(30, 'patisserie'),
(31, 'mint'),
(32, 'mediterranean'),
(33, 'blueberries'),
(34, 'pavlova'),
(35, 'saffron'),
(36, 'cookie'),
(37, 'leftovers'),
(38, 'grape'),
(39, 'grapes'),
(40, 'amaretto'),
(41, 'caramel'),
(42, 'ginger'),
(43, 'cinnamon'),
(44, 'buffet'),
(45, 'fruit'),
(46, 'foundation'),
(47, 'avocados'),
(48, 'tangerine'),
(49, 'snack')
;
INSERT INTO recipes_tags VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 3),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(4, 9),
(4, 3),
(4, 11),
(4, 12),
(5, 13),
(5, 14),
(5, 3),
(6, 15),
(6, 16),
(6, 3),
(6, 9),
(6, 4),
(7, 4),
(7, 3),
(7, 17),
(7, 18),
(8, 3),
(8, 19),
(9, 20),
(9, 9),
(9, 21),
(9, 4),
(10, 4),
(10, 22),
(10, 23),
(11, 3),
(11, 4),
(11, 24),
(11, 25),
(11, 23),
(12, 3),
(12, 20),
(12, 9),
(12, 26),
(12, 24),
(12, 14),
(13, 27),
(13, 3),
(13, 9),
(14, 27),
(14, 3),
(14, 9),
(15, 20),
(15, 28),
(15, 1),
(15, 29),
(15, 30),
(15, 9),
(15, 10),
(16, 29),
(16, 20),
(16, 9),
(16, 10),
(17, 29),
(17, 3),
(17, 20),
(17, 9),
(17, 5),
(18, 4),
(18, 20),
(19, 20),
(19, 15),
(19, 8),
(19, 14),
(19, 31),
(19, 9),
(20, 3),
(20, 20),
(20, 32),
(20, 9),
(20, 8),
(20, 33),
(21, 34),
(21, 20),
(21, 2),
(21, 18),
(21, 35),
(22, 14),
(22, 4),
(22, 20),
(23, 14),
(23, 20),
(23, 15),
(23, 9),
(24, 3),
(24, 20),
(24, 36),
(25, 4),
(25, 23),
(25, 37),
(25, 20),
(26, 3),
(26, 38),
(26, 39),
(26, 9),
(26, 40),
(27, 41),
(27, 42),
(27, 3),
(27, 20),
(27, 8),
(28, 43),
(28, 15),
(28, 9),
(29, 3),
(29, 9),
(29, 44),
(30, 29),
(30, 3),
(30, 20),
(30, 45),
(30, 12),
(31, 46),
(31, 3),
(31, 47),
(31, 48),
(31, 9),
(32, 49),
(32, 9),
(33, 29),
(33, 3),
(33, 20),
(33, 10),
(34, 4),
(34, 20),
(34, 11)
;
