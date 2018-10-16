# -*- coding: utf-8 -*-
"""
Created on Sun Oct  7 19:36:05 2018

@author: rifqi
"""
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import find_peaks
from scipy.signal import savgol_filter
from HH_functions import HH

# for function instruction or parameters
import inspect
inspect.getsourcelines(HH)


T0 = 500 
Input = np.linspace(0,60,100)
spikes = np.zeros((len(Input)))

#loop over inputs within input_array
for i in range(len(Input)):
    [V,m,h,n,t] = HH(Input[i],T0)
    V = np.concatenate(V) #restructure V so each elements not arrays
    peaks = find_peaks(V,prominence=(15,None)) #find peak via prominence critereion
    spikes[i] = len(peaks[0]) * 2 #estimate peak frequency within 1 sec [Hz]

plt.figure()
plt.plot(Input,spikes,lw = 3)
plt.xlabel('Input [mA/cm^2]')
plt.ylabel('Firing rate [Hz]')
        
# Smoothed function via Savitsky-Golay filter
plt.plot( Input, savgol_filter(spikes,45,4) )
plt.show

