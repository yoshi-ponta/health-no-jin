require "rails_helper"

RSpec.describe Cheer, type: :model do
  let(:from_user) { User.create!(email: "from@example.com", password: "password1234") }
  let(:to_user)   { User.create!(email: "to@example.com",   password: "password1234") }
  let(:group)     { Group.create!(name: "テストグループ", owner: from_user) }

  def jst_today
    Time.use_zone("Asia/Tokyo") { Time.zone.today }
  end

  it "cheered_on が自動でJST日付になる" do
    cheer = described_class.create!(group:, from_user:, to_user:)
    expect(cheer.cheered_on).to eq(Time.zone.today)
  end

  it "重複応援を許可しない" do
    described_class.create!(group:, from_user:, to_user:)
    dup = described_class.new(group:, from_user:, to_user:, cheered_on: Time.zone.today)
    expect(dup).not_to be_valid
  end

  it "作成時に Notification を1件作る" do
    expect {
      described_class.create!(group:, from_user:, to_user:)
    }.to change(Notification, :count).by(1)
  end
end
