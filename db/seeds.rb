
user = User.create(name: 'John')
recipe1 = Recipe.create(name: 'Pizza', preparation_time: 60, cooking_time: 50, description: 'This is a pizza recipe', public: true, user: user)
recipe2 = Recipe.create(name: 'Pasta', preparation_time:30, cooking_time: 40, description: 'This is a pasta recipe', public: false, user: user)
food1 = Food.create(name: 'apple', measurement_unit: 'grams', price: 1.9, quantity: 5, user: user)
food2 = Food.create(name: 'orange', measurement_unit: 'grams', price: 5.0, quantity: 2, user: user)
food3 = Food.create(name: 'avocado', measurement_unit: 'grams', price: 9.99, quantity: 1, user: user)
