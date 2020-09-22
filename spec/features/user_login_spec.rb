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


    @user = User.create!(
      first_name: 'test',
      last_name: 'test_too',
      email: 'test@test.com',
      password: '12345678',
      password_confirmation: '12345678'
    )
  end

  scenario "They follow login path" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    page.find_link('Login').click
    
    
    expect(page).to have_text "Email"
    
    page.find_field('Email address').set('test@test.com')
    page.find_field('Password').set('12345678')

    page.find_button('Submit').click

    expect(page).to have_text "Logout"
  
    save_screenshot



  end

end