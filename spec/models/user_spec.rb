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

    context "nameは任意である" do
      it "空文字でも有効である" do
        expect(build(:user, name: "")).to be_valid
      end

      it "nilでも有効である" do
        expect(build(:user, name: nil)).to be_valid
      end
    end
  end
end
