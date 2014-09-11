class CommentsController < ApplicationController
  def new
    @comment = Comment.find(params[:link_id])
    @new_comment = Comment.new
  end

  def create
    if params[:link_id]
      @link = Link.find(params[:link_id])
      @comment = Comment.create(:body => params[:comment][:body],
                                       :commentable_id => params[:link_id],
                                       :commentable_type => "link")
      if @comment.save
        redirect_to link_path(@link)
      else
        redirect_to link_path(@link)
      end
    else
      @comment = Comment.find(params[:comment_id])
      if Comment.find_children(@comment.id).last
        @comment = Comment.find_children(@comment.id).last
      end

      @link = @comment.find_parent
      @new_comment = Comment.create(:body => params[:comment][:body],
                                                :commentable_id => @comment.id,
                                                :commentable_type => "comment")
      if @new_comment.save
        Comment.clear
        redirect_to link_path(@link)
      else
        redirect_to link_path(@link)
        breakkk
      end
    end
  end

  def show

  end

  def update
    @comment = Comment.find(params[:id])
    @link = Link.find(params[:commentable_id])
    @comment.update(:upvotes => params[:upvotes])
    redirect_to link_path(@link)
  end

  def create2

  end
end

