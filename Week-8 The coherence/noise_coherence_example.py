"""
Created on Tue Oct 30 12:55:24 2018

@author: Mark Kramer
"""

import numpy as np
import matplotlib.pyplot as plt

# Make the noise data.

dt = 0.002;  T=1;
t = np.arange(0,T,dt)
N = np.shape(t)[0]
x = np.random.randn(N)
y = np.random.randn(N)

plt.clf()
plt.subplot(4,1,1)
plt.plot(t,x)
plt.plot(t,y)

# Compute the power

xf  = np.fft.rfft(x-np.mean(x))
yf  = np.fft.rfft(y-np.mean(y))
Sxx = 2*dt**2/T *np.real(xf*np.conj(xf))
Syy = 2*dt**2/T *np.real(yf*np.conj(yf))
Sxy = 2*dt**2/T *       (xf*np.conj(yf))

Sxx = Sxx[:int(len(x) / 2)]   # Ignore negative frequencies
Syy = Syy[:int(len(x) / 2)]
Sxy = Sxy[:int(len(x) / 2)]

df = 1 / T                      # Determine frequency resolution
fNQ = 1 / dt / 2                # Determine Nyquist frequency
faxis = np.arange(0,fNQ,df)     # Construct frequency axis

plt.subplot(4,1,2)
plt.plot(faxis, Sxx)		     # Plot power of x vs frequency.
plt.plot(faxis, Syy)            # Plot power of y vs frequency.
plt.xlabel('Frequency [Hz]')
plt.ylabel('Power');

# Compute the cross covariance

cc =1/N*np.correlate(x,y,2)

plt.subplot(4,1,3)
lags = np.arange(-N+1,N)
plt.plot(lags*dt,cc)
plt.xlim([-0.2, 0.2])
plt.xlabel('Lag [s]')
plt.ylabel('Cross-covariance')

# Compute the coherence

cohr = np.abs(Sxy) / (np.sqrt(Sxx) * np.sqrt(Syy))

plt.subplot(4,1,4)
plt.plot(faxis, cohr);	
plt.ylim([0, 1.1])
plt.xlabel('Frequency [Hz]')
plt.ylabel('Coherence')
