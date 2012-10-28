require File.dirname(__FILE__) + '/../spec_helper'

describe "places/show" do
	before(:each) do
		@pl = FactoryGirl.create(:comment_place).commentable
		view.stub(:current_user).and_return(@pl.user)
		view.stub(:get_commentable).and_return(@pl)
		# place = FactoryGirl.create(:place)
	end

	after(:all) do
		view.stub(:current_user).and_return(false)
	end
		
	it "renders _comment partial" do
		assign(:place, @pl)

		render
		view.should render_template("shared/_comment_form")
        view.should render_template("shared/_comment")
	end  

	it "renders _gallery partial" do
		assign(:place, @pl)

		render
        view.should render_template("shared/_gallery")
	end

	it "just tests" do
		person = double("person")
		person.should_receive(:test).and_return(42)
		person.test.should == 42
	end

	# it "shows edit button when current_user is the owner" do
	# 	assign(:place, @pl)

	# 	render 
	# 	rendered.should contain('Edit')
	# end


	# it "doesn't show edit button when current_user isn't the owner" do
	# 	assign(:place, @pl)
	# 	view.stub(:current_user).and_return(false)

	# 	render 
	# 	rendered.should_not contain('Edit')
	# end


end