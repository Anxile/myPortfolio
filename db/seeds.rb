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
  { name: 'Yihe', password: '123456', mail: 'chen61@mcmaster.ca'},
  { name: "Alice", password: "password123", mail: "alice@example.com" },
  { name: "Bob", password: "securePass456", mail: "bob@example.com" },
  { name: "Charlie", password: "qwerty789", mail: "charlie@example.com" },
  { name: "David", password: "password000", mail: "david@example.com" },
  { name: "Eve", password: "hunter2", mail: "eve@example.com" },
  { name: "Frank", password: "letmein123", mail: "frank@example.com" },
  { name: "Grace", password: "superSecret", mail: "grace@example.com" },
  { name: "Hank", password: "password321", mail: "hank@example.com" },
  { name: "Ivy", password: "abcdefg123", mail: "ivy@example.com" },
  { name: "Jack", password: "p@ssw0rd!", mail: "jack@example.com" }
]
