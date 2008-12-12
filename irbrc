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
