class UsersController < ApplicationController
	def index
		@user = User.new
	end

	def create
		@user = User.create( user_params)
		@user.password_digest
		if @user.valid?
			flash[:success] = "Successfully registered, please log in"
			redirect_to root_path
		else
			flash[:error] = @user.errors.full_messages
			redirect_to root_path
		end
	end

	def destroy
		Idea.find(params[:user][:id]).destroy
		redirect_to :back
	end

	def show
		@user = User.find_by_last_name(params[:id])
		@post = Idea.where(alias:@user.last_name).count
		@like = Like.where(alias:@user.last_name).count
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
	end
end
