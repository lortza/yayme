puts '**** Running seeds...'

puts 'Destroying AllTheThings!TM'
User.destroy_all
Category.destroy_all
AccomplishmentType.destroy_all
Accomplishment.destroy_all

user = User.create!(
        email: 'admin@email.com',
        password: 'password',
        password_confirmation: 'password',
        admin: true
      )
puts "Created #{User.count} Users"

# Accomplishment Types
merit = AccomplishmentType.create!(user_id: user.id, name: 'Merit')
praise = AccomplishmentType.create!(user_id: user.id, name: 'Praise')
gratitude = AccomplishmentType.create!(user_id: user.id, name: 'Gratitude')
puts "Created #{AccomplishmentType.count} AccomplishmentTypes"


# Categories
citizenship = Category.create!(user_id: user.id, name: 'Citizenship')
skills = Category.create!(user_id: user.id, name: 'Skills & Competencies')
leadership = Category.create!(user_id: user.id, name: 'Leadership')
puts "Created #{Category.count} Categories"


# Accomplishments
Accomplishment.create!([
  { accomplishment_type_id: merit.id, bookmarked: true, date: '2019-03-25', url: '', given_by: 'Nick', description: "Nick says people now talk about refinement and refinement is better. people are interested in it and care about it. and these are people who don't like meetings. -- that is coming from my influence" },
  { accomplishment_type_id: merit.id, bookmarked: true, date: '2019-05-15', url: '', given_by: '', description: "I feel so happy to have been able to connect Glenn with Schneems in-person at RubyConf. This will get Glenn a step closer towards being a Rails Contributor. I'm also so energized by having been able to help Ragav be able engage in 'hallway track' conversations and connections at RubyConf. These kinds of things make me feel happy because they're important moments that can launch a person into personal growth and I am so grateful to be able to do that." },
  { accomplishment_type_id: merit.id, bookmarked: false, date: '2019-06-21', url: '', given_by: '', description: "I just spent some time writing up my PDP and progress on my goals. Since it is November, i've already done a ton of work and it made me realize that even though it doesn't feel like it, i'm kicking ass." },
  { accomplishment_type_id: praise.id, bookmarked: false, date: '2019-09-07', url: '', given_by: 'Dave', description: "I was reflecting on something I read last night and just wanted to say thank you. You always bring up a point i had not considered. I can't thank you enough for that" },
])
puts "Created #{Accomplishment.count} Accomplishments"
