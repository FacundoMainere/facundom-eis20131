require 'sinatra/base'
require_relative '../code_breaker/code_breaker.rb'

class MyApplication < Sinatra::Base
  set :sessions, true
    
  get '/palabra' do
    session[:code_breaker] = CodeBreaker.new(params[:p],3)
    @estado = session[:code_breaker].generate_slots
    erb :resultado
  end

  get '/adivinar' do
    begin
      estado_anterior = session[:code_breaker].generate_slots
      @estado = session[:code_breaker].guess(params[:l])
      if @estado != estado_anterior
        @resultado_accion = 'acierto'
      else
        @resultado_accion = 'ups!'
      end
    rescue CodeBreakerExceptions::CodeBreakerWin
      @resultado_accion = 'Juego terminado, ganaste'
      @estado = session[:code_breaker].generate_slots
    rescue CodeBreakerExceptions::CodeBreakerDead
      @resultado_accion = 'ups!'
      @estado = 'Juego terminado, perdiste'
    end
    erb :resultado
  end
end
