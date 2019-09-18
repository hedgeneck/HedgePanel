import numpy as np

# vamos fazer a função random walk como uma função python

def random_walk(start=0, n=10, sigma=1):
	rw = [start]

	for i in range(1,n):
		rw.append(rw[-1]+np.random.normal(0, sigma))

	return rw