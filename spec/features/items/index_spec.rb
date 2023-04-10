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

  #User Story 3
  describe "/items" do
    it "displays a list of all items including name, price, market, and count of buyers" do
      visit '/items'
      within("##{@item_1.id}") do
        expect(page).to have_content("Name: Item 1, Price: 5, Market: Market 1 Count of buyers: 3")
      end
      within("##{@item_2.id}") do
        expect(page).to have_content("Name: Item 2, Price: 10, Market: Market 1 Count of buyers: 2")
      end
      within("##{@item_3.id}") do
        expect(page).to have_content("Name: Item 3, Price: 25, Market: Market 2 Count of buyers: 1")
      end
    end
  end
end