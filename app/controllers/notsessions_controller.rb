class NotsessionsController < ApplicationController
	before_action :require_login, only:[:destroy]

	def index 
	end

	def new
	end

	def create
		@status = Lender.check_session({"email" => params[:email], "password" => params[:password]})
		if @status
			session[:user_id] = @status[:id]
			redirect_to '/lenders/' + session[:user_id].to_s
		else
			@status = Borrower.check_session({"email" => params[:email], "password" => params[:password]})
			if @status
				session[:user_id] = @status[:id]
				redirect_to '/borrowers/' + session[:user_id].to_s
			else 
				flash[:error] = "Invalid username or password"
				redirect_to root_path
			end
		end
		
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

end
