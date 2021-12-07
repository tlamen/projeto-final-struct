# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create([{name: 'hamburgueres'}, {name: 'acompanhamentos'}, {name: 'bebidas'}, {name: 'sobremesas'}])
meals = Meal.create([
    {name: 'Hambúrguer de siri', category_id: 1, price: 17.00, description: "Pão, 180g de carne de siri, queijo, alga e tomate"},
    {name:"Hambúrguer de Siri Monstruoso", category_id: 1, price: 28.00, description: "Pão, 2x180g de carne de siri, queijo, ovas fritas, alga e tomate"},
    {name:"Hambúrguer de Siri com Geléia", category_id: 1, price: 20.50, description: "Pão, 180g de carne de siri, queijo, alga, tomate e geléia de água-viva monstruosa"},
    {name:"Mini hambúrguer de siri", category_id: 1, price: 13.00, description: "Pão, 90g de carne de siri, queijo, alga e tomate"},
    {name:"Siri supremo triplo", category_id: 1, price: 35.50, description: "Pão, 3x180g de carne de siri, queijo, ovas fritas, alga e tomate"},
    {name:"Hambúrguer de Siri de Luxo", category_id: 1, price: 90.00, description: "Pão australiano, 270g de carne de siri, caviar, limão, alga e tomate"},

    {name: 'Batata frita', category_id: 2, price: 7.50, description: "50 batatas fritas"},
    {name: 'Pedaços de coral', category_id: 2, price: 7.50, description: "25 pedaços de coral"},
    {name: 'Anéis de algas', category_id: 2, price: 7.50, description: "25 anéis de algas"},

    {name: 'Água sem sal', category_id: 3, price: 6.50, description: "Jarra de 500ml de água sem sal"},
    {name: 'Refrigerante em lata', category_id: 3, price: 6.50, description: "Lata de 310ml de: coca-cola (normal ou zero) e fanta (laranja, uva ou guaraná) "},

    {name: 'Sirishake de morango', category_id: 4, price: 15.50, description: "Milkshake 400ml de chocolate"},
    {name: 'Sirishake de chocolate', category_id: 4, price: 15.50, description: "Milkshake 400ml de morango"}
    ])
meals.each do |meal| 
    meal.picture.attach(io: File.open("./imgs/meal/#{(meal.name)}.jpg"), filename: "#{(meal.name)}.jpg")
end
user = User.create({email: "jao@jao" ,name: "jao" , password: "jaojao"  })
admin = User.create({email: "adm@adm", name: "adeministrador", password: "123456", is_admin: true})