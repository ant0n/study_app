class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    respond_with current_resource_owner
  end

  def index
    @users = User.all
    respond_with @users
  end

end