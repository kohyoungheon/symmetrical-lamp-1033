require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  before(:each) do
    @market_1 = Supermarket.create!(name:'Market 1', location: 'Denver')
    @market_2 = Supermarket.create!(name:'Market 2', location: 'Boulder')
    @item_1 = @market_1.items.create!(name:'Item 1',price: 5)
    @item_2 = @market_1.items.create!(name:'Item 2',price: 10)
    @item_3 = @market_2.items.create!(name:'Item 3',price: 25)
    @c_1 = Customer.create!(name:'Adam')
    @c_2 = Customer.create!(name:'Bob')
    @c_3 = Customer.create!(name:'Charlie')
    @ci_1 = CustomerItem.create!(customer:@c_1 ,item: @item_1)
    @ci_2 = CustomerItem.create!(customer:@c_2 ,item: @item_1)
    @ci_3 = CustomerItem.create!(customer:@c_3 ,item: @item_1)
    @ci_4 = CustomerItem.create!(customer:@c_2 ,item: @item_2)
    @ci_5 = CustomerItem.create!(customer:@c_3 ,item: @item_2)
    @ci_5 = CustomerItem.create!(customer:@c_3 ,item: @item_3)
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  #extension
  describe 'instance methods' do
    describe '#unique_shoppers' do
      it "returns a list of all unique customers at market" do
        expect(@market_1.unique_shoppers).to eq('Adam, Bob, and Charlie')
        expect(@market_2.unique_shoppers).to eq('Charlie')
      end
    end
  end
end