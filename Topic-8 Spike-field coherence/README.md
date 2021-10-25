## Readings

(pdf) [Chapter 11 @ Kramer & Eden, Case studies in neural data analysis, 2016.](/Readings/Kramer_Eden_Chapter_11.pdf)

(pdf) [Advanced - Lepage et al, Neural Computation, 2011.](/Readings/Lepage_Neural_Comp_2011.pdf)

(pdf) [Pesaran et al, Nat Neuro, 2018.](/Readings/Pesaran_2018.pdf)

## Code

(pynb) Includes text and code, [Spike-field coherence](https://mark-kramer.github.io/Case-Studies-Python/11.html)

## Discussion

(pynb) [spike-field-coherence-for-class.ipynb](spike-field-coherence-for-class.ipynb)

## Challenges

Computer challenges for the spike-field cohernece

1.	Load the file `spikes-LFP-2.mat` available at the GitHub repository into Python. You will find three variables. The variable `y` corresponds to the LFP data, in units of millivolts. The variable `n` corresponds to simultaneously recorded binary spiking events. The variable `t` corresponds to the time axis, in units of seconds. Both `y` and `n` are matrices, in which each row indicates a separate trial, and each column indicates a point in time. Use these data to answer the following questions.
    1. Visualize the data. What rhythms do you observe? Do you detect associations between the LFP and spikes?
    2. Plot the spectrum versus frequency for these data. Are the dominant rhythms in the spectrum consistent with your visual inspection of the data?
    3. Compute and display the spike-field coherence. Do you find evidence for spike-field coherence?
    4. Describe your results, as you would to a colleague or collaborator.

2.	Load the file `spikes-LFP-3.mat` available at the GitHub repository into Python. You will find three variables. The variable `y` corresponds to the LFP data, in units of millivolts. The variable `n` corresponds to simultaneously recorded binary spiking events. The variable `t` corresponds to the time axis, in units of seconds. Both `y` and `n` are matrices, in which each row indicates a separate trial, and each column indicates a point in time. Use these data to answer the following questions.
    1. Visualize the data. What rhythms do you observe? Do you detect associations between the LFP and spikes?
    2. Plot the spectrum versus frequency for these data. Are the dominant rhythms in the spectrum consistent with your visual inspection of the data?
    3. Compute and display the spike-field coherence. Do you find evidence for spike-field coherence?
    4. Describe your results, as you would to a colleague or collaborator.

3.	In this question, we consider a simple example that illustrates a fundamental feature of spike-field coherence. Let’s consider the case in which the field is a 10 Hz sinusoid plus Gaussian noise, and the spike train is drawn from a binomial distribution. For a binomial distribution, the probability of a spike at any time is not related to previous spiking behavior. In this case, we also assume no relation between the field and point process. Therefore, we expect to find no spike-field coherence. Let’s simulate some synthetic data in Python, compute the spike-field coherence, and see what we find.

As a first step, create 100 trials of multiscale data, each trial of 1 s duration with a sampling rate of 1000 Hz. Then define the synthetic data. To do so, create in each trial a field, which here will be a sinusoid; and a spike train, which here will be drawn from a binomial distribution with a probability `p` of a spike in each sampling interval:

```
N  = 1000         # Number of data points in 1 s.
dt = 1/1000;      # Sampling interval 0.001 s.

# simulated spike data for one trial.
m  = 1
p  = 0.01
n  = np.random.binomial(m, p, N)

# simulated sinusoidal field + noise for one trial.
y = np.sin(2.0*np.pi*np.arange(N)*dt * 10)+0.1*np.random.randn(1,N);
```

With these synthetic multiscale data defined, repeat the analysis we performed in class. In particular,
    1. Visualize the data. What rhythms do you observe? Do you detect associations between the LFP and spikes?
    2. Plot the spectrum versus frequency for these data. Are the dominant rhythms in the spectrum consistent with your visual inspection of the data?
    3. Compute and display the spike-field coherence. Do you find evidence for spike-field coherence?
    4. Describe your results, as you would to a colleague or collaborator.
    5. Do the results of each method match your expectations? In particular, do you expect to observe spike-field coherence between these simulated data?
