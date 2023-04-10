require 'rails_helper'

RSpec.describe '/customers' do
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
    @ci_2 = CustomerItem.create!(customer:@c_2 ,item: @item_2)
    @ci_3 = CustomerItem.create!(customer:@c_3 ,item: @item_3)
    @ci_4 = CustomerItem.create!(customer:@c_1 ,item: @item_2)
  end

  #User Story 1
  describe "/customers/:id" do
    it "displays the customer's name and items" do
      visit "/customers/#{@c_1.id}"
      expect(page).to have_content("Customer Show Page")

      within("##{@c_1.id}") do
        expect(page).to have_content("Name: Adam")
        expect(page).to have_content("Items: Item 1, 5, Market 1")
        expect(page).to have_content("Item 2, 10, Market 1")

        expect(page).to_not have_content("Name: Bob")
        expect(page).to_not have_content("Name: Charlie")
      end
    end
    it "displays item name, price and name of supermarket it belongs to" do
      visit "/customers/#{@c_1.id}"

      within("##{@c_1.id}") do
        expect(page).to have_content("Item 1, 5, Market 1")
        expect(page).to have_content("Item 2, 10, Market 1")

        expect(page).to_not have_content("Item 3")
        expect(page).to_not have_content("Item 4")
        expect(page).to_not have_content("Market 2")
      end
    end
  end

  #User Story 2
  describe "/customers/:id" do
    it "displays a form to add item to customer" do
      visit "/customers/#{@c_1.id}"
      within("#add_item_form") do
        expect(page).to have_content("Add an Item to #{@c_1.name}")
        expect(page).to have_field(:item_Id)
        expect(page).to have_button('Submit')
      end
    end

    it "filling and submitting form redirects me to same page where item is added" do
      visit "/customers/#{@c_2.id}"

      within("##{@c_2.id}") do
        expect(page).to have_content("Item 2, 10, Market 1")

        expect(page).to_not have_content("Item 1")
        expect(page).to_not have_content("Item 3")
      end

      within("#add_item_form") do
        fill_in :item_Id, with: @item_1.id
        click_on 'Submit'
      end

      expect(page).to have_current_path("/customers/#{@c_2.id}")

      within("##{@c_2.id}") do
        expect(page).to have_content("Item 2, 10, Market 1")
        expect(page).to have_content("Item 1, 5, Market 1")

        expect(page).to_not have_content("Item 3")
      end
    end
  end
end