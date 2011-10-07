class TagsController < ApplicationController
  def append
    @tag_name = params[:name]
  end

  def remove
    @tag_name = params[:name]
  end
end
