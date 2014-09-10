class Link < ActiveRecord::Base
  before_save :title_check
  before_create :zero_vote
  validates :url, :presence => true,
                  :uniqueness => true
  validate :valid_url

  has_many :comments, :dependent => :destroy

  scope :recent, -> { order(:created_at).reverse_order }
  scope :upvote_order, -> { order(:upvotes) }

  def valid_url
    legal_char = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/.match(url)
    if !legal_char
      errors.add(:valid_url, "URL is not valid.")
    end
  end

  def title_check
    if self.title == ""
      self.title = self.url
    end
  end

  def zero_vote
    self.upvotes = 0
  end
end

