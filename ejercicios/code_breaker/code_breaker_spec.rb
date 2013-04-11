require 'rspec'
require './code_breaker.rb'

describe CodeBreaker do
  attr_reader :code_breaker
  before(:each) do 
    @code_breaker = CodeBreaker.new('alas')
  end
  describe 'initialize' do
    it 'should take 5 as default life if not specified' do
    
      code_breaker.life.should eq 5
    end
    
    it 'should have 10 life if specified' do
    
      CodeBreaker.new('roberto',10).life.should eq 10
    end
    
    it 'should have specified string as code' do
    
      code_breaker.code.should eq 'alas'
    end
    
    it 'should lowercase all the letters in the word' do
    
      CodeBreaker.new('UPPERCASE').code.should eq 'uppercase'
    end
    
    it 'should lowercase when using upper and lowercase letters in the word' do
     
      CodeBreaker.new('CamelCase').code.should eq 'camelcase'
    end
    it 'should raise an error when string has numeric characters' do
      
      lambda{CodeBreaker.new('1arca')}.should raise_error
    end
    
    it 'should raise an error when string has non-alphanumeric characters' do
 
      lambda{CodeBreaker.new('a#rca')}.should raise_error
    end
  end
  describe 'guess' do

    it 'should decrement life when fail' do

      initial_life = @code_breaker.life
      code_breaker.guess('c')
      code_breaker.life.should eq initial_life-1
    end
    it 'should have the same amount of life when correct' do
      
      initial_life = @code_breaker.life
      code_breaker.guess('l')
      code_breaker.life.should eq initial_life
    end
    
    it 'should reveal when guessing is correct' do
    
      code_breaker.guess('s').should eq '***s'
    end
    
    it 'should reveal the guessed letter when its correct even if it is uppercase' do
      
      code_breaker.guess('a').should eq 'a*a*'
    end
    
    it 'should raise error when using non-alphanumeric letters' do
    
      lambda {code_breaker.guess('#')}.should raise_error
    end
    
    it 'should raise error when using numeric letters' do
    
      lambda {code_breaker.guess('3')}.should raise_error
    end
    
    it 'should not raise error when using alphabetic letters' do
    
      lambda {code_breaker.guess('a')}.should_not raise_error
    end
    
    it 'should not raise error when using uppercase letters' do
    
      lambda {code_breaker.guess('A')}.should_not raise_error
    end
  end
  describe 'generate_slots' do
    it 'should return the same amount of characters as the received string' do

      received_string = @code_breaker.code
      result_string = @code_breaker.generate_slots
      received_string.length.should eq result_string.length
    end
    it 'should return all stars before starting guessing' do

      code_breaker.generate_slots.should eq '****'
    end
    it 'should reveal all instances of the same letter when guessing it' do
    
      code_breaker.guess 'a'
      code_breaker.generate_slots.should eq 'a*a*'
    end
    it 'should not change slots if guess is wrong' do
      
      code_breaker.guess 'f'
      code_breaker.generate_slots.should eq '****'
    end
  end 
  describe 'win?' do
    it 'should be true when you guessed all the letters' do
      
      code_breaker.guess 'a'
      code_breaker.guess 'l'
      code_breaker.guess 's'
      code_breaker.should be_win
    end
    
    it 'should be false when you are dead' do
      
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.guess 'a'
      code_breaker.guess 'l'
      code_breaker.guess 's'
      code_breaker.should_not be_win
    end 
    
    it 'should be false when you lost some life' do
      
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.should_not be_win
    end
  end
  describe 'dead?' do
    it 'should be false when you are playing' do
      
      code_breaker.should_not be_dead
    end
    
    it 'should be true when you lost all the lifes' do
      
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.should be_dead
    end
    
    it 'should be false when you lost some life' do
      
      code_breaker.guess 'r'
      code_breaker.guess 'r'
      code_breaker.should_not be_dead
    end
  end
  describe 'game_status' do
    it 'should return win string when you win' do
      
      code_breaker.guess 'a'
      code_breaker.guess 'l'
      code_breaker.guess 's'
      code_breaker.game_status.should eq 'You win! the secret word was alas!'
    end
    it 'should return dead string when dead' do
      
      code_breaker.guess 'r'
      code_breaker.guess 'n'
      code_breaker.guess 'x'
      code_breaker.guess 'm'
      code_breaker.guess 'o'
      code_breaker.game_status.should eq 'You are dead, the secret word was alas!'
    end
    it 'should return whole string hidden when beggining game' do
      
      code_breaker.game_status.should eq '****'
    end
    it 'should reveal letter when guess is right' do
      
      code_breaker.guess 'l'
      code_breaker.game_status.should eq '*l**'
    end
    it 'should not reveal letter when guess is wrong' do
      
      code_breaker.guess 'x'
      code_breaker.game_status.should eq '****'
    end
  end
  describe 'its_only_alphabetic' do
    it 'should raise an error when passing it a string that has numeric characters' do
 
      lambda{code_breaker.its_only_alphabetic 'manat33'}.should raise_error
    end
    it 'should raise an error when passing it a string that has non-alphanumeric characters' do
 
      lambda{code_breaker.its_only_alphabetic '##trotsky'}.should raise_error
    end
    
    it 'should not raise error when using a valid word' do
      
      lambda{code_breaker.its_only_alphabetic 'trotsky'}.should_not raise_error
    end
    
    it 'should not raise error when using a valid word with uppercase letters' do
      
      lambda{code_breaker.its_only_alphabetic 'Trotsky'}.should_not raise_error
    end
  end
end
