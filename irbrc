def x
  exit
end

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

class Object # For ActiveRecord::Base
  def c
    self.count if self.methods.include? 'count'
  end
  def f
    self.find(:first) if self.methods.include? 'find'
  end
  def a
    self.find(:all) if self.methods.include? 'find'
  end
  def r
    self.find(:first, :order => "RAND()") if self.methods.include? 'find'
  end
  def ua(*args)
    update_attribute(*args)
  end
  def uas(*args)
    update_attributes(*args)
  end
end if ENV['RAILS_ENV']


# http://errtheblog.com/posts/41-real-console-helpers
# So link_to works better and you can load helpers with 'helper :posts'
def Object.method_added(method)
  return super(method) unless method == :helper
  (class<<self;self;end).send(:remove_method, :method_added)

  def helper(*helper_names)
    returning $helper_proxy ||= Object.new do |helper|
      helper_names.each { |h| helper.extend "#{h}_helper".classify.constantize }
    end
  end

  helper.instance_variable_set("@controller", ActionController::Integration::Session.new)

  def helper.method_missing(method, *args, &block)
    @controller.send(method, *args, &block) if @controller && method.to_s =~ /_path$|_url$/
  end

  helper :application rescue nil
end if ENV['RAILS_ENV']

