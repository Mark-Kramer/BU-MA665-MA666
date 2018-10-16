# -*- coding: utf-8 -*-
"""
Created on Thu Oct  4 11:05:04 2018

@author: lenovo

Generating firing rates at different I0
"""
from HH_functions import HH
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import find_peaks

T0 = 1000
len_I0=20
frate=np.zeros(len_I0)
for I0 in range(0,len_I0,1):
    I00=I0
    [V,m,h,n,t]=HH(I00,T0)
    ##peakind = signal.find_peaks_cwt(np.shape(V),np.arange(1,2000))
    #peakind = find_peaks(np.reshape(V,-1),height=0)
    peakind = find_peaks(np.reshape(V,-1),height=-20)
    ##frate[I0]=1000/(peakind[0][1]- peakind[0][0])
    #frate[I0]=np.shape(peak)
    frate[I0] = len(peakind[0])
plt.figure()
III=range(len_I0);
plt.plot(III,frate)
plt.xlabel('Input Current/mA')
plt.ylabel('Firing Rate/Hz')
plt.title('F-I Curve for HH Model')
###################################
#numi0=0
#for I0 in range(40):
#    [V,m,h,n,t]=HH(I0,T0)
#    nn=0
#    for t in range(1,2000):
#        if V[t]>=V[t-1] and V[t]>=V[t+1] and m[t]>=m[t-1] and h[t]>h[t-1] and n<n[t-1]:
#            nn=nn+1
#            if nn==1:
#                frate[numi0]=t
#            elif nn==2:
#                frate[numi0]=1/(t-frate[numi0])
#                break
#    numi0=numi0+1
#plt.figure()
#III=range(40);
#plt.plot(III,frate,'k')
##subplot12
#plt.figure()
#plt.subplot(211)
#plt.plot(t,V,'k')
#plt.xlim([42, 56])
#plt.ylabel('V [mV]');
#plt.subplot(212);
#plt.plot(t,m,'r', label='m')
#plt.xlim([42, 56]);
#plt.plot(t,h,'b', label='h')
#plt.plot(t,n,'g', label='n');
#plt.xlabel('Time [ms]');
#plt.legend();



