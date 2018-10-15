# Assuming we already have the HH model as developed in class; i.e., [V,m,h,n,t] = HH(InputCurrent, TimeInMs)

import numpy as np
import matplotlib.pyplot as plt 
from scipy.signal import find_peaks #Peak finding algorithm I found online

MinInput = 0 #Minimum input current to evaluate
MaxInput = 100 #Maximum input current to evaluate
T = 1000 #Time to run the model, in ms
FI = np.zeros([MaxInput,1]) #Create empty vector to store results

for i in range(MinInput, MaxInput):
    [V,m,h,n,t] = HH(i,T) #Run the model for input current i and 200-ms
    peaks, _  = find_peaks(np.reshape(V, -1), height=-20) #Find peaks using someone else's function, -20 is threshold for definition of a peak
    FI[i] = np.shape(peaks) #Number of peaks in 200-ms
    
Current = np.linspace(MinInput, MaxInput, num=MaxInput)
plt.plot(Current, FI, 'k')
plt.xlabel('Input current (uA/cm2)')                   
plt.ylabel('Firing rate (Hz)')             
plt.title('F-I Curve for Hodgkin Huxley Model')   
