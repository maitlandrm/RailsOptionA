class Borrower < ActiveRecord::Base
	has_many :histories, dependent: :destroy
	has_many :lenders, through: :histories
	has_secure_password
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :first_name, :last_name, :password, :purpose, :description, :money, presence: true, on: :update, allow_blank: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

	def self.check_session borrower
		valid_user = Borrower.find_by(email: borrower["email"])
		if valid_user && valid_user.authenticate(borrower["password"])
			return {"status": true, "id": valid_user.id}
		else
			return false
		end
	end
end
