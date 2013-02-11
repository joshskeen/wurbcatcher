require 'rubygems'
require 'gosu'
require 'chingu'
require 'pry'
require 'fidgit'

RequireAll.require_all File.dirname(__FILE__)

class Game < Chingu::Window

  def initialize
    super(640, 480, false)
    retrofy
    push_game_state Play
    # push_game_state GuiState
  end
end

Game.new.show
