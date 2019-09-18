import random
import pylab
import numpy as np 
import matplotlib.pyplot as plt 

x = random.sample([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 4)

print(x)



# Tirei as informações desse site
# https://www.geeksforgeeks.org/random-walk-implementation-python/
# Para instalar o numpy e o matplotlib tem que primeiro sair do enviroment
# >>> env\Scripts\deactivate
# agora temos que primeiramente atualizar o pip
# > python -m pip install --upgrade pip
# Agora instala o numpy
# > pip install numpy
# Agora instala o matplotlib
# Quando estamos dentro do interpretador e queremos chamar um script externo python usamos
# exec(open("03_random_walk_2d.py").read())

### NUMPY
# permite escrever matrizes, transpor, etc


### tipos básicos de python
# x = [1,2,5,4] LIST
	# [41, 'aaa', 32, ['a', 'b']] # listas podem ser heterogeneas, e aninhadas 
# t = (42, 1, 5) TUPLE - igual a lista, mas imutavel
	# x = 41, 37, 31 - outra maneira de inicializar
# s = {1, 2, 4, 7} SET - não permite valores repetidos
# d = {'a': 42, 'b': 717} DICTIONARY

### referenciando tipos básicos de python
# x[0] é 1
# t[0] é 42
# s[0] não funciona
# d['a'] é 42


