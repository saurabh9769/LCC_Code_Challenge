class UsersController < ApplicationController

  before_action :set_user, only: [:archive, :unarchive, :destroy]

  def index
    if is_archive
      render jsonapi: archived_user
    elsif is_unarchive
      render jsonapi: unarchived_user
    else
      render jsonapi: User.all
    end
  end

  def archived_user
    User.archive
  end

  def unarchived_user
    User.unarchive
  end

  def is_archive
    params[:status] == 'archive'
  end

  def is_unarchive
    params[:status] == 'unarchive'
  end

  def archive
    render json: { error: 'Cannot archive Current User' }, status: :unprocessable_entity and return if @user == current_user
    @user.archive!
    StatusUpdateMailer.with(user: @user).status_update_notification(@user).deliver
    render json: { message: 'User Archived' }, status: :ok
  end

  def unarchive
    @user.unarchive!
    StatusUpdateMailer.with(user: @user).status_update_notification(@user).deliver
    render json: { message: 'User Unarchived' }, status: :ok
  end

  def destroy
    @user.destroy
    StatusUpdateMailer.with(user: @user).status_update_notification(@user).deliver
    render json: { message: 'User Deleted' }, status: :ok
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
