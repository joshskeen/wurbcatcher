class Play < Chingu::GameState

  traits :timer
  def initialize
    super
    self.input = {f1: :debug, q: :exit}
    every(500, :name => :blink) {  Wurb.all.each.map{|w| w.change_direction}}
  end

  def setup
      @hero = Hero.create(x: 100, y: 100)
      @status = Status.create(hero: @hero)
      5.times { new_wurb }
  end

  def new_wurb
    Wurb.create(:x => rand($window.width), :y => rand($window.height))
  end

  def update
    super
    Hero.each_collision(Wurb) do |hero, wurb|
      hero.encounter_wurb(wurb)
    end
  end

  def debug
    push_game_state(Chingu::GameStates::Debug.new)
  end


end