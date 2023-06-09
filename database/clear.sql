drop table if exists forms cascade;
drop table if exists products cascade;
drop table if exists tags cascade;
drop table if exists users cascade;
drop table if exists utensils cascade;
drop table if exists recipes cascade;
drop table if exists recipes_products cascade;
drop table if exists recipes_tags cascade;
drop table if exists recipes_utensils cascade;
drop table if exists users_liked cascade;
drop table if exists categories cascade;
drop table if exists restrictions cascade;
drop table if exists archival_recipes cascade;
drop table if exists products_restrictions cascade;
drop table if exists notes cascade;
drop table if exists comments cascade;
drop table if exists users_liked_comments cascade;
drop table if exists sources cascade;

drop view if exists recipe_list;
drop view if exists recipe_info;
drop view if exists top_recipes;
drop view if exists recent_recipes;

drop function if exists add_ingredient;
drop function if exists add_all_ingredients;
drop function if exists update_recipe;
drop function if exists add_all_tags;
drop function if exists last_modified;
drop function if exists shopping_list;
drop function if exists users_notes;
drop function if exists tags_from_recipe;
drop function if exists products_from_recpie;
drop function if exists restrictions_from_recipe;
drop function if exists basic_from_recipe;
drop function if exists comments_from_recipe;
drop function if exists comments_from_comment;
drop function if exists recipes_with_products;
drop function if exists comment_trigger;
drop function if exists add_like;
drop function if exists del_like;
drop function if exists is_liked;
drop function if exists login;







drop type if exists difficulty_enum;
drop type if exists shape_enum;
drop type if exists unit_enum;