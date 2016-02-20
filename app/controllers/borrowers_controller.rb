class BorrowersController < ApplicationController
	before_action :require_login, except: [:create]

	def create
		@borrower = Borrower.create ( borrower_params )
		if @borrower.save
			session[:user_id] = @borrower.id
			redirect_to '/borrowers/' + session[:user_id].to_s
		else 
			flash[:errors] = @borrower.errors.full_messsages
			redirect_to root_path
		end
	end

	def show
		@borrower = Borrower.find(session[:user_id])
	end

	private
	def borrower_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :description, :money)

	end
end
