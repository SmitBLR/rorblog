class LinksController < ApplicationController
  load_and_authorize_resource

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to root_path
    else
      render action: "new"
    end
  end


  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to :back
  end
end
