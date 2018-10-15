#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
morin_if_plot.py

 Author: Tom Morin
   Date: 10/10/18
Purpose: Plot an I-F plot for the Hodgkin Huxely model (Firing Rate vs. 
         Input Current)
"""

import numpy as np
from HH_functions import HH
import matplotlib.pyplot as plt

# Test for a range of currents
currents = np.arange(0,200,10)
firing_rates = np.zeros([len(currents), 1])

T0 = 15 # Input Current

# Test over all currents
for i in range(0, len(currents)):
    # Simulate the Hodgkin Huxley Model
    [Vs,ms,hs,ns,ts] = HH(currents[i],T0)
    
    # Test for a rise before the peak
    a = (Vs[0:len(Vs)-2] < Vs[1:len(Vs)-1])
    
    # Test for a fall after the peak
    b =  (Vs[1:len(Vs)-1] > Vs[2:])
    
    # Find spikes (spots with a rise before and a fall after)
    spikes = np.logical_and(a,b)
    
    # Count number of spikes
    firing_rates[i] = sum(spikes)
   
# Plot
plt.plot(currents, firing_rates)
plt.xlabel('Input Current')
plt.ylabel('Firing Rate')
    

    



