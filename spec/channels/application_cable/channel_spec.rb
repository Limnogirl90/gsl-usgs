require "rails_helper"

RSpec.describe ApplicationCable::Channel, :type => :channel do
  it { expect(described_class).to be < ActionCable::Channel::Base }
end
