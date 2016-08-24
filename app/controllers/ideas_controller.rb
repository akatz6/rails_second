class IdeasController < ApplicationController

	def create
		@user = User.find(session[:user_id])
		@idea = Idea.create(comment:params[:idea][:comment], alias:@user.last_name, likes: 0)
		if @idea.valid?
			redirect_to :back
		else
			flash[:error] = @idea.errors.full_messages
			redirect_to :back
		end		
	end

	def show
		@idea = Idea.find(params[:id])
		@likes = Like.where(idea_id:@idea.id)
		puts '/n/n//n/n/n/n/n/n/'
		puts @likes 
	end
end
