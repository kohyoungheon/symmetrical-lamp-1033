require 'rails_helper'

RSpec.describe '/items' do
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

  #extension 1
  describe "/supermarkets/:id" do
    it "displays market name and a list of unique shopper names" do
      visit "/supermarkets/#{@market_1.id}"
      expect(page).to have_content("Market 1")
      expect(page).to have_content("List of unique shoppers: Adam, Bob, and Charlie")
  

      visit "/supermarkets/#{@market_2.id}"
      expect(page).to have_content("List of unique shoppers: Charlie")
      expect(page).to_not have_content("Adam")
      expect(page).to_not have_content("Bob")
    end
  end
end