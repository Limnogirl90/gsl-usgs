require "rails_helper"

RSpec.describe ApplicationCable::Connection, :type => :connection do
  it { expect(described_class).to be < ActionCable::Connection::Base }
end
