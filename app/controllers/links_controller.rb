class LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.find(params[:id])
    @comment = Comment.new(:link_id => :id)
  end

  def create
    @link = Link.new(params[:link])
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
    if params[:upvotes]
      @link = Link.find(params[:id])
      @link.update(:upvotes => params[:upvotes])
      redirect_to root_path
    else
      @link = Link.find(params[:id])
      if @link.update(params[:link])
        redirect_to root_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to root_path
  end

end
