class Status < Chingu::GameObject

  def initialize(args={})
    super(args)
    @hero = args.fetch(:hero)
    # $window.draw_rect(5, 5, 10, 10)
  end

  def update
    @hero.life
  end

end