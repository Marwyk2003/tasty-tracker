INSERT INTO forms VALUES
	(DEFAULT, 'rectangular', 21, 28),
	(DEFAULT, 'rectangular', 15, 30),
	(DEFAULT, 'round', 17, 17),
	(DEFAULT, 'round with chimney', 5, 30);

INSERT INTO products VALUES
	(DEFAULT, 'milk', 'dairy and eggs'),
	(DEFAULT, 'egg', 'dairy and eggs'),
	(DEFAULT, 'whipped cream', 'dairy and eggs'),
	(DEFAULT, 'yogurt', 'dairy and eggs'),
	(DEFAULT, 'apple', 'fruits'),
	(DEFAULT, 'carrot', 'vegetables'),
	(DEFAULT, 'walnut', 'dried fruits and nuts'),
	(DEFAULT, 'flour', 'cereal products'),
	(DEFAULT, 'chocolate', 'sweet'),
	(DEFAULT, 'sugar', 'sweet'),
	(DEFAULT, 'vanilla pudding', 'sweet'),
	(DEFAULT, 'powder sugar', 'sweet'),
	(DEFAULT, 'salt', 'spices'),
	(DEFAULT, 'yeast', 'spices'),
	(DEFAULT, 'vanillin sugar', 'spices'),
	(DEFAULT, 'cacoa', 'spices'),
	(DEFAULT, 'baking soda', 'spices'),
	(DEFAULT, 'baking powder', 'spices'),
	(DEFAULT, 'cinnamon', 'spices'),
	(DEFAULT, 'butter', 'butters and oils');

INSERT INTO tags VALUES
	(DEFAULT, 'vegan'),
	(DEFAULT, 'chocolate'),
	(DEFAULT, 'pancakes'),
	(DEFAULT, 'sugar free');

INSERT INTO users VALUES
	(DEFAULT, 'user_1', '$2b$12$FJ1JrYAMsQ/w4BzCqqufSu3AnKibHW05q9sGPgRAFbaXZUC4F6Y1S', '2017-08-19 21:38:54'),
	(DEFAULT, 'user_2', '$2b$12$7TsX7p91tHTjCJnUACl.VOnTI5EGBFPXO2mmLWpUd7fX12ovBfpNy', '2020-11-07 11:26:35'),
	(DEFAULT, 'user_3', '$2b$12$VtIFUN2MUzMJ0CzHbT31EuUljiH5OlV8l0JAhTqy/NG8Lq.wYqlti', '2012-05-13 18:46:46'),
	(DEFAULT, 'user_4', '$2b$12$hlb4VdfiQOEA.A73gle60e4sbx8eD371pV1s1doGHJ42aLF6PjkGa', '2010-01-29 05:01:02'),
	(DEFAULT, 'user_5', '$2b$12$XzNL/75StcPWcnSi0OOp.e3w0Ir0akH6Ag2xclt9gnm6v6sNIzMie', '2018-04-09 06:11:38'),
	(DEFAULT, 'user_6', '$2b$12$9rKCMY/POmSxn4BXDq5f7e2YotoXL9LRbpa/gSGIAdQiiA64kxub6', '2011-10-28 22:48:54'),
	(DEFAULT, 'user_7', '$2b$12$MfCZfxr5pbkGHY..fOYVUe4jHDG.rUZwtZPJQQIus5jJAcXgsJCz6', '2019-01-01 14:06:06'),
	(DEFAULT, 'user_8', '$2b$12$6rjZDPZqP5ddI46j8V2HKuSkXY41mQ2pSNVzeOjpy6fgncytj7qHa', '2011-12-25 05:45:51'),
	(DEFAULT, 'user_9', '$2b$12$3a9I9zd6TGkGQyriNnKllubuFu971pOTAlCOebbRJdvzCUw2rh7C.', '2016-10-11 23:00:10'),
	(DEFAULT, 'user_10', '$2b$12$jSvjoaTE5P10UUaICixOrul6qk.pQl4dIe.wBD80RJV2dQr1cVXcu', '2017-05-31 00:20:01'),
	(DEFAULT, 'user_11', '$2b$12$ePBCw.7NHrH.Hnyahgs9GOyeI10g2GZRWWM01Y9yJprJS7ugSuerq', '2013-11-07 09:51:16'),
	(DEFAULT, 'user_12', '$2b$12$p1fsa7nZvm2bBExZSNsGbu.pepWN/FG9bSCQCgl0G6mQqXZoPuy0a', '2012-06-23 19:12:18'),
	(DEFAULT, 'user_13', '$2b$12$whBrqzcdn9Ep77AOA7AmoueE583FjTekGbvbKsmGYSfNbAMln/.Ma', '2018-03-17 21:39:42'),
	(DEFAULT, 'user_14', '$2b$12$etzWXh.RgzJgZZ96ryNcgebm0OA5ikcw6ivscBbpjEWU5eAZYO2CW', '2020-03-17 02:19:56'),
	(DEFAULT, 'user_15', '$2b$12$tnK.nqgO9j/GSm5L0kUXGecrbiFIDDdnACWtADZ.PorJL0Vr0toVS', '2017-06-30 11:34:26');

INSERT INTO utensils VALUES
	(DEFAULT, 'spatula'),
	(DEFAULT, 'whisk'),
	(DEFAULT, 'mixer');

INSERT INTO recipes VALUES
	(DEFAULT, 'monkey bread', 15, 4, '2018-06-22 23:48:23', 'hard', '2 hours', 'Yeast dough: pour flour into a bowl and mix with instant yeast. Add sugar and salt and mix with a spoon.
		Slowly pour in warm milk while stirring the ingredients with a spoon. Add melted and cooled (or soft) butter and knead the dough until the ingredients are combined. Then knead for about 15 minutes (by hand or with a mixer) until the dough is smooth and elastic. Cover with a cloth and set aside in a warm place to rise for about 1 and 1/2 hours.
		In the meantime, melt butter to coat and stir in cane sugar and cinnamon.
		Grease a muffin tin with butter and sprinkle it with a tablespoon of the sugar and cinnamon mixture.
		Put the risen dough on a pastry board and flatten it into a small rectangle (about 20 x 15 cm) and cut it with a knife into a grid, obtaining approx. 30 squares of dough.
		Dip them in melted butter, coat them in a mixture of sugar and cinnamon and place them in the prepared muffin tin.
		Set aside in a warm place to rise for about 45 minutes.
		Place in an oven preheated to 180 degrees C and bake for 30 minutes.
		Turn out onto a platter and drizzle with lemon icing.', 172),
	(DEFAULT, 'apple pie with pudding', 9, 1, '2017-12-20 19:06:26', 'medium', '90 minutes', 'Knead the crumbly dough: sprinkle flour on a pastry board, add diced cold butter, baking powder and powdered sugar. Chop the ingredients with a knife into a fine crumble. You can also use a planetary mixer.
		Add the egg and combine the ingredients into a uniform dough. Cut the dough in half, wrap the halves separately in plastic wrap and put them in the freezer.
		Cook the pudding according to the instructions on the package, adding the indicated amount of sugar (remember to boil the milk as well as the finished pudding).
		Peel the apples, cut them into quarters and cut out the seed nests. Cut them into slices and put them in the pot. Add cinnamon and cook covered for about 10 minutes until apples are tender, stir occasionally in the meantime.
		Preheat the oven to 180 degrees C. Prepare an undersized baking pan measuring about 21 x 28 cm.
		Take one of the dough halves out of the freezer and grate it on a coarse grater on the bottom of the mold. Level it out and gently pat it down.
		Spread the apples on the bottom, followed by the pudding. Take the other part of the dough out of the freezer and grate directly onto the pudding.
		Place in the oven and bake for about 45 minutes until golden brown. Sprinkle with powdered sugar.', 23),
	(DEFAULT, 'chocolate cakes', 3, 2, '2017-12-29 16:06:26', 'easy', '45 minutes', 'Remove the yogurt and eggs from the refrigerator beforehand to warm (or gently heat in a bath or microwave).
		Mix the yogurt with the eggs, vanilla sugar and sugar using a whisk or fork.
		Sift flour with cocoa, baking powder and baking soda into another bowl, mix thoroughly.
		Add the wet ingredients to the dry ingredients and mix with a whisk or fork gently and mix briefly until the ingredients are combined into a homogeneous mass (you can''t mix for too long, just until the ingredients are first combined).
		Heat up a frying pan (such as a large pancake pan or any other pan with a non-stick coating), grease it with butter or oil and put 2 flat tablespoons of batter per pancake keeping spaces (maximum 4 pancakes at a time).
		Fry on not too high heat until they rise and are nicely browned (about 3 minutes). Flip the pancakes over to the other side and fry until browned, about 3 minutes over moderate heat.
		Sprinkle with powdered sugar, serve with, for example, maple syrup or jam, fruit.', 910);


INSERT INTO recipes_products VALUES
	(1, 8, 'g', 500),
	(1, 14, 'g', 14),
	(1, 10, 'g', 50),
	(1, 13, 'tsp', 1),
	(1, 1, 'ml', 300),
	(1, 20, 'g', 59),
	(2, 8, 'g', 350),
	(2, 20, 'g', 200),
	(2, 18, 'tsp', 1.5),
	(2, 12, 'g', 70),
	(2, 2, 'piece', 1),
	(2, 11, 'piece', 1),
	(2, 1, 'l', 0.5),
	(2, 5, 'g', 1200),
	(2, 19, 'tsp', 1),
	(3, 4, 'g', 250),
	(3, 2, 'piece', 2),
	(3, 15, 'piece', 1),
	(3, 16, 'tsp', 1),
	(3, 11, 'g', 170),
	(3, 17, 'tsp', 1.5),
	(3, 18, 'tsp', 0.5),
	(3, 20, 'g', 15);

INSERT INTO recipes_tags VALUES
	(1, 3),
	(2, 2),
	(3, 4);

INSERT INTO recipes_utensils VALUES
	(1, 3),
	(3, 2);

INSERT INTO users_liked VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 7),
	(1, 9),
	(1, 10),
	(1, 11),
	(2, 12),
	(2, 1),
	(2, 13),
	(2, 15),
	(3, 1);
