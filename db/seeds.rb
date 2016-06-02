# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

counter = 100000

100.times do |n|
  from_address = "ang mo kio ave #{n}"
  from_postal_code = "#{counter = counter+1}"
  to_address = "changi block #{n}"
  to_postal_code = "#{counter = counter+1}"
  price = 12.99
  Task.create!(from_address: from_address,
               from_postal_code: from_postal_code,
               to_address: to_address,
               to_postal_code: to_postal_code,
               price: price)
end
