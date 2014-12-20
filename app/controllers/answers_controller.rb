class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_answer, only: [:update, :destroy]

  def create
    @question      = Question.find(params[:question_id])
    # как лучше, так
    #@answer        = @question.answers.build(answer_params.merge!({author_id: current_user.id}))
    # или так
    @answer        = @question.answers.build(answer_params)
    @answer.author = current_user
    unless @answer.save
      render nothing: true, status: 400
    end
  end

  def update
    if @answer.update(answer_params)
      render nothing: true, status: 202
    else
      render nothing: true, status: 400
    end
  end

  def destroy
    @answer.destroy
    render nothing: true, status: 202
  end


  private

    def get_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:body)
    end
end
