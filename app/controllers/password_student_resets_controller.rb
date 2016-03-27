class PasswordStudentResetsController < ApplicationController
  before_action :get_student,         only: [:edit, :update]
  before_action :valid_student,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @student = Student.find_by(email: params[:password_reset][:email].downcase)
    if @student
      @student.create_reset_digest
      @student.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:student][:password].empty?
      @student.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @student.update_attributes(student_params)
      log_in @student
      flash[:success] = "Password has been reset."
      redirect_to @student
    else
      render 'edit'
    end
  end

  private

  def student_params
    params.require(:student).permit(:password, :password_confirmation)
  end

  # Before filters

  def get_student
    @student = Student.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_student
    unless (@student && @student.activated? &&
        @student.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @student.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_student_reset_url
    end
  end
end
