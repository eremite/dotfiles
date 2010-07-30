require 'profiler'
require 'rubygems'
require 'map_by_method'
require 'interactive_editor'
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

class Object

  # http://github.com/ryanb/dotfiles/blob/master/irbrc
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  alias lm local_methods

  # aliases don't work because ActiveRecord hasn't been loaded yet
  def ua(*args)
    respond_to?(:update_attribute) ? update_attribute(*args) : raise(NoMethodError)
  end
  def uas(*args)
    respond_to?(:update_attributes) ? update_attributes(*args) : raise(NoMethodError)
  end
  def f(*args)
    if args.empty?
      respond_to?(:first) ? first : raise(NoMethodError)
    else
      respond_to?(:find) ? find(*args) : raise(NoMethodError)
    end
  end

  def history(n = 10)
    Readline::HISTORY.entries.reject {|h| h =~ /history/i}.last(n)
  end

  def pi(&block)
    Profiler__::start_profile
    yield
    Profiler__::stop_profile
    Profiler__::print_profile($stderr)
  end

end
