require "rails_helper"

RSpec.describe ApplicationMailer, :type => :mailer do
  mailer = Class.new(described_class) do
    def a_sample_email
      # We need a body to not render views
      mail(body: '')
    end
  end

  it { expect(described_class).to be < ActionMailer::Base }

  it 'has the default "from" address' do
    email = mailer.a_sample_email
    expect(email.from).to eq ['from@example.com']
  end

  # describe "notify" do
  #   let(:mail) { Notifications.signup }

  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Signup")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end

  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end
  # end
end
