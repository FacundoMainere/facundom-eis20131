require 'set'
require_relative './code_breaker_exceptions'

class CodeBreaker
    
  def initialize(code, life = 5)
    its_only_alphabetic code
    @code = code.downcase
    @life = life
    @tries = Set.new      
  end
  
  attr_reader :life , :code
  
  def its_only_alphabetic(code)
    if /[[:alpha:]]+/.match(code).to_s != code
      raise CodeBreakerExceptions::InvalidCodeError
    end
  end

  def guess(letter)
    its_only_alphabetic letter
    letter.downcase!
    @tries<<letter 
    if !code.include? letter then @life -=1 end
    self.game_status
  end

  def game_status
    case
      when dead? then raise CodeBreakerExceptions::CodeBreakerDead
      when win? then raise CodeBreakerExceptions::CodeBreakerWin
      else generate_slots
    end
  end

  def dead?
    life <= 0
  end

  def win?
    !dead? and !generate_slots.include? '*'
  end  

  def generate_slots
    result = ''
    code.each_char do |char|
      if @tries.include? char 
        result << char 
      else 
        result << '*'
      end
    end
  result     
  end
end
