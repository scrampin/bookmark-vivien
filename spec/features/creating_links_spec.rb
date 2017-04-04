feature 'creating link' do


  scenario 'submits a new link via form' do
    visit('/links/new')
    fill_in('new_link', with: 'http://google.com')
    fill_in('title', with: 'Google')
    click_button("Submit link")
    expect(page).to have_content("Google")
  end
end
