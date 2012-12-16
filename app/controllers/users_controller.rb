class UsersController < ApplicationController
  
  # The before filter gets executed before any of the code in the controller
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user,    only: :destroy

  # This shows the user
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # @param [Request] request the request object
  # @return [String] the resulting webpage
  # @author tawheed raheem
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  # creates new user
  # @note and a note
  # (see #get)
  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to tawzi"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      sign_in @user
      flash[:success] = "profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to user_path    
  end

  private
    # This takes care of the instance when the user tries to access the edit page
    # without being logged in
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in" 
      end
    end

    # We want to make sure that the user who is logged in only edits its page 
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
