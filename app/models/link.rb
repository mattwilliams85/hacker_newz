class Link < ActiveRecord::Base
  before_save :title_check
  before_create :zero_vote
  validates :url, :presence => true,
                  :uniqueness => true
  validate :valid_url

  has_many :comments, :as => :commentable

  def self.sort_by_date
    self.all.sort {|a,b| b.ratio <=> a.ratio }
  end

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

  def ratio
    if !self.upvotes?
      0.5 / (Time.now - self.created_at)/100
    else
      self.upvotes / ((Time.now - self.created_at)/10000)
    end
  end


end

