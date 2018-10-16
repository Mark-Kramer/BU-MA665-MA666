#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 15 10:47:31 2018

@author: kylie
"""

#F-I curve for Hodgkin-Huxley Model
import numpy as np
import math
import matplotlib.pyplot as plt
from HH_functions import HH
from scipy.signal import argrelextrema

T0 = 100 #set time for simulation
I = np.linspace(0,50,50) #set range of input currents
Vth = -20 #set voltage threshold for "spike"
NumSpike = []   #create vector to store spikes 
for i in range(0,len(I)): #for each value of input current...
    [V,m,h,n,t]=HH(I[i],T0) #simulate HH 
    Vspike = V[V>Vth] #extract voltages where voltage exceeds threshold as 'Vspike'
    spike_max = Vspike[argrelextrema(Vspike, np.greater)] #extract the max voltages for Vspike
    fire_num = len(spike_max) #calculating number of spikes during Vspike intervals
    NumSpike = NumSpike + [fire_num] #returning number of spikes to spike vector NumSpike
FR = [x/(T0/1000) for x in NumSpike] #firing rate 

plt.figure()
plt.plot(I,FR)
plt.ylabel('Firing Rate (Hz)')
plt.xlabel('Input Current (Amps)')
