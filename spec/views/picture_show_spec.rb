require File.dirname(__FILE__) + '/../spec_helper'

describe "pictures/show" do
	it "rensers _comment partial" do
		pic = FactoryGirl.create(:picture)
		view.stub(:get_commentable).and_return(pic)
		view.stub(:current_user).and_return(true)

		assign(:pic, pic)

		render
	end
  
end