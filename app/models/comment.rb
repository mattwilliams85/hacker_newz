class Comment < ActiveRecord::Base
  validates :body, :presence => true
  before_create :zero_vote

  belongs_to :link

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
end
