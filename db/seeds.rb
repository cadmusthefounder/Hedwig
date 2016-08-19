# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

5.times do
  name = Faker::Name.name
  email = Faker::Internet.email(name)
  account_kit_id = Faker::Number.number(10)
  credit = Faker::Number.between(1, 100)
  User.create!(name: name, email: email, account_kit_id: account_kit_id, credit: credit)
end

users = User.all

15.times do
  user = users.sample

  from_address = Faker::Address.street_address
  to_address = Faker::Address.street_address
  from_postal_code = Faker::Number.number(6)
  to_postal_code = Faker::Number.number(6)
  price = SecureRandom.random_number * 50
  user.tasks.create!(from_address: from_address, from_postal_code: from_postal_code, to_address: to_address, to_postal_code: to_postal_code, price: price)
end

yihang = User.create!(name: "Yihang", email: "hoyihang5@gmail.com", account_kit_id: "lol", credit: 1000, admin: true)
charlton = User.create!(name: "Cadmus", email: "cadmusthefounder@gmail.com", account_kit_id: "bla", credit: 1000, admin: true)

task = Task.last
task.interested_users = [yihang, charlton]

task = Task.last(2).first
task.interested_users = [yihang]
task.assigned_user = yihang
task.status = :assigned
task.save!

task = Task.last(3).first
task.interested_users = [charlton]
task.assigned_user = charlton
task.status = :assigned
task.save!

task = Task.last(4).first
task.interested_users = [yihang]
task.assigned_user = yihang
task.status = :in_progress
task.save!

task = Task.last(5).first
task.interested_users = [charlton]
task.assigned_user = charlton
task.status = :in_progress
task.save!
