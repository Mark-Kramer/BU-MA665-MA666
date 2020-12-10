import numpy as np
import matplotlib.pyplot as plt

def analyze(V,spike_train, I, t, plots=True):
    
    """ 
    The function takes in membrane voltage V, spike train, total current 
    drive I for all trials and a time vector t and returns a dictionary 
    'results' that contains trial-averaged auto-spectra of V (Svv), 
    spikes (Snn) and I (Sii), coherence between I and V (Civ) and between
    I and spike train (Cin), and the frequency axis faxis. The auto-spectra 
    and coherences are plotted if input 'plots' is set to True (the default)
    
    """

    N = np.shape(V)[1]                      # number of observations per trial
    dt = t[1]-t[0]                          # sampling interval
    T = t[-1]                               # total time of the recording
    f0 = 1/dt                               # sampling frequency
    fNQ = f0/2                              # Nyquist frequency 
    df = 1/T                                # frequency resolution

    # Fourier transforms
    Nf = np.array([np.fft.fft(n0 - n0.mean()) for n0 in spike_train])  # FT of spike_train for each trial
    Vf = np.array([np.fft.fft(y0 - y0.mean()) for y0 in V])            # FT of V for each trial
    If = np.array([np.fft.fft(i0 - i0.mean()) for i0 in I])            # FT of I for each trial
    
    # Auto-spectra
    Snn = 2 * dt**2 / T * (Nf * Nf.conj())  # spectrum of spike train
    Svv = 2 * dt**2 / T * (Vf * Vf.conj())  # specturm of V
    Sii = 2 * dt**2 / T * (If * If.conj())  # specturm of I
    
    # Cross-spectra
    Siv = 2 * dt**2 / T * (If * Vf.conj())  # cross spectrum of I and V
    Sin = 2 * dt**2 / T * (If * Nf.conj())  # cross spectrum of spike train and I
    
    # Trial average
    Snn = np.mean(Snn,0)
    Svv = np.mean(Svv,0)
    Sii = np.mean(Sii,0)
    Siv = np.mean(Siv,0)
    Sin = np.mean(Sin,0)
    
    # Taking the real part
    Snn = Snn[0:int(N/2)]
    Svv = Svv[0:int(N/2)]
    Sii = Sii[0:int(N/2)]
    Siv = Siv[0:int(N/2)]
    Sin = Sin[0:int(N/2)]
    
    faxis = np.arange(0,fNQ,df)             # frequency axis
    
    # Calculate coherences
    Civ = (Siv * np.conj(Siv))/(Sii*Svv)    # coherence between I and V
    Cin = (Sin * np.conj(Sin))/(Sii*Snn)    # coherence between I and spike train
    
    results = dict()                        # dictionary for storing outputs
    results['Snn']   = Snn.real
    results['Svv']   = Svv.real
    results['Sii']   = Sii.real
    results['Civ']   = Civ.real
    results['Cin']   = Cin.real
    results['faxis'] = faxis
    
    # Plots
    if plots == True: 
    
        # Trial averaged auto-spectra plots
       
        fig, (ax1, ax2, ax3) = plt.subplots(3,1,figsize =[10, 12])
        ax1.plot(faxis,Snn)
        ax1.set_ylabel('Power[$\mu V^2$/Hz]')
        ax1.set_title('Auto-Spectrum Spiking')
        
        ax2.plot(faxis,Svv)
        ax2.set_ylabel('Power[$\mu V^2$/Hz]')
        ax2.set_title('Auto-Spectrum V')
        
        ax3.plot(faxis,Sii)
        ax3.set_xlabel('Freq[Hz]')
        ax3.set_ylabel('Power[$\mu V^2$/Hz]')
        ax3.set_title('Auto-Spectrum I')
        
        # Coherence plots
        
        plt.figure()
        plt.plot(faxis, Civ.real)      
        plt.ylim([0, 1.1])                     
        plt.xlabel('Frequency [Hz]')           
        plt.ylabel('Coherence')
        plt.title('Trial averaged coherence between I and V')
        plt.show()
        
        plt.figure()
        plt.plot(faxis, Cin.real)      
        plt.ylim([0, 1.1])                     
        plt.xlabel('Frequency [Hz]')           
        plt.ylabel('Coherence')
        plt.title('Trial averaged coherence between I and Spike Train')
        plt.show()
    
    return results

