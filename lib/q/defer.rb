class Q::Defer
  attr_reader :promise, :state

  def initialize
    @promise = Q::Promise.new(self)
    @state = :active
  end

  def resolve(result = nil)
    unless finished?
      @state = :resolved
      @promise.fulfill(@state, result)
    end

    @promise
  end

  def reject(result = nil)
    unless finished?
      @state = :rejected
      @promise.fulfill(@state, result)
    end

    @promise
  end

  def resolved?
    @state == :resolved
  end

  def rejected?
    @state == :rejected
  end

  def finished?
    @state == :resolved || @state == :rejected
  end
end
