class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_object, only: [:new, :create]

  respond_to :js

  def new
    logger.info set_object
    respond_with @comment = Comment.new(commentable: @object)
  end

  private

    def set_object
      name    = request.fullpath.split('/')[1].classify
      @object = name.constantize.find params["#{name.downcase}_id".to_sym]
    end
end