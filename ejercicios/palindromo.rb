require 'test/unit'

class PalindromoTest < Test::Unit::TestCase

  def test_es_palindromo_de_un_string_vacio_debe_ser_verdadero
    assert(es_palindromo(""))
  end

  def test_es_palindromo_de_un_palindromo_con_cantidad_de_letras_impares_debe_ser_verdadero
    assert(es_palindromo("neuquen"))
  end

  def test_es_palindromo_de_un_palindromo_con_cantidad_de_letras_pares_debe_ser_verdadero
    assert(es_palindromo("anna"))
  end

  def test_es_palindromo_de_un_string_no_palindromo_debe_ser_falso
    assert(!es_palindromo("malabar"))
  end
end

def es_palindromo(palabra)
  until palabra == "" || palabra[0] != palabra[-1]
    palabra = palabra[1..-2]
  end
  return palabra == ""
end
