drop table if exists forms  cascade;
drop table if exists products cascade;
drop table if exists tags  cascade;
drop table if exists users  cascade;
drop table if exists utensils  cascade;
drop table if exists recipes  cascade;
drop table if exists recipes_products cascade;
drop table if exists recipes_tags  cascade;
drop table if exists recipes_utensils  cascade;
drop table if exists users_liked cascade;

drop type if exists difficulty_enum;
drop type if exists shape_enum;
drop type if exists category_enum;
drop type if exists unit_enum;