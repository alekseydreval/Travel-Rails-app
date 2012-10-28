require 'spec_helper'

describe "Login/logout" do
	before(:each) do
		DatabaseCleaner.clean
		@user = FactoryGirl.create(:user)
	end

	describe "Log_in process with redirecting to back" do

		context "valid data" do 

			it "signs in" do

				DatabaseCleaner.clean
				@user = FactoryGirl.create(:user)

				visit '/'
				fill_in 'email',    with: @user.email
				fill_in 'password', with: @user.password
				click_on "Sign in"

				current_path.should == "/"
				page.should have_content "Logged in!"
			end	
		end

		context "invalid data" do
			it "not signs in" do
				visit '/'
				fill_in 'email',    with: "dfdf"
				fill_in 'password', with: "sdsd"
				click_on "Sign in"

				current_path.should == "/"
				page.should_not have_content "Logged in!"
			end
		end
	end

  describe "Log_out process" do
    it "logs out" do

    	ApplicationController.any_instance.stub(:current_user).and_return(@user)
    	visit '/'
    	click_on "Sign out"

    	page.should have_content "Logged out!"
    end  
  end
end