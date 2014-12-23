require_relative 'acceptance_helper'

feature 'Question editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like to be able to edit my answer
} do

  given(:user)       { create(:user) }
  given!(:question)  { create(:question, author: user) }
  given(:user2)      { create(:user) }
  given!(:question2) { create(:question, author: user2) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end


  describe 'Authenticated user' do
    before { sign_in user }

    describe 'as an author' do
      before { visit question_path(question) }

      scenario 'sees link to Edit' do
        within ".question" do
          expect(page).to have_link 'Edit'
        end
      end

      scenario 'try to edit his answer', js: true do
        click_on 'Edit'
        within ".question" do
          fill_in 'question_body', with: 'edited question'
          click_on 'Update Question'

          expect(page).to_not have_content question.body
          expect(page).to have_content 'edited question'
          expect(page).to_not have_selector 'textarea'
        end
      end
    end

    describe 'as not an author' do
      before { visit question_path(question2) }

      scenario "try to edit question" do
        within ".question" do
          expect(page).to_not have_link 'Edit'
        end
      end
    end
  end

end