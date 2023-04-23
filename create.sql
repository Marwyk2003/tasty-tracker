
CREATE TYPE unit_enum AS ENUM('ml','l', 'tsp ', 'tbsp ', 'pinch ', 'g ');
CREATE TYPE shape_enum AS ENUM( 'rectangular ', 'round ', 'round with chimney ');
CREATE TYPE category_enum AS ENUM( 'diary ', 'fruits ', 'vegetables ', 'dried fruits ', 'nuts ', 'cereal products ', 'sweets ', 'eggs ', 'olives, butters and oils ');
CREATE TYPE difficulty_enum AS ENUM( 'very easy ', 'easy ', 'medium ', 'hard ', 'very hard ');

CREATE  TABLE  forms (
	id_form              integer  NOT NULL,
	shape                shape_enum  NOT NULL,
	dimension1          integer  NOT NULL,
	dimension2          integer  NOT NULL,
	CONSTRAINT pk_forms PRIMARY KEY (id_form)
);

ALTER TABLE  forms ADD CONSTRAINT positive_dimensions CHECK (dimension1 > 0 AND dimension2 > 0);

CREATE  TABLE  products (
	id_product           integer  NOT NULL,
	name                 varchar(30)  NOT NULL,
	category             category_enum  NOT NULL,
	CONSTRAINT pk_products PRIMARY KEY (id_product)
);

CREATE  TABLE  tags (
	id_tag               integer  NOT NULL,
	tag                  varchar(20)  NOT NULL,
	CONSTRAINT pk_tags PRIMARY KEY (id_tag)
);

CREATE  TABLE  users (
	id_user              integer  NOT NULL,
	username             varchar(20),
	hash_password        bigint  NOT NULL,
	created_at           timestamp,
	CONSTRAINT pk_users PRIMARY KEY (id_user)
);

CREATE  TABLE  utensils (
	id_utensil           integer  NOT NULL,
	name                 varchar(30)  NOT NULL,
	CONSTRAINT pk_utensils PRIMARY KEY (id_utensil)
);

CREATE  TABLE  recipes (
	id_recipe            integer  NOT NULL,
	id_user              integer  NOT NULL,
	id_form              integer,
	added_at             timestamp DEFAULT CURRENT_DATE NOT NULL,
	difficulty           difficulty_enum,
	preparation_time     interval,
	body                 json  NOT NULL,
	visit_counter        integer,
	CONSTRAINT pk_recipes PRIMARY KEY (id_recipe)
);

ALTER TABLE  recipes ADD CONSTRAINT positive_time CHECK (preparation_time > '0 seconds');

CREATE  TABLE  recipes_products (
	id_recipe            integer  NOT NULL,
	id_product           integer  NOT NULL,
	unit                 unit_enum  NOT NULL,
	amount               integer  NOT NULL  
);

ALTER TABLE  recipes_products ADD CONSTRAINT positive_amount CHECK (amount > 0);

CREATE  TABLE  recipes_tags (
	id_recipe            integer  NOT NULL,
	id_tag               integer  NOT NULL  
);

CREATE  TABLE  recipes_utensils (
	id_recipe integer  NOT NULL,
	id_utensil integer  NOT NULL,
	CONSTRAINT pk_recipes_utensils PRIMARY KEY (id_recipe, id_utensil)
);

CREATE  TABLE  users_liked (
	id_recipe            integer  NOT NULL,
	id_user              integer  NOT NULL  
);

ALTER TABLE  recipes ADD CONSTRAINT fk_recipes_user FOREIGN KEY (id_user) REFERENCES  users(id_user) ON DELETE SET NULL;

ALTER TABLE  recipes ADD CONSTRAINT fk_recipes_form FOREIGN KEY (id_form) REFERENCES  forms(id_form);

ALTER TABLE  recipes_products ADD CONSTRAINT fk_recipes_products_recipe FOREIGN KEY (id_recipe) REFERENCES  recipes(id_recipe);

ALTER TABLE  recipes_products ADD CONSTRAINT fk_recipes_products_product FOREIGN KEY (id_product) REFERENCES  products(id_product);

ALTER TABLE  recipes_tags ADD CONSTRAINT fk_recipes_tags_tag FOREIGN KEY (id_tag) REFERENCES  tags(id_tag);

ALTER TABLE  recipes_tags ADD CONSTRAINT fk_recipes_tags_recipe FOREIGN KEY (id_recipe) REFERENCES  recipes(id_recipe);

ALTER TABLE  recipes_utensils ADD CONSTRAINT fk_recipes_utensils_recipe FOREIGN KEY (id_recipe) REFERENCES  recipes(id_recipe) ON DELETE CASCADE;

ALTER TABLE  recipes_utensils ADD CONSTRAINT fk_recipes_utensils_utensil FOREIGN KEY (id_utensil) REFERENCES  utensils(id_utensil);

ALTER TABLE  users_liked ADD CONSTRAINT fk_users_liked_user FOREIGN KEY (id_user) REFERENCES  users(id_user) ON DELETE CASCADE;

ALTER TABLE  users_liked ADD CONSTRAINT fk_users_liked_recipe FOREIGN KEY (id_recipe) REFERENCES  recipes(id_recipe) ON DELETE CASCADE;

