class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :check_author, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
    respond_with @question
  end

  def create
    @question        = Question.new(question_params)
    @question.author = current_user
    @question.save
    #logger.info render_to_string(template: 'questions/create.js')+'TEEEST'
    #PrivatePub.publish_to questions_path, question: 'test'
    respond_with(@question)
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with @question.destroy
  end


  private

    def set_question
      @question = Question.find(params[:id])
    end

    # responders i18n
    def interpolation_options
      { resource_name: 'Question', user: current_user.email }
    end

    def question_params
      params.require(:question).permit(:title, :body, attachments_attributes: [:file, :_destroy])
    end

    def check_author
      authorize @question
    end
end
