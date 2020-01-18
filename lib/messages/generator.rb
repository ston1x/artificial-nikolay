module Messages
  # Adds functionality to generate responses based on given analysis
  module Generator
    attr_accessor :response
    def initialize(analysis)
      @analysis = analysis
    end

    def generate
    end
  end
end
