class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :favorite]
  before_action :check_user, only: [:edit, :updare, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def favorite
    @favorites = @user.favorites
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを編集しました！"
    else
      render :edit
    end
  end

  private
  def user_params
  params.require(:user).permit(:image, :name, :email, :password,
                                :password_confirmation)
  end

  def set_user
  @user = User.find(params[:id])
  end
end
