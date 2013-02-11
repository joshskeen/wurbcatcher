class GuiState < Fidgit::GuiState
  def initialize
    super
    vertical align: :center do
      my_label = label "wurbcatcher", background_color: Gosu::Color.rgb(0,100,0)
      button("goodbye", align_h: :center, tip: "adios!") do
        my_label.text = "GOODBYE."
      end
    end
  end
end