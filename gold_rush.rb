require_relative 'Game'
def show_usage_and_exit
  puts 'Usage:'
  puts 'ruby gold_rush.rb *seed* *num_prospectors*'
  puts '*seed should be an integer*'
  puts '*num_prospectors* should be a non-negative integer'
  exit 1
end

def check_args(args)
  args.count == 2
rescue StandardError
  false
end

valid_args = check_args ARGV

if valid_args
  game = Game.new(ARGV[0].to_i, ARGV[1].to_i)
  game.play
else
  show_usage_and_exit
end
