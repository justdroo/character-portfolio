class CharactersController < ApplicationController
  def new
    @character = Character.new
  end

  def create

    @character = Character.new(character_params)
    @character.user_id = session[:user_id]
  
    if @character.save
      redirect_to @character
    end
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

  def character_params
    params.require(:character).permit(:name, :commando, :witch, :hacker)
  end

end