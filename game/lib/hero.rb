require 'chingu'
include Gosu

class Hero < Chingu::GameObject

  traits :collision_detection, :bounding_circle

  attr_reader :life 

  def initialize(args={})
    super(args)
    @speed  = 3
    @health = 100
    self.input = {
      space: :swing_net,
      holding_left: :move_left,
      holding_right: :move_right,
      holding_up: :move_up,
      holding_down: :move_down,
      [:holding_left, :holding_right] => :update_factor_x,
      [:holding_left_shift, :released_left_shift ] => :update_speed,
    }
    self.factor = 1.2
    @animation = Chingu::Animation.new(:file => "hero.png", bounce: true, width: 30, height: 48)
    @animation.frame_names = {:stand => 4..4, :walk => 0..3, :swing_net => 7..12}
    @frame_name = :stand
    @swinging_net = false
    @last_x, @last_y = @x, @y
  end

  def encounter_wurb(wurb)
    if @swinging_net
      wurb.destroy
      Sound["caughtone.wav"].play
    else
      @health -= 10
      Sound["ouch.wav"].play
      @x -= 20 * (wurb.direction_x) * -1
      @y -= 10 * (wurb.direction_y) * -1
      wurb.run_from_hero(self)
    end
  end

  def update_speed
    @speed = holding?(:left_shift)? 4.5 : 3
  end

  def update_factor_x
    @factor_x = holding?(:right)? -1.2 : 1.2
  end

  def swing_net
      @swinging_net = true
      @frame_name = :swing_net
  end

  def move_up
    @y -= @speed
    @frame_name =  @swinging_net ? :swing_net : :walk
  end

  def move_down
    @y += @speed
    @frame_name = @swinging_net ? :swing_net : :walk
  end

  def move_left
    @x -= @speed
    @frame_name = @swinging_net ? :swing_net : :walk
  end

  def move_right
    @x += @speed
    @frame_name = @swinging_net ? :swing_net : :walk
  end

  def update
    @image = @animation[@frame_name].next
    default_animation = :stand
    if @swinging_net
      default_animation = :swing_net
      if @animation[@frame_name].index == 5 && @animation[@frame_name].step = 1
        @animation[@frame_name].step = -1
        @animation[@frame_name].index = 0
        @swinging_net = false
      end
    end
    @frame_name = default_animation if @x == @last_x && @y == @last_y
    @x, @y = @last_x, @last_y if outside_window?  # return to previous coordinates if outside window
    @last_x, @last_y = @x, @y                     # save current coordinates for possible use next time
  end

end
