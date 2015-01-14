class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_vote, only: [:vote_up, :vote_down]

  def vote_up
    @vote.update(vote_flag: true)
    render :vote
  end

  def vote_down
    @vote.update(vote_flag: false)
    render :vote
  end

  private

    def get_vote
      object = params[:object].classify.constantize.find params[:id]
      @vh    = object.voteholder
      @vote  = Vote.find_or_create_by(voteholder: @vh, voter: current_user)
    end
end
