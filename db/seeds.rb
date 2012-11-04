# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#ActiveRecord::Base.subclasses.each(&:delete_all)


Place.delete_all
Picture.delete_all
User.delete_all

u = User.create(name: "Foobar", email: "foo@bar.com", password: 123456, password_confirmation: 123456, avatar: ActionDispatch::Http::UploadedFile.new(tempfile: File.new(Rails.root.join('public', 'images', 'default_avatar.jpg')), filename: "default_avatar.jpg"))
places = []
places <<  Place.create( user_id: u.id, name: "Lorem ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.") <<
           Place.create(user_id: u.id,  name: "Lorem ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.") <<
           Place.create(user_id: u.id,  name: "Lorem ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")

places.each do |p|
	p_id = nil
	Random.rand(5).times do
	  p.comments.create(user_id: u.id, parent_id: p_id, text: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. ").id
	  p_id = p.comments[Random.rand(p.comments.length)]
	end
end 


dir = Rails.root.join('public', 'images', 'picture_samples')
pic_dir  = Dir.entries(dir)


places.each do |p| 
	rand_pic = pic_dir[Random.rand(pic_dir.length)]
	puts "#Selected random pic "
	p.pictures.create( pic: ActionDispatch::Http::UploadedFile.new(tempfile: File.new("#{dir}/#{rand_pic}"), filename: "default_avatar.jpg"))
end
