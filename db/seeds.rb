# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(name: 'Admin',
            email: 'admin@ad.com',
            admin: true,
            password: 'password',
            password_confirmation: 'password',
            born_on: '2005-05-25',
            status: 'Ukrainian GO GO GO!!!',
            about: 'Love football' )

User.create(name: 'Sasha',
            email: 'sasha@ad.com',
            admin: true,
            password: '123456',
            password_confirmation: '123456',
            born_on: '2005-05-25',
            status: 'Ukrainian GO GO GO!!!',
            about: 'Love football' )

User.create(name: 'Petja',
            email: 'Petja@ad.com',
            admin: true,
            password: '123456',
            password_confirmation: '123456',
            born_on: '2005-05-25',
            status: 'Ukrainian GO GO GO!!!',
            about: 'Love football' )
