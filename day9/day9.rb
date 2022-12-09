# part 1

class Coord
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

def moveTail (head, tail)
    if (head.x - tail.x).abs > 1 || (head.y - tail.y).abs > 1
        if (head.x - tail.x).abs >= 1 && (head.y - tail.y).abs >= 1
            if head.x > tail.x
                tail.x += 1
            else
                tail.x -= 1
            end
            if head.y > tail.y
                tail.y += 1
            else
                tail.y -= 1
            end
        else 
            if (head.x - tail.x).abs >= 1
                # move tail horizontally
                if head.x > tail.x
                    tail.x += 1
                else
                    tail.x -= 1
                end
            else
                # move tail vertically
                if head.y > tail.y
                    tail.y += 1
                else
                    tail.y -= 1
                end
            end
        end
    end
end

head = Coord.new(0, 0)
tail = Coord.new(0, 0)
tailHistory = [tail.clone]

path = File.readlines("day9/day9.txt").map(&:chomp)
for move in path
  direction = move[0]
  amount = move[1..-1].to_i
  for i in 0...amount
    case direction
    when "R"
      head.x += 1
    when "L"
      head.x -= 1
    when "U"
      head.y += 1
    when "D"
      head.y -= 1
    end
    moveTail head, tail
    tailHistory.push(tail.clone)
  end
end

puts tailHistory.uniq{|x| [x.x, x.y]}.length

# part 2

rope = Array.new(10) { Coord.new(0, 0)}
tailHistory2 = [rope[-1].clone]

for move in path
    direction = move[0]
    amount = move[1..-1].to_i
    for i in 0...amount
        case direction
        when "R"
        rope[0].x += 1
        when "L"
        rope[0].x -= 1
        when "U"
        rope[0].y += 1
        when "D"
        rope[0].y -= 1
        end
        for i in 0...rope.length - 1
            moveTail rope[i], rope[i + 1]
        end
        tailHistory2.push(rope[-1].clone)
    end
end

puts tailHistory2.uniq{|x| [x.x, x.y]}.length