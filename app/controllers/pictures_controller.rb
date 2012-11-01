class PicturesController < ApplicationController

before_filter :redirect_to_login,  only: ['edit', 'update', 'destroy']
before_filter(only: ['edit', 'update']) {|c| c.check_user_identity(Picture)}  

  def create
  	Place.find(params[:id]).pictures.create(params[:picture])
  end

  def destroy
    logger.info { current_user.id }

    respond_to do |format|
      format.json do
          Picture.find(params[:id]).destroy
          render :json => { sdf: 'ok' }
	    end
    end
  end

  def show
    @picture = Picture.find(params[:id])
    @pic = @picture.pic.url
    @comments = @picture.comments.where(ancestry: nil)
    respond_to do |f|
      f.html {}
    end
  end
end
