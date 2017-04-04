feature 'creating link' do

  after do
    Link.destroy
  end

  scenario 'submits a new link via form' do
    visit('/links')
    fill_in('new_link', with: 'http://google.com')
    fill_in('title', with: 'Google')
    click_button("Submit link")
    expect(page).to have_content("Google")
  end
end
