require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user_with_places) }

  it "creates assocs User.places, User.pictures, User.comments" do
  	user.pictures.count.should eq 5
  	user.places.count.should eq 5
  	user.comments.count.should eq 5
  end
end