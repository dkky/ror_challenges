class UsersController < Clearance::UsersController

	def create
		@user = user_from_params

		respond_to do |format|
	    	if @user.save
			    UserMailer.welcome_email(@user).deliver_now
		        format.html {redirect_back_or url_after_create }
		        format.html { sign_in @user }
	     	else
		        format.html { render template: "users/new"}
		 	end
		end

	end

	def edit
	    @user = User.find(params[:id])
	end

	def update
	    @user = User.find(params[:id])
	    if @user.update(user_params)
	      redirect_to '/home/index'
	    else
	      render 'edit'
	    end
	end

	def my_listing
		@listing = current_user.listings
	end

	private

	# method from the gem 'clearance'
	def user_params
		params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :avatar, :remove_avatar)
	end
	
	def user_from_params
		User.new(user_params)
	end
end