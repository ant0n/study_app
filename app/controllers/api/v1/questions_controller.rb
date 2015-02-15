class Api::V1::QuestionsController < Api::V1::BaseController
  #serialization_scope :view_context

  def index
    @questions = Question.all
    respond_with @questions
  end

  def show
    @question = Question.find params[:id]
    render json: @question, serializer: QuestionFullSerializer, root: :question
  end

  def create
    @question        = Question.new(question_params)
    @question.author = current_resource_owner
    @question.save
    render json: @question, serializer: QuestionFullSerializer, root: :question
  end

  private

    def question_params
      params.require(:question).permit(:title, :body)
    end
end