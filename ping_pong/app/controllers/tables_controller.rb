class TablesController < ApplicationController 
  # remove unused methods
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

  def table_params
    params.require(:player).permit(:name)
  end
end