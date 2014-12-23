require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like to be able to edit my answer
} do

  given(:user)      { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer)   { create(:answer, question: question, author: user) }
  given(:user2)     { create(:user) }
  given!(:answer2)  { create(:answer, question: question, author: user2) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end


  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit' do
      within "#answer_#{answer.id}" do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his answer', js: true do
      within "#answer_#{answer.id}" do
        click_on 'Edit'

        fill_in 'answer_body', with: 'edited answer'
        click_on 'Update Answer'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario "try to edit other user's answer" do
      within "#answer_#{answer2.id}" do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end