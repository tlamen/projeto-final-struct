# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create([{name: 'hamburgueres'}, {name: 'acompanhamentos'}, {name: 'sobremesas'}, {name: 'bebidas'}])
meals = Meal.create({name: 'Hamburguer de siri', category_id: 1, price: 10.00, description: "Melhor prato do restaurante"})
user = User.create({email: "jao@jao" ,name: "jao" , password: "jaojao"  })
admin = User.create({email: "adm@adm", name: "adeministrador", password: "123456", is_admin: true})