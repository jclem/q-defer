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

    promises.each do |promise|
      promise.then do |result|
        @results << result
        defer.resolve(@results) if @results.length == promises.length
      end.fail do |result|
        defer.reject([result, @results])
      end
    end

    defer.promise
  end
end
