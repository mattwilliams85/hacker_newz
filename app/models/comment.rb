class Comment < ActiveRecord::Base
  validates :body, :presence => true
  before_create :zero_vote

  belongs_to :commentable, :polymorphic => true

  def self.sort_by_date
    self.all.sort {|a,b| b.ratio <=> a.ratio }
  end

  def ratio
    if !self.upvotes?
      0.5 / (Time.now - self.created_at)/100
    else
      self.upvotes / ((Time.now - self.created_at)/10000)
    end
  end

  def zero_vote
    self.upvotes = 0
  end

  def find_parent
    if !Comment.find_by(:id => self.commentable_id)
      Link.find(self.commentable_id)
    else
      Comment.find_by(:id => self.commentable_id).find_parent
    end
  end

def self.clear
  @comments = []
end


def self.find_children(id)
  if !@comments
    @comments = []
  end
    if Comment.find_by(:commentable_id => id)
      comment = Comment.find_by(:commentable_id => id)
      @comments << Comment.find_by(:commentable_id => id)
      Comment.find_children(comment.id)
    end
  @comments
end

end
