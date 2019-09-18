import numpy as np

# uma maneira de iniciar um array com 1 elemento igual a 100 é np.array(100)
rw = [np.array(100)]
# np.array([1, 2, 3]) se quiser array com mais de 1
# eu pensava em iniciar rw como um numpy array por causa do output da função normal mas acabo
# de descobrir que a função normal com dimensão 1 retorna um float

rw = [100]

n = 100

for i in range(1,n):
	rw.append(rw[-1]+np.random.normal(0, 1))

print(rw)