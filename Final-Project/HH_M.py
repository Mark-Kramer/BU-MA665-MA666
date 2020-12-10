#HH_M
#HH model that includes M-current and outputs gating variables as well


import numpy as np
from scipy.signal import find_peaks
import matplotlib.pyplot as plt

def alphaM(V):
    return (2.5-0.1*(V+65)) / (np.exp(2.5-0.1*(V+65)) -1)

def betaM(V):
    return 4*np.exp(-(V+65)/18)

def alphaH(V):
    return 0.07*np.exp(-(V+65)/20)

def betaH(V):
    return 1/(np.exp(3.0-0.1*(V+65))+1)

def alphaN(V):
    return (0.1-0.01*(V+65)) / (np.exp(1-0.1*(V+65)) -1)

def betaN(V):
    return 0.125*np.exp(-(V+65)/80)

def alphaKM(V):
    return 1.5* 0.02/(1.0+np.exp((-V-20)/5)) 

def betaKM(V):
    return 1.25* 0.01*np.exp((-V-43)/18) 

def HH2(A_tonic, A_sin, A_noise, T, K, gKM):
    T = T * 1000; #convert to ms
    dt = 0.01;
    T  = int(np.ceil(T/dt))  # [ms]
    t = np.arange(0,T)*dt
    N = len(t)   #time bins
     
    gNa0 = 120   # [mS/cm^2]
    ENa  = 115;  # [mV]
    gK0  = 36;   # [mS/cm^2]
    EK   = -12;  # [mV]
    gL0  = 0.3;  # [mS/cm^2]
    EL   = 10.6; # [mV]
    #gKM   = ??;  # [mS/cm^2] 
   

    V = np.zeros([K,N])
    m = np.zeros([N,1])
    h = np.zeros([N,1])
    n = np.zeros([N,1])
    KM = np.zeros([N,1])

    V[:,0]=-70.0
    m[0]=0.05
    h[0]=0.54
    n[0]=0.34   
    KM[0]=0.7

   
    I = np.zeros([K,N])
    I_sin = A_sin * np.sin(2*np.pi*t/1000*8)
    I_tonic = np.ones([N]) * A_tonic 
    
    spike_train = np.zeros([K,N])
    
    for j in range (K):
        I_noise = np.random.normal(0, A_noise, N)
        
        for i in range(T-1):
            I[j,i] = I_tonic[i] + I_sin[i] + I_noise[i]
            V[j,i+1] = V[j,i] + dt*(gNa0*m[i]**3*h[i]*(ENa-(V[j,i]+65)) + gK0*n[i]**4*(EK-(V[j,i]+65)) + gL0*(EL-(V[j,i]+65)) + gKM*KM[i]*(EK-(V[j,i]+65)) + I[j,i]);
            m[i+1] = m[i] + dt*(alphaM(V[j,i])*(1-m[i]) - betaM(V[j,i])*m[i]);
            h[i+1] = h[i] + dt*(alphaH(V[j,i])*(1-h[i]) - betaH(V[j,i])*h[i]);
            n[i+1] = n[i] + dt*(alphaN(V[j,i])*(1-n[i]) - betaN(V[j,i])*n[i]);
            KM[i+1] = KM[i] + dt*(alphaKM(V[j,i])*(1-KM[i]) - betaKM(V[j,i])*KM[i]);
    
        peaks, _ = find_peaks(np.reshape(V[j,:],[N]), height=20)
        spike_train[j,peaks] = 1 # in Hz
    
    t = t/1000;
    return V, spike_train, I, t , m, h, n, KM


