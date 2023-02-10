class UsersController < ApplicationController
  before_action  :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def create
    @user = User.new(users_params)
    @user.save
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to user_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(users_params)
      flash[:notice] = "Your details has been updated successfully."
      redirect_to user_path
    else
      render 'edit'
    end
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:username,:email,:password)
  end

end
