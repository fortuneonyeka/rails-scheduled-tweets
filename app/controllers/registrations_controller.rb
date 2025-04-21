class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to welcome_path(name: "#{@user.first_name} #{@user.last_name}"), 
      notice: "Successfully added #{@user.first_name} #{@user.last_name} "
    else
      render :new, status: :unprocessable_entity
    end
  end


private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name) # Add other permitted attributes
  end
end
