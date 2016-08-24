class SessionsController < ApplicationController
	def create
		@idea = Idea.new
		user = User.find_by(user_params)
		if user 
		 if  user.authenticate params[:user][:password]
			session[:user_id] = user.id
			redirect_to sessions_path
		else
			flash[:error] = "Bad Login"
			redirect_to root_path
		end
		else
			flash[:error] = "Bad Login"
			redirect_to root_path
		end
	end

	def index
		@user = User.find(session[:user_id])
		@user_alias = @user.last_name
		@ideas = Idea.all.order('likes desc')
		@idea = Idea.new
		@user = User.find(session[:user_id])
	end

	def show
		@user = User.find(session[:user_id])
		@like = Like.find_by_alias_and_idea_id(@user.last_name, params[:id])
		if @like
			flash[:error] = "You already liked this"
			redirect_to :back
		else
			@idea = Idea.find(params[:id])
			temp = @idea.likes
			temp += 1
			@idea[:likes] = temp
			@idea.save
			Like.create(alias:@user.last_name, idea_id: params[:id] )
			redirect_to :back
		end
		
	end

	private
	def user_params
		params.require(:user).permit(:email)
	end
end
