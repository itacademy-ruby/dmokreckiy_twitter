class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show

    @user = User.find(params[:id])  
  end

  def new

    @user = User.new
    render layout: "my_layout"
  end
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Book was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end
end
