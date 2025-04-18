# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all

User.create [
  { name: 'Yihe', password: '123456', email: 'chen61@mcmaster.ca'},
  { name: "Alice", password: "password123", email: "alice@example.com" },
  { name: "Test", password: "123456", email: "test@example.com" },
  { name: "Jack", password: "p@ssw0rd!", email: "jack@example.com" }
]
