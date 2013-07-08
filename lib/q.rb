require "q/version"
require "q/callback"
require "q/defer"
require "q/promise"

module Q
  def self.defer(&block)
    defer = Q::Defer.new

    block.call(defer)

    defer.promise
  end

  def self.when(promises)
    defer = Q::Defer.new

    @results = []

    num_resolved = 0

    promises.each do |promise|
      promise.then do |result|
        num_resolved += 1
        @results << result
        defer.resolve(@results) if num_resolved == promises.length
      end.fail do |result|
        defer.reject([result, @results])
      end
    end

    defer.promise
  end
end
