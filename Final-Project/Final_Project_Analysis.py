#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 10 11:37:12 2020

@author: mak
"""

#%%
import numpy as np
import matplotlib.pyplot as plt
from   HH import HH
from   Analyze_Function import analyze

#%% Run example HH, for 0.5 s, and 10 trials (SLOW).
A_tonic = 10
A_sin   = 5
A_noise = 2
T       = 0.5
K       = 10
[V,spike_train,I,t] = HH(A_tonic, A_sin, A_noise, T, K)

#%% # Example plots of voltage for two trials.
plt.plot(t,V[0,:], 'r')
ispikes = np.where(spike_train[0,:]==1)
plt.plot(t[ispikes],np.transpose(spike_train[0,ispikes]),'ko')
plt.plot(t,I[0,:], 'b')

#%% # Analyze the results
results = analyze(V,spike_train, I, t, plots=True)

#%% # Additional plots
plt.plot(results['faxis'],results['Snn'])
plt.xlim([0,200]);