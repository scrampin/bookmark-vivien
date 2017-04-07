feature 'User is able to sign up' do

  scenario 'User enters email and password and submits' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(current_path).to eq '/links'
    expect(page).to have_content("Welcome")
    expect(User.first.email).to eq('a@gmail.com')
  end

  scenario 'user adds mismatching passwords in confirmation' do
    visit ('user/new')
    fill_in('email', with: 'a@gmail.com')
    fill_in('password', with: '1234')
    fill_in('password_confirmation', with: 'kittens')
    expect {click_button("Submit")}.to change(User, :count).by(0)
    expect(page).to have_content("Your passwords did not match")
    expect(find_field('email').value).to eq('a@gmail.com')
  end

end
