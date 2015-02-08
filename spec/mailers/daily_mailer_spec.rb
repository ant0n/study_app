require "rails_helper"

RSpec.describe DailyMailer, :type => :mailer do
  describe "digest" do
    let(:user) { create :user }
    let(:questions) { create_list :question, 3 }
    let(:mail) { DailyMailer.digest(user, questions) }

    it "renders the headers" do
      expect(mail.subject).to eq("Daily digest of questions")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("There is a list of new questions")
    end
  end

end
