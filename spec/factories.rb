require 'factory_girl'

FactoryGirl.define do
  
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    name "Konata"
    password '123456'
    password_confirmation '123456'
    # picture
    
    factory :user_with_pictures do
      after(:create){|u| FactoryGirl.create(:picture, user: u)}
    end
      


    factory :user_with_places do
    	after(:create) do |user|
    		FactoryGirl.create_list(:place, 5, user: user)
    		FactoryGirl.create_list(:picture, 5, user: user)
    		FactoryGirl.create_list(:comment, 5, user: user)
    	end
    end

  end

  factory :place do
  	name "Lorem ipsum"
  	description "abc"
  	user
    after(:create){|p| FactoryGirl.create(:picture, place: p)}
  end

  factory :comment_place, class: "Comment" do
    association :commentable, factory: :place
    user
  end

  factory :picture do
  	user
  	place
  end

  factory :comment do
  	user
  	text "Lorem ipsum"
  end


end