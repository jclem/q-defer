class Q::Callback
  def initialize(promise, block)
    @promise = promise
    @block = block
  end

  def call(result)
    unless @called
      @block.call(result)
      @called = true
    end
  end
end
