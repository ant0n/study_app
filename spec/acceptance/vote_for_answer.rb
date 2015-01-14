require_relative 'acceptance_helper'

feature 'User vote for answer', %q{
  In order to be able to up/down answer rating
  As an authenticated user
  I want to be able to vote for answer
} do

  given(:user)      { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer)   { create(:answer, question: question, author: user) }


  scenario 'Vote and change vote for answer', js: true do
    sign_in(user)
    visit question_path(question)

    within "#answer_#{answer.id}" do
      expect(page).to have_link 'Vote Up'
      expect(page).to have_link 'Vote Down'
      expect(page).to have_selector('span.votes_count')

      click_on 'Vote Up'

      within 'span.votes_count' do
        expect(page).to have_content '1'
      end

      expect(find('.votes')).to have_selector 'a[title="Vote Up"].disabled'

      click_on 'Vote Down'

      within 'span.votes_count' do
        expect(page).to have_content '-1'
      end

      expect(find('.votes')).to have_selector 'a[title="Vote Down"].disabled'
    end

  end

end