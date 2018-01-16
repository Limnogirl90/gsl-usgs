require 'rails_helper'

RSpec.describe Dataset, type: :model do
  fixtures :datasets

  describe "#url_to_scan" do
    it "parses against URI lib for each example in the fixture" do
      any_fixtures_found = nil
      Dataset.all.each do |da|
        u = URI.parse(da.url_to_scan)
        expect(u.class).to eq URI::HTTPS
        any_fixtures_found = true
      end

      expect(any_fixtures_found.present?).to be true
    end
  end
end
