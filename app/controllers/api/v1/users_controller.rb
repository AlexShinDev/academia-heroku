require 'wikipedia'
class Api::V1::UsersController < ApplicationController
  def new
    
  end

  def create
    user = User.new(
                    name: params[:name],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation]
                    )
    if user.save
      session[:user_id] = user.id 
      flash[:success] = "Successfully created account"
      redirect_to '/api/v1/'
    else
      flash[:warning] = "Invalid email or password!"
      redirect_to '/api/v1/signup'
    end
  end

  def show
    @user = current_user
  end
end
