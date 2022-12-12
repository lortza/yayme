# frozen_string_literal: true

puts '**** Running seeds...'

user = User.find_or_create_by!(email: 'admin@email.com') do |user|
  user.name = 'admin'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.admin = true
  user.save
end

# Post Types
SeedsHelper.count_records_for(PostType) do
  names = [
    'TIL',
    'Merit',
    'Praise',
    'Gratitude'
  ]
  names.each do |name|
    user.post_types.find_or_create_by!(name: name)
  end
end

# Categories
SeedsHelper.count_records_for(Category) do
  names = [
    'Citizenship',
    'Leadership',
    'Skills & Competencies'
  ]
  names.each do |name|
    user.categories.find_or_create_by!(name: name)
  end
end

# Posts
SeedsHelper.count_records_for(Post) do
  posts = []
  10.times do
    publish_date = Faker::Date.between(from: 30.days.ago, to: Date.current)
    post = {
      post_type_id: user.post_types.sample.id,
      bookmarked: [true, false, false].sample,
      date: publish_date,
      url: ['', '', '', Faker::Internet.url].sample,
      given_by: ['', Faker::Name.first_name].sample,
      description: [Faker::Lorem.paragraph(sentence_count: 10), Faker::Markdown.block_code].sample,
      created_at: publish_date,
      updated_at: publish_date
    }
    posts << post
  end

  Post.insert_all(posts)
end

sample_size = Post.count * 0.7
Post.all.sample(sample_size).each do |post|
  category = Category.all.sample
  post.categories << category
end
