import numpy as np 

x = np.random.normal(1.01, 0.03, 5)
# array([0.99444773, 0.94140399, 1.05218897, 1.00534229, 1.01679733])
# notar como o resultado é um array, explorando melhor

type(x)
# <class 'numpy.ndarray'>

y = list(range(11, 17))
# em python 3 range é um objeto iterator, então é necessário convertê-lo para lista
# [11, 12, 13, 14, 15, 16] - ele só vai até 16


z = [1] * 5
# para criar uma lista com o elemento repetidas vezes
# z é [1, 1, 1, 1, 1]

s = np.random.random(10)

mu, sigma = 0, 0.1 # mean and standard deviation
s2 = np.random.normal(mu, sigma, 5)
# https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.random.normal.html