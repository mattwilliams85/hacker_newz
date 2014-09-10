class CommentsController < ApplicationController
  def create
    @link = Link.find(params[:link_id])
    @comment = Comment.create(:body => params[:comment][:body],
                                     :link_id => params[:link_id])
    if @comment.save
      redirect_to link_path(@link)
    else
      redirect_to link_path(@link)
    end
  end

  def show

  end

  def update
    @comment = Comment.find(params[:id])
    @link = Link.find(params[:link_id])
    @comment.update(:upvotes => params[:upvotes])
    redirect_to link_path(@link)
  end
end
