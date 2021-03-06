require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to help for community
  As an authenticated user
  I want to be able to create answer
} do
  given(:user)      { create(:user) }
  given!(:question)  { create(:question)  }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'creates answer', js: true do
      click_on 'Add answer'
      fill_in  'answer_body', with: 'answer description'

      click_on 'Create Answer'

      expect(current_path).to eq question_path(question)
      #expect(page).to have_content 'Answer successfully created'
      expect(page).to have_content 'answer description'
    end

    scenario 'try to create invalid answer', js: true do
      click_on 'Add answer'
      click_on 'Create Answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Non-authenticated user tries to create answer', js: true do
    sign_in(nil)

    visit question_path(question)
    click_on 'Add answer'

    fill_in  'answer_body', with: 'answer description'
    click_on 'Create Answer'

    #expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end