require 'rails_helper'

RSpec.describe Item, type: :model do
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
    it { should belong_to :supermarket }
    it { should have_many :customers}
    it { should have_many(:customers).through(:customer_items)}
  end

  describe '#instance methods' do
    describe '#total_buyers' do
      it 'returns the count of people who purchased this item' do
        expect(@item_1.total_buyers).to eq(3)
        expect(@item_2.total_buyers).to eq(2)
        expect(@item_3.total_buyers).to eq(1)
      end
    end

    describe '#get_market_name' do
      it 'returns the name of the market the item belongs to' do
        expect(@item_1.get_market_name).to eq('Market 1')
        expect(@item_3.get_market_name).to eq('Market 2')
      end
    end
  end
end
