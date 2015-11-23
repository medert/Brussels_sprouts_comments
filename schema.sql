
DROP TABLE IF EXISTS recipes CASCADE;

DROP TABLE IF EXISTS comments;

CREATE TABLE recipes(
  id SERIAL PRIMARY KEY,
  dish_name VARCHAR(100)
);


CREATE TABLE comments(
  C_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  comment VARCHAR(200),
  id integer REFERENCES recipes(id)
);
