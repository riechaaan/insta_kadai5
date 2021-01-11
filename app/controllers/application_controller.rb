class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def check_user
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/pictures")
    end
  end

  def authenticate_user
    if @picture.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/pictures")
    end
  end
end
#   def authenticate_user
#     if logged_in?
#       unless current_user == @user
#         flash[:notice] = "アクセス権限がありません。"
#         redirect_to pictures_path
#       end
#     else
#       redirect_to new_user_path, notice:"ログインが必要です"
#     end
#   end
#   def ensure_current_user
#     if logged_in?
#       unless current_user.id == params[:id].to_i
#         flash[:notice] = "アクセス権限がありません。"
#         redirect_to pictures_path
#       end
#     else
#       redirect_to new_user_path, notice:"ログインが必要です"
#     end
#   end
