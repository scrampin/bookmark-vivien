feature 'creating link' do


  # scenario 'submits a new link via form' do
  #   visit('/links/new')
  #   fill_in('new_link', with: 'http://google.com')
  #   fill_in('title', with: 'Google')
  #   click_button("Submit link")
  #   expect(page).to have_content("Google")
  # end

  scenario 'adding links with tags' do
    visit('/links/new')
    fill_in('new_link', with: 'http://teaandkittens.com')
    fill_in('title', with: 'Tea and Kittens')
    fill_in('tags', with: 'kitty')
    click_button("Submit link")
    link = Link.first
    expect(link.tags.map(&:name)).to include('kitty')
  end

end
