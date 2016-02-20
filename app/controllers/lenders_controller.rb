class LendersController < ApplicationController
	before_action :require_login, except: [:create
	]
	def create
		@lender = Lender.create( lender_params )
		if @lender.save
			session[:user_id] = @lender.id
			redirect_to '/lenders/' + session[:user_id].to_s 
		else
			flash[:errors] = @lender.errors.full_messages
			redirect_to root_path
		end
	end

	def show
		@lender = Lender.find(session[:user_id])
		@borrowers = Borrower.all
		
	end

	private
	def lender_params
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)

	end
end
