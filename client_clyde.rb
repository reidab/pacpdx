require 'drb'
DRb.start_service
Shoes.app(:width => 700, :height => 700, :title => 'Clyde') do
  
  COLUMNS = [11,120,238,358,475]
  ROWS    = [89,204,320,440,539,649]
  
  background black
  @back = image('images/map.jpg')
  
  @clyde = image('images/clyde.jpg')
  remote_clyde = DRbObject.new(nil,'druby://localhost:7705')
  
  fill blue
  @cursor = oval(0,0,30)
  
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
      @clyde.move(COLUMNS[@cursor_column-1]-5,ROWS[@cursor_row-1]-5)
      remote_clyde.move_to(COLUMNS[@cursor_column-1]-5,ROWS[@cursor_row-1]-5)
    end
    @cursor.move(COLUMNS[@cursor_column-1],ROWS[@cursor_row-1])
  end
end