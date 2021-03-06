class Pokemon
  require 'rest-client'

  attr_reader :name, :img, :num

  def initialize
    @num = rand(1..150).to_s
    url = "http://pokeapi.co/api/v2/pokemon/#{num}"
    response = RestClient.get(url)
    poke_info = JSON.parse(response)
    @name = poke_info["name"].capitalize
    @img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{num}.png"
  end

  def catch
    num = rand(1..20)
    if num < 15
      false
    else
      true
    end
  end

end
