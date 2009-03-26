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

# Load Machinist on request
def maker
  include Machinist
  require 'test/blueprints'
end

# http://dotfiles.org/~lattice/.irbrc
class Object
  def local_methods
    self.methods.sort - self.class.superclass.methods
  end
  alias lm local_methods

  # aliases don't work because ActiveRecord hasn't been loaded yet
  def ua(*args)
    respond_to?(:update_attribute) ? update_attribute(*args) : raise(NoMethodError)
  end
  def uas(*args)
    respond_to?(:update_attributes) ? update_attribute(*args) : raise(NoMethodError)
  end
end
