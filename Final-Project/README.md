## Final Project

Our goal for the next two lectures is to: (1) simulate the HH neuron with different types of driving current, (2) analyze the resulting dynamics, and (3) characterize the relationship between the HH dynamics and the driving current. To do so, we’ll divide into 3 teams, each with a different mandate (see below). Our goal is for each team to complete its objective, and then assemble the pieces to draw scientific conclusions.

## Scenario / Question

What is the relationship between the HH model dynamics and different types of current input? To answer this, we'll divide the input `I` into 3 parts:
- `I_tonic`: constant input
- `I_sin`: sinusoidal input with mean 0 and frequency 8 Hz.
- `I_noise`: noise input with mean 0.

so that
	`I` = `I_tonic + I_sin + I_noise`

Our goal is to characterize the relationship between the simulated membrane voltage (`V`) and spike train (`spike_train`) to the input current. To do so, for different `I` configurations, we'll simulate the HH model for 5 s, and analyze the results using tools we've developed. We'll divide and conquer, working in teams to create components used by other teams.

## Team Model
Create function `HH.py` with
- **inputs** `A_tonic, A_sin, A_noise, T, K`, where
	- `A_tonic`: [scalar] amplitude of tonic current drive,
	- `A_sin`: [scalar] amplidue of sinusoidal current drive (fix period at 8 Hz).
	- `A_noise`:  [scalar] amplidue of noise current input (Gaussian random noise with 0 mean).
	- `T`:  [scalar] total time of simulation in seconds (e.g., 1 s).
	- `K`:  [scalar] number of trials to simulate (e.g., 100).

- and **outputs** `V`, `spike_times`, `I`, and `t`, where
	- `V`: [matrix K,N] membrane voltage of neuron for each trial.
	- `spike_train`: [matrix K,N] the spike train for each trial.
	- `I`: [matrix K,N] the total current drive from all sources (tonic + sinusoidal + noise) for each trial.
	- `t`: [vector N] a time axis with units seconds.

Note: `N` is the length of the `t` vector, i.e., the number of bins on the time axis.


## Team Analyze
Create function `analyze.py` with
- **inputs** `V`, `spike_times`, `I`, and `t`, where
	- `V`: [matrix K,N] membrane voltage of neuron for each trial.
	- `spike_train`: [matrix K,N] the spike train for each trial.
	- `I`: [matrix K,N] the total current drive from all sources (tonic + sinusoidal + noise) for each trial.
	- `t`: [vector N] a time axis with units seconds.

- and **outputs** `Svv`, `Snn`, `Sii`, `Civ`, `Cin`, `faxis`
	- `Svv`: [vector N/2+1] trial-averaged (auto)spectrum of membrane voltage `V` for each trial. 
	- `Snn`: [vector N/2+1] trial-averaged (auto)spectrum of spike train `spike_train` for each trial.
	- `Sii`: [vector N/2+1] trial-averaged (auto)spectrum of total current drive `I` for each trial. 
	- `Civ`: [vector N/2+1] coherence between total current drive `I` and membrane voltage `V` 
	- `Cin`: [vector N/2+1] coherence between total current drive `I` and spike train `spike_train`
	- `faxis`: [vector N/2+1] a frequency axis for plotting with units seconds, 
	
	and, a plot of each trial-averaged (auto)spectrum and the two coherences.
	
## Team Theory
Consider these current drive scenarios:
- **tonic-only current drive** (+ small noise)
- **noise-only current drive** (i.e., large noise only)
- **sinusoidal-only current drive** (+ small noise)
- **tonic + noise + sinusoidal current drive**

For each scenario,
- determine the appropriate inputs to `HH.py`
- predict and describe (in pictures and words) the expected outputs of `analyze.py`
- work with Team Model to run `HH.py`
- work with Team Analyze to analyze the HH model output.

