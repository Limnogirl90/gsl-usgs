require "rails_helper"

RSpec.describe ApplicationRecord, :type => :model do

  it { expect(described_class).to be < ActiveRecord::Base }

  it "is an abstract class" do
    expect {
      described_class.new
    }.to raise_error NotImplementedError
  end
end
