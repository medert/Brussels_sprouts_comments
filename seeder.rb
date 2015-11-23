require 'pg'

system 'psql brussels_sprouts_recipes < schema.sql'


TITLES = ["Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts",
  "Brussels Sprouts with Goat Cheese"]

COMMENTS = [
  ["Brussels Sprouts with Goat Cheese", "Fantastic"],
  ["Brussels Sprouts with Goat Cheese", "Supercalifragilisticexpialidocious"]]


def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end

def add_recipes(list)
  list.each do |title|
    db_connection do |conn|
      conn.exec("INSERT INTO recipes (dish_name) VALUES ($1)", [title])
    end
  end
end

def add_comments(list)
  list.each do |comment|
    db_connection do |conn|
      conn.exec("INSERT INTO comments (name, comment) VALUES ($1, $2);", [comment[0], comment[1]])
    end
  end
end

#counting

def count_recipes
  db_connection do |conn|
    conn.exec_params("SELECT COUNT(dish_name) FROM recipes")
  end
end

def count_comments
  db_connection do |conn|
    conn.exec_params("SELECT COUNT(comments) FROM comments")
  end
end

def count_recipes_with_comments
  db_connection do |conn|
    conn.exec_params("SELECT * FROM recipes, comments WHERE name = 'Brussels Sprouts with Goat Cheese'")
  end
end

add_recipes(TITLES)
add_comments(COMMENTS)

puts count_recipes
puts count_comments
puts count_recipes_with_comments
