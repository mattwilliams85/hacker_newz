require 'rails_helper'

describe Link do
  it { should validate_presence_of :url }
  it { should validate_uniqueness_of :url }

  describe 'valid_url' do
    it 'will prevent invalid url characters from being entered' do
      test_link = Link.new(:url => "<>BLAH")
      test_link.valid_url
      expect(test_link.errors.any?).to be(true)
    end
  end
end

