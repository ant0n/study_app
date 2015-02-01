class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_answer, only: [:update, :destroy, :edit, :set_best]
  before_action :check_author, only: [:update, :destroy, :edit, :set_best]

  respond_to :js, :json

  def create
    @question      = Question.find(params[:question_id])
    @answer        = @question.answers.build(answer_params)
    @answer.author = current_user
    @answer.save
    respond_with @answer
  end

  def edit
    respond_with @answer
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
  end

  def destroy
    respond_with @answer.destroy
  end

  def set_best
    @answer.update(is_best: true)
    render :set_best, status: :ok
  end

  private

    def get_answer
      @answer = Answer.find(params[:id])
    end

    def check_author
      authorize @answer
    end

  def answer_params
      params.require(:answer).permit(:body, attachments_attributes: [:file, :_destroy])
    end
end
