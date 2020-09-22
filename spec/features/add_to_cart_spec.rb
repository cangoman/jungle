require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity:10,
        price: 64.99,
        image: open_asset('apparel1.jpg')
      )
    end
  end


  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    expect(page).to have_css 'article.product', count: 10
    
    page.first('article.product').find_button('Add').click
    
    expect(page).to have_text "My Cart (1)"
    save_screenshot

  end

end