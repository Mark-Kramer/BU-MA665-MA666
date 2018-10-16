import numpy as np
from scipy.signal import argrelextrema
from HH_functions import HH
import matplotlib.pyplot as plt

firingrate = np.zeros([10,1])
I0 = np.zeros([10,1])

for i in range(0,10): #Change for whatever range of current you wanna test
    I0[i] = i  #Set input current
    T0 = 100 #Set how long to run simulation
    [V,m,h,n,t] = HH(I0[i],T0) #Run HH simulation
    maxm = argrelextrema(V, np.greater)  # (array([1, 3, 6]),)
    maxm2 = maxm[0]
    maxm3 = maxm2[1:]
    firingrate[i] = 100/(maxm3[3]-maxm3[2])

print(I0)
print(firingrate)

plt.plot(I0,firingrate)
    
