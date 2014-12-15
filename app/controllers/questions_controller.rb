class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show;  end

  def new
    @question = Question.new()
  end

  def edit; end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = 'Question successfully created'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end


    private

      def get_question
        @question = Question.find_by(id: params[:id])
      end

      def question_params
        params.require(:question).permit(:title, :body)
      end
  end