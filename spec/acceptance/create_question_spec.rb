require_relative 'acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask question
} do
  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path

    click_on 'Create question'
    fill_in 'Title', with: 'Some question'
    fill_in 'Body', with: 'question description'

    click_on 'Create'

    expect(page).to have_content 'Question was successfully created'
    expect(page).to have_content 'question description'
  end

  scenario 'Non-authenticated user tries to create question' do
    sign_in(nil)

    visit questions_path
    click_on 'Create question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end