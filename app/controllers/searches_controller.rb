class SearchesController < ApplicationController

  respond_to :js, only: :show

  def index; end

  def show
    query  = params[:search][:q]
    type   = params[:search][:type]
    fields = type.select{|k,v| v=="1"}.map{|k,v| k.classify.constantize }

    if type[:all] == '1'
      @objects = ThinkingSphinx.search(query)
    else
      @objects = ThinkingSphinx.search(query, classes: fields)
    end

    @groups  = @objects.group_by{|o| o.class.name.underscore}

    respond_to do |format|
      format.js {render :show}
    end
  end

end
