require File.dirname(__FILE__) + '/../spec_helper'
 
 def random_email
  (0...4).map{65.+(rand(26)).chr}.join + "@foo.com";
 end


describe "registration" do
	context "success" do
		it "should register with the free email adress" do
			visit "/registration"
			fill_in "Email", with: random_email
			fill_in "Name", with: random_email
			fill_in "Password", with: "123456"
			fill_in "Password confirmation", with: "123456"

		    page.should_not have_content "You have been successfully registered!"
	   end
	end  
end