class LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    @link.title_check
    if @link.save
      redirect_to links_path
    else
      render "new"
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update

  end

end
