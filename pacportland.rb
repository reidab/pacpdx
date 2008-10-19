require 'drb'

class PacGame
  attr_accessor :pacman
  attr_accessor :inky
  attr_accessor :blinky
  attr_accessor :pinky
  attr_accessor :clyde
  
  COLUMNS = [11,120,238,358,475]
  ROWS    = [89,204,320,440,539,649]
  
end
  
$game = PacGame.new

Shoes.app(:width => 700, :height => 700, :title => 'Server') do
  
  COLUMNS = [11,120,238,358,475]
  ROWS    = [89,204,320,440,539,649]
  
  background black
  @back = image('images/map.jpg')
  
  $game.pacman = image('images/pacman.jpg')
  $game.inky = image('images/inky.jpg')
  $game.blinky = image('images/blinky.jpg')
  $game.pinky = image('images/pinky.jpg')
  $game.clyde = image('images/clyde.jpg')
  
  remote_pacman = DRb.start_service("druby://:7701", $game.pacman)
  remote_inky = DRb.start_service("druby://:7702", $game.inky)
  remote_blinky = DRb.start_service("druby://:7703", $game.blinky)
  remote_pinky = DRb.start_service("druby://:7704", $game.pinky)
  remote_clyde = DRb.start_service("druby://:7705", $game.clyde)
  
  fill blue
  @cursor = oval(0,0,30)
  append { $game.pacman }
  
  @cursor_row = 1
  @cursor_column = 1

  @cursor.move(COLUMNS[@cursor_row-1],ROWS[@cursor_column-1])
  
  keypress do |key|
    case key
    when :up
      @cursor_row -= 1 unless @cursor_row == 1
    when :down
      @cursor_row += 1 unless @cursor_row == ROWS.size
    when :left
      @cursor_column -= 1 unless @cursor_column == 1
    when :right
      @cursor_column += 1 unless @cursor_column == COLUMNS.size
    when ' '
      $game.pacman.move(COLUMNS[@cursor_column-1]-5,ROWS[@cursor_row-1]-5)
    end
    @cursor.move(COLUMNS[@cursor_column-1],ROWS[@cursor_row-1])
  end
end