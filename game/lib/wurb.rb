class Wurb < Chingu::GameObject

  traits :velocity, :collision_detection, :bounding_circle

  attr_reader :direction_x, :direction_y

  def initialize(args={})
    super(args)
    @image = Image["wurb.png"]
    @speed = rand(1..3)
    @direction_x = @direction_y = rand > 0.5 ? 1 : -1
    @last_x, @last_y = @x, @y
    change_direction
  end

  def update
    @x += @speed * (@direction_x)
    @direction_x = @direction_x * -1 if outside_window?
    @direction_y = @direction_y * -1 if outside_window?
    @y += @speed * (@direction_y)
    @x, @y = @last_x, @last_y if outside_window?  # return to previous coordinates if outside window
    @last_x, @last_y = @x, @y                     # save current coordinates for possible use next time
  end

  def change_direction
      @speed_tweak_interval = rand(3000..5000)
      @speed = rand(1..2)
      @direction_x = rand > 0.5 ? 1 : -1
      @direction_y = rand > 0.5 ? 1 : -1
  end

  def run_from_hero(hero)
    change_direction
    @direction_x = @direction_x * -1
    @direction_y = @direction_y * -1
    @speed += 1.5
  end

end