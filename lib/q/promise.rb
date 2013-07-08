class Q::Promise
  def initialize(defer)
    @defer = defer

    @thens = []
    @fails = []
    @alwayses = []
  end

  def then(&block)
    enqueue_and_call(@thens, block, :resolved?)
  end

  def fail(&block)
    enqueue_and_call(@fails, block, :rejected?)
  end

  def always(&block)
    enqueue_and_call(@alwayses, block, :finished?)
  end

  def fulfill(type, result)
    @result = result

    if type == :resolved
      @thens.each { |callback| callback.call(@result) }
    elsif type == :rejected
      @fails.each { |callback| callback.call(@result) }
    end

    @alwayses.each { |callback| callback.call(@result) }
  end

  private

  def enqueue_and_call(queue, block, call_condition)
    callback = Q::Callback.new(self, block)
    queue << callback
    callback.call(@result) if @defer.send(call_condition)
    self
  end
end
