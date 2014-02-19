require 'spec_helper'

feature "Creating a Receipe" do
  scenario "Accessing the interface", js: true do
    visit receipes_path

    click_link "Add a Receipe"
    page.within(".receipe-add:not(.hidden)") do
      page.within('h3') do
        expect(page).to have_content "Add a Receipe"
      end
    end
  end
end