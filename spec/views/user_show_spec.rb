require File.dirname(__FILE__) + '/../spec_helper'

describe "users/show" do
	it "renders user's gallery" do
		assign(:user, FactoryGirl.create(:user_with_pictures))

		render
        view.should render_template("shared/_gallery")
	end

	it "renders user's displayed name/place/pictures" do
	end

  
end