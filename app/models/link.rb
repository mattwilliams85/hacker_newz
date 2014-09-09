class Link < ActiveRecord::Base
  validates :url, :presence => true,
                  :uniqueness => true
  validate :valid_url


  def valid_url
    legal_char = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/.match(url)
    if !legal_char
      errors.add(:valid_url, "URL is not valid.")
    end
  end

  def title_check
    if !self.title
      self.title = self.url
    end

    self.save
  end
end

