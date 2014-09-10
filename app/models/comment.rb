class Comment < ActiveRecord::Base
  validates :body, :presence => true
  before_create :zero_vote

  belongs_to :link

  scope :recent, -> { order(:created_at).reverse_order }
  scope :upvote_order, -> { order(:upvotes) }

  def zero_vote
    self.upvotes = 0
  end
end
