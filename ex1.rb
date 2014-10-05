require 'artoo'

connection :sphero, adaptor: :sphero, port: '/dev/tty.Sphero-PPB-AMP-SPP'
device :sphero, driver: :sphero

## ex1
# work do
#   @count = 0
#   every(3.seconds) do
#     sphero.set_color(@count % 2 == 0 ? :green : :blue)
#     @count += 1
#   end
# end


## Ex2
COLORS = [:green, :blue, :red, :yellow, :white]

def contact(*args)
  color = COLORS.shuffle.first
  sphero.set_color(color)
  puts "Contact new color is #{color}"
  roll_sphero_roll
end

def roll_sphero_roll
  sphero.roll 200, rand(361)
end



work do
  puts sphero.detect_collisions
  on sphero, :collision => :contact
  every(3.seconds) do
    roll_sphero_roll
    puts 'pow'
  end
end

