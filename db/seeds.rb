# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT ADMIN LOGIN'
admin = Admin.create! :email => 'admin@test.com', :password => 'secret', :password_confirmation => 'secret'
puts 'New user created: ' << admin.email