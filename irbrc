require 'rubygems'
require 'map_by_method'
require 'wirble'
Wirble.init
Wirble.colorize

alias x exit
alias q exit

require 'irb/ext/save-history'
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_PATH] = File::expand_path("~/.irb.history")

class Integer
  #Time it. e.g. 100.ti {rand(500) ** rand(50)}
  def ti(&block)
    Benchmark.bm do |x|
      x.report do
        self.times do
          yield
        end
      end
    end
  end

  def threads
    Benchmark.bm do |x|
      x.report('total') do
        ts = []
        self.times do |i|
          ts << Thread.new(i) do
            x.report("thread #{i}") do
              yield
            end
          end
          ts.each {|t| t.join}
        end
      end
    end
  end
end

# http://dotfiles.org/~lattice/.irbrc

class Object
  def local_methods
    self.methods.sort - self.class.superclass.methods
  end
  alias lm local_methods
end

# Simple regular expression helper
# show_regexp - stolen from the pickaxe
def show_regexp(a, re)
  if a =~ re
    "#{$`}<<#{$&}>>#{$'}"
  else
    "no match"
  end
end

# Convenience method on Regexp so you can do
# /an/.show_match("banana")
class Regexp
  def sm(a)
    show_regexp(a, self)
  end
end
