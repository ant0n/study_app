class Api::V1::AnswersController < Api::V1::BaseController

  def index
    @question = Question.find params[:question_id]
    @answers  = @question.answers
    respond_with @answers
  end

  def show
    @question = Question.find params[:question_id]
    @answer   = @question.answers.find(params[:id])
    respond_with @answer, serializer: AnswerFullSerializer, root: :answer
  end

  def create
    @question      = Question.find params[:question_id]
    @answer        = @question.answers.build(answer_params)
    @answer.author = current_resource_owner
    @answer.save
    respond_with @answer, serializer: AnswerFullSerializer, root: :answer
  end

  private

    def answer_params
      params.require(:answer).permit(:body)
    end
end