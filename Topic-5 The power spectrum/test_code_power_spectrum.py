from scipy.io import loadmat
import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import spectrogram

data = loadmat('EEG-1.mat')    # Load the EEG data
EEG = data['EEG'].reshape(-1)  # Extract the EEG variable
t = data['t'][0]               # ... and the t variable

dt = t[1]-t[0]
N  = np.size(EEG)
T = N*dt

fNQ = 1/dt/2
df  = 1/T

fj = np.linspace(0,fNQ,int(N/2+1))

x = EEG
X = np.ndarray(np.size(fj), complex);
for j in range( np.size(fj) ):
    #print(j)
    X[j] = np.sum(x * np.exp(-2*np.pi*1j*fj[j]*t));

Sxx = 2*dt**2/T * X * np.conj(X)

plot(fj, Sxx.real)