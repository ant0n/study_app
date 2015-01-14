class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_answer, only: [:update, :destroy, :edit, :set_best]
  before_action :check_author, only: [:update, :destroy, :edit]

  def create
    @question      = Question.find(params[:question_id])
    @answer        = @question.answers.build(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def edit; end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
    render nothing: true, status: 202
  end

  def set_best
    if current_user == @answer.question.author
      @answer.update(is_best: true)
      render :set_best, status: :ok
    else
      render nothing: true, status: 550
    end
  end

  private

    def get_answer
      @answer = Answer.find(params[:id])
    end

    def check_author
      unless @answer.author == current_user
        @answer.errors.add :author_id, 'only can modify answer'
        respond_to { |f| f.js }
      end
    end

  def answer_params
      params.require(:answer).permit(:body, attachments_attributes: [:file, :_destroy])
    end
end
