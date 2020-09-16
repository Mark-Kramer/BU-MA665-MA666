#######################################################################################
# The *IF* model.

import numpy as np
import matplotlib.pyplot as plt

def IF(I,C,plot):                #Input important parameters, and an option to plot V vs t.
    
    Vth = 1;                     #Define the voltage threshold.
    Vreset = 0;                  #Define the reset voltage.
    dt=0.01                      #Set the timestep.
    V = np.zeros([1000,1])       #Initialize V.
    V[0]=0.2;                    #Set the initial condition.

    for k in range(1,999):       #March forward in time,
        V[k+1] = V[k] + dt*(I/C) #Update the voltage,
        if V[k+1] > Vth:         #... and check if the voltage exceeds the threshold.
            spikes=V[k+1]>Vth
            V[k+1] = Vreset      #... if so, reset the voltage
            
    t = np.arange(0,len(V))*dt   #Define the time axis.
    
    return spikes/t
    
    if plot:                     #If the plot flag is on, plot V vs t.
        plt.plot(t,V)
