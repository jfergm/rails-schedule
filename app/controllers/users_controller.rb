class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User created"

      redirect_to users_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated"

      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @user.destroy
    rescue
      flash[:error] = "Could not delete user: #{@user.name}"
    end
    flash[:success] = "User deleted"

    redirect_to users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :last_name)
  end
end
