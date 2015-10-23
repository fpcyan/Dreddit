# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Sub.destroy_all
Post.destroy_all

users = []
subs = []
posts = []
postsubs = []

5.times do |i|
  users << User.create!(email: "User#{i}", password: "password#{i}", username: "User#{i}")
end

5.times do |i|
  subs << Sub.create!(title: "Sub Dreddit #{i}", moderator_id: users[i].id)
end
5.times do |i|
  post = Post.new(title: "Ship #{i}", author_id: users[i].id, url: "")
  post.subs = [subs[i]]
  post.save!
  posts << post
end

5.times do |i|
  post = Post.new(title: "X-post: cats. I should buy #{i} boat(s)", author_id: users.first.id)
  post.subs = [subs[i], subs[(i + 1) % (subs.length - 1)]]
  post.save!
  posts << post
end
