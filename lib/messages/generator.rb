module Messages
  # Adds functionality to generate responses based on given analysis
  class Generator
    # Define it somewhere on a more global level
    COMMUNICATION = JSON.parse(File.read('./config/communication.json'))
    attr_accessor :analysis, :text
    def initialize(analysis)
      @analysis = analysis
    end

    def generate
      @text = build_up_text

      self
    end

    private

    def build_up_text
      COMMUNICATION["stranger_ru"]["greeting"].sample +
      eos +
      COMMUNICATION["stranger_ru"]["proper_noun"].sample +
      space +
      COMMUNICATION["stranger_ru"]["write_to_me"].sample +
      space +
      COMMUNICATION["stranger_ru"]["this"].sample +
      ": " +
      @analysis.text.to_s +
      ". " +
      COMMUNICATION["stranger_ru"]["i"] +
      space +
      COMMUNICATION["stranger_ru"]["i_think"].sample +
      space +
      COMMUNICATION["stranger_ru"]["this"].sample +
      ": " +
      "\n" +
      COMMUNICATION["stranger_ru"]["language"] +
      ": " +
      @analysis.language.to_s +
      "\n" +
      COMMUNICATION["stranger_ru"]["mood"] +
      ": " +
      @analysis.mood.to_s +
      "\n" +
      COMMUNICATION["stranger_ru"]["type"] +
      ": " +
      @analysis.type.to_s
    end

    # End of sentence
    def eos
      ". "
    end

    def space
      " "
    end
  end
end
