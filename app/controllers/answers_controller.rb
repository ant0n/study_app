class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_answer_and_check_author, only: [:update, :destroy, :edit]

  def create
    @question      = Question.find(params[:question_id])
    # как лучше, так
    #@answer        = @question.answers.create(answer_params.merge!({author_id: current_user.id}))
    # или так
    @answer        = @question.answers.build(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def edit; end

  def update
    @answer.update(answer_params)
    @answer.reload if @answer.errors.present?
  end

  def destroy
    @answer.destroy
    render nothing: true, status: 202
  end


  private

    def get_answer_and_check_author
      @answer = Answer.find(params[:id])
      unless @answer.author == current_user
        @answer.errors.add :author_id, 'only can modify answer'
        respond_to { |f| f.js }
      end
    end

    def answer_params
      params.require(:answer).permit(:body)
    end
end
