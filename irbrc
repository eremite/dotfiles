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
end if ENV['RAILS_ENV']
