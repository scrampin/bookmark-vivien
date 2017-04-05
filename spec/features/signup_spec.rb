feature 'User is able to sign up' do

  scenario 'User enters email and password and submits' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(current_path).to eq '/links'
    expect(page).to have_content("Welcome to bookmark-manager")
    expect(User.first.email).to eq('a@gmail.com')
  end
end
