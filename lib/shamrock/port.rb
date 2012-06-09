module Shamrock
  class Port
    attr_reader :number

    def initialize
      @number = Random.rand(9220...9239)
    end
  end
end
