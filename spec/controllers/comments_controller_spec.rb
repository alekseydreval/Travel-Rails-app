require 'spec_helper'

describe CommentsController do

  describe "POST 'create'" do
    before(:each) do
      ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
      @pic = Picture.create
      @place = FactoryGirl.create(:place)
      @p_comment = Comment.create
    end

    after(:each) do
      assigns(:comment).should_not be_nil
      assigns(:comment).should_not be_new_record
    end
      
    it "attaches a comment(nested) to a Picture" do
      post 'create', picture_id: @pic.id, comment: { text: "foo_bar", commentable_id: @pic.id, commentable_type: 'Picture', parent_id: @p_comment }

      assigns(:comment).commentable.should be_an_instance_of(Picture)
    end

    it "attaches a comment to a Place" do
      post 'create', place_id: @place.id, comment: { text: "foo_bar", commentable_id: @place.id, commentable_type: 'Place', parent_id: @p_comment }

      assigns(:comment).commentable.should be_an_instance_of(Place)
    end
  end
end
  # describe "DELETE 'destroy'" do
    
  #   before(:each) do
  #     @pic = Picture.create
  #     @p_comment = Comment.create
  #     # Comment.stub(:find).and_return(@p_comment)
  #   end

  #   it "returns http success" do
  #     xhr :delete, :destroy, id: @p_comment.id
  #     Comment.should_not be_exists(Comment.find(@p_comment.id).id)
  #   end
  # end
# end
