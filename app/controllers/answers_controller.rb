class AnswersController < ApplicationController
  before_action :get_answer, only: [:update, :destroy]

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      render nothing: true, status: 202
    else
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
      @answer = Answer.find_by(id: params[:id])
    end

    def answer_params
      params.require(:answer).permit(:title, :body)
    end
end
