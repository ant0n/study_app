class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_question, only: [:show, :edit, :update, :destroy]
  before_action :check_author, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show; end

  def new
    @question = Question.new()
  end

  def edit; end

  def create
    @question        = Question.new(question_params)
    @question.author = current_user
    if @question.save
      flash[:success] = 'Question successfully created'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question}
        format.js   { render js: "window.location = '#{question_path(@question)}'" }
      else
        format.html { render :edit}
        format.js   { render :edit }
      end
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end


  private

    def get_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end

    def check_author
      redirect_to question_path(@question) if @question.author != current_user
    end
end
