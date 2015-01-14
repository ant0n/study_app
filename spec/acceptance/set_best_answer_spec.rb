require_relative 'acceptance_helper'

feature 'Author set best answer', %q{
  In order to be able to show users best answer
  As an author
  I want to be able to set it
} do

  given(:user)      { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer)   { create(:answer, question: question, author: user) }


  describe 'The best answer was not set' do

    scenario 'Author of question set best answer', js: true do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_selector('.best')

      within "#answer_#{answer.id}" do
        click_on 'Best answer!'
      end

      expect(page).to have_selector("#answer_#{answer.id}.best")
    end
  end

  describe 'The best answer was set' do
    given!(:answer2)  { create(:best_answer, question: question, author: user) }

    scenario 'Author of question change best answer', js: true do
      sign_in(user)
      visit question_path(question)

      within "#answer_#{answer2.id}" do
        expect(page).to_not have_link('Best answer!')
      end

      within "#answer_#{answer.id}" do
        expect(page).to have_link('Best answer!')

        click_on 'Best answer!'
      end

      expect(page).to     have_selector("#answer_#{answer.id}.best")
      expect(page).to_not have_selector("#answer_#{answer2.id}.best")

    end
  end
end