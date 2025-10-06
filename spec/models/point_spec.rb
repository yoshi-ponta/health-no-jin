require 'rails_helper'

RSpec.describe Point, type: :model do
  describe 'バリデーション' do
    context '最小入力が揃っているとき' do
      it '有効である' do end
    end

    context 'valueが無いとき' do
      it '無効である' do end
    end
  end
end