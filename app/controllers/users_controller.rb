class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user=User.new(name:"No name")
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end