require 'spec_helper'

describe PlacesController do
	describe "GET index" do
		it "lists all places excluding the fakes" do
			get :index
			assigns(:places).should eq Place.where(temp: false)
		end
	end

	describe "POST create" do
		before(:all) do
			file = File.new(Rails.root + 'public/system/test.png')
			@pic  = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
			@place_params = { name: "foo", description: "bar",  picture: @pic  }
		end
		context "authorized" do
			before(:each) do
		        ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
		    end

			it "should attach a pic to the Place" do
		        
				xhr :post, :create, place: @place_params
	   		    controller.params[:place][:picture].should_not be_nil

				assigns(:fake_place_id).should be_true
				assigns(:fake_place_id).should eq session[:fake_place_id]
				Place.find(session[:fake_place_id]).pictures.create(pic: @pic).should be_instance_of(Picture)
			end

			it "should create a Place" do
				post :create, place: @place_params
				response.should redirect_to(action: "index", notice: 'Place was successfully created.')
			end
	    end

	    context "not_authorized" do
	    	it "should_redirect_to_back" do
				post :create, place: @place_params
	    		response.should redirect_to(request.env["HTTP_REFERER"] || "/")
	    	end
	    end
	end

	describe "PUT update" do
		before(:each) do
			@place = FactoryGirl.create(:place)
		end

		context "authorized" do
			before(:each) do
			        ApplicationController.any_instance.stub(:current_user).and_return(true)
			end
				
			context "privileged user" do
				it "should_update_a_place and redirect to places" do
			        ApplicationController.any_instance.stub(:check_user_identity).and_return(true)

					put :update, id: @place.id, place: {}

			        response.should redirect_to(places_path)
			    end
			end
			context "not_priveleged user" do
				it "should_not_update_a_place" do
					put :update, id: @place.id, place: {}

					response.should redirect_to(request.env["HTTP_REFERER"] || "/")
				end
			end
		end
		
		context "not authorized" do
			it "should_not_update_a_place" do
				put :update, id: @place.id, place: {}
				response.should redirect_to(request.env["HTTP_REFERER"] || "/")
			end
		end
	end


	

		# it "should DELETE a photo from a place" do
		#   	xhr :delete,  :destroy, id: 42
		#   	# Record.exists?(record)
		#   	# expect { Place.find(42) }.to raise_error 
	 #    end
end