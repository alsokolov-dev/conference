class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to SOCBIN BIOINFORMATICS 2016!'
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :organization_name, :department, :position,
                                 :area_of_interest, :presentation, :abstract, :visa_sponsorship, :hotel, :password,
                                 :password_confirmation)
  end
end
