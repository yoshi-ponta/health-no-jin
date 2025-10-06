require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context '必須項目が揃っているとき' do
      it '有効である' do end
    end

    context 'emailがないとき' do
      it '無効である' do end
    end
  end
end