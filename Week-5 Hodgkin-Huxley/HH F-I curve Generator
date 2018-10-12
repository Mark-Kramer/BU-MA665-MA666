"""
Created on Thu Oct  4 12:57:39 2018

H-H F-I Curve

This script requires the HH_functions.py code to run
Note -- depending on the T0 constant selected, this code may take a while to run

This script runs a series of HH simulations using different input currents to 
brute-force the firing rate of a HH neuron.

@author: Kelton
"""

#General import statements
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import find_peaks
from HH_functions import HH

#Brute force method of demonstrating F-I Curve for H-H Model

fRateVector = []    #Create vector to store firing rates 
iRange = np.linspace(0,25,25)   #Set how many inputs to test

T0 = 400    #Set temporal length of simulation 
#!! Note !! >100 is computationally expensive

for i in range(0,len(iRange)):
    I0 = iRange[i]  #Set input current
    [V,m,h,n,t] = HH(I0,T0) #Run HH simulation
    V = np.reshape(V,-1)
    highV = V[V > 0]    #Collect Voltage only above 0 mV
    numPeaks = find_peaks(highV)[0]     #Find peaks on cropped voltage data
    fRate = len(numPeaks)     #Get number of spikes
    fRateVector = fRateVector + [fRate]
    
#Plotting...    
plt.figure()
plt.plot(iRange,fRateVector)
plt.ylabel('Firing Rate (# of spikes)')
plt.xlabel('Current (Amps)')
plt.title('F-I Curve for HH Model')
