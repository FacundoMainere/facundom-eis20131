require 'test/unit'

class FibonacciTest < Test::Unit::TestCase

  def test_es_de_fibonacci_con_cero_debe_ser_verdadero
    assert(es_de_fibonacci(0))
  end

  def test_es_de_fibonacci_con_menos_uno_debe_ser_falso
    assert(!es_de_fibonacci(-1))
  end

  def test_es_de_fibonacci_con_cuatro_debe_ser_falso
    assert(!es_de_fibonacci(4))
  end

  def test_es_de_fibonacci_con_ocho_debe_ser_verdadero
    assert(es_de_fibonacci(8))
  end
end

def es_de_fibonacci(un_numero)
  if un_numero < 0
    return false
  end
  if un_numero == 0
    return true
  end
  primer_candidato = Math.sqrt((5*(un_numero**2))+4)
  segundo_candidato = Math.sqrt((5*(un_numero**2))-4)
  primer_candidato_es_cuadrado_perfecto = primer_candidato == primer_candidato.floor
  segundo_candidato_es_cuadrado_perfecto = segundo_candidato == segundo_candidato.floor
  return primer_candidato_es_cuadrado_perfecto || segundo_candidato_es_cuadrado_perfecto
end 
