require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'category作成' do
    context 'パラメータに問題がない場合' do
      it 'categoryが作成できること' do
        category = Category.new(name: 'SAMPLE', category_type: 'language')
        expect(category).to be_valid
      end
    end
    
    context 'nameがない場合' do
      it 'categoryが作成できないこと' do
        category = Category.new(category_type: 'language')
        expect(category).to_not be_valid
      end
    end

    context 'category_typeがない場合' do
      it 'categoryが作成できないこと' do
        category = Category.new(name: 'SAMPLE')
        expect(category).to_not be_valid
      end
    end
  end
end
