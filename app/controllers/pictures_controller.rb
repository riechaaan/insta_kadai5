class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show
    # if logged_in?
    #   @favorite = current_user.favorites.find_by(id: @id)
    # else
    #   redirect_to new_user_path, notice:"ログインが必要です"
    # end
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    @picture = Picture.includes(:user).find(params[:id])
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  def edit
  end

  def create
    @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)
    respond_to do |format|
      if @picture.save
        PictureMailer.picture_mail(@picture).deliver
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    # params: { picture: { image: ... } }
    # params.require(:picutre): { image: "", image_cache: ... }
    params.require(:picture).permit(:image, :image_cache, :content, :name, :email) # .merge(user_id: current_user.id)
  end
end
