require 'spec_helper'
require 'capybara/dsl'
# require 'rails_helper'
feature "User deletes a recording" do
    scenario "They click a checkbox and click delete" do
        visit "/"
        
        checkbox = find("input[type=checkbox]", match: :first)
        first_checkbox_value = checkbox.value
        checkbox.set(true)
        click_button("Delete")
        sleep 4
        expect(page).to have_no_selector("input[type=checkbox][value='#{first_checkbox_value}']")
    end
end