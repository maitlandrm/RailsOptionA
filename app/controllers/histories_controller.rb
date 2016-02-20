class HistoriesController < ApplicationController

	def create
		@lender = Lender.find(session[:user_id])
		if @lender.money.to_f < params[:amount].to_f
			flash[:error] = "Not enough money! :("
			redirect_to '/lenders/' + session[:user_id].to_s
		else
			@borrower = Borrower.find(params[:borrower_id])
			if @borrower.raised != nil
				@raised = @borrower.raised.to_f + params[:amount].to_f
			else
				@raised = params[:amount].to_f
			end
			@lent = @lender.money.to_f - params[:amount].to_f
			@history = History.create(borrower: @borrower, lender: @lender , amount: params[:amount])
				if @history.save
					@borrower.update(raised: @raised)
					if @borrower.save
						@lender.update(money: @lent)
						if @lender.save
							redirect_to '/lenders/' + session[:user_id].to_s
						else
							flash[:errors] = @lender.errors.full_messages
							redirect_to '/lenders/' + session[:user_id].to_s
						end
					else
						flash[:errors] = @borrower.errors.full_messages
						redirect_to '/lenders/' + session[:user_id].to_s
					end
				else
					flash[:errors] = @history.errors.full_messages
					redirect_to '/lenders/' + session[:user_id].to_s
				end

			
		end
	end
end
