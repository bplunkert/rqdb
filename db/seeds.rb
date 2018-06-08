# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Announcement.create(text: 'Hello!!!!! second announcement!!')
Announcement.create(text: 'Hello!!!!!!! First announcement!!!')

User.create!([
  {email: 'admin@admin.admin', password: 'password'}
])

99.times do
  Quote.create(approved: true, text: 'This quote has been approved. It is possibly awesome!')
  Quote.create(approved: false, text: 'This quote has been submitted, but not yet reviewed for approval/deletion.')
  Quote.create(approved: true, flagged: true, text: 'This quote has been approved, but it has been flagged for admin review.')
end

