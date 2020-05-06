require 'spec_helper'
require 'capybara/dsl'
# require 'rails_helper'
feature "User creates a meeting" do
    scenario "They enter the form and click Create" do
        visit "/"
        
        fill_in "name", with: 'Bill'
        click_button "Create"
        sleep 4
        expect(page).to have_text("Welcome")
    end
end