class Link < ActiveRecord::Base
  validates :url, :presence => true,
                  :uniqueness => true

  def title_check
    if self.title
      self.title = self.url
    end
  end
end
