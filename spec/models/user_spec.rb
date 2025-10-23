require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    context "必須項目が揃っているとき" do
      it "有効である" do
        expect(build(:user)).to be_valid
      end
    end

    context "emailがないとき" do
      it "無効である" do
        user = build(:user, email: nil)
        expect(user).to be_invalid
        expect(user.errors[:email]).to be_present
      end
    end

    context "nameがないとき" do
      it "無効である" do
        user = build(:user, name: "")
        expect(user).to be_invalid
        expect(user.errors[:name]).to be_present
      end
    end
  end
end
