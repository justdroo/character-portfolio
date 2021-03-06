class CharactersController < ApplicationController
  def index
    @characters = Character.where(user_id: session[:user_id])
    @attribute_sums = current_user.character_attributes
  end

  def new
    @character = Character.new
    @skills = Skill.all
    @talents = Talent.all

    3.times do
      @character.skills << Skill.find(1)
    end

    @character.talents << Talent.find(1)
  end

  def create

    @character = Character.new(character_params)
    @character.user_id = session[:user_id]
    @character.game = Game.find(session[:game_id])

    x = SkillsAssigner.new(@character, params[:character][:skills])
    x.assign

    @character.talents.clear
    @character.talents << Talent.find(params[:character][:talent])

    if @character.save
      redirect_to @character
    else
      @skills = Skill.all
      @talents = Talent.all
      render :new
    end
  end

  def show
    @character = Character.find(params[:id])
    if @character.talents.first.id == 8
      @pokemon = Pokemon.new
    end
  end

  def edit
    @character = Character.find(params[:id])

    if @character.user_id != session[:user_id]
      redirect_to @character
    end
    @skills = Skill.all
    @talents = Talent.all
  end

  def update
    @character = Character.find(params[:id])

    #if @character.update(character_params)

     @character.name = params[:character][:name]
     @character.commando = params[:character][:commando]
     @character.hacker = params[:character][:hacker]
     @character.witch = params[:character][:witch]

    x = SkillsAssigner.new(@character, params[:character][:skills])
    x.assign

    @character.talents.clear
    @character.talents << Talent.find(params[:character][:talent])

    #else
    #  @skills = Skill.all
    #  @talents = Talent.all
    #  render :edit
    #end

     if @character.save
       redirect_to @character
     else
       @skills = Skill.all
       @talents = Talent.all
       render :edit
     end
  end

  def destroy
    character = Character.find(params[:id])
    character.destroy
    redirect_to game_path(session[:game_id])
  end

  private

  def character_params
    params.require(:character).permit(:name, :commando, :witch, :hacker)
  end

end
