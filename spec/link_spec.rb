require 'rails_helper'

describe Link do
  it { should validate_presence_of :url }
  it { should validate_uniqueness_of :url }
  it { should have_many :comments }

  describe 'valid_url' do
    it 'will prevent invalid url characters from being entered' do
      test_link = Link.new(:url => "<>BLAH")
      test_link.valid_url
      expect(test_link.errors.any?).to be(true)
    end
  end

  describe 'title_check' do
    it 'will change the title to the url if no title is entered' do
      test_link = Link.new(:url => "pepsi.com", :title => "")
      test_link.title_check
      expect(test_link.title).to eq test_link.url
    end
  end
end

