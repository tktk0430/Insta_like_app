class MicropostsController < ApplicationController
  def new
    @micropost=Micropost.new
  end
end
