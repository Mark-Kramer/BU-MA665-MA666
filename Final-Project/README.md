## Final Project

Our goal for the next two lectures is to: (1) simulate the HH neuron with different types of driving current, (2) analyze the resulting dynamics, and (3) characterize the relationship between the HH dynamics and the driving current. To do so, we’ll divide into 3 teams, each with a different mandate (see below). Our goal is for each team to complete its objective, and then put assemble the pieces to draw scientific conclusions.


## Scenario / Question

Simulate a HH neuron 



### Team Model
- Create function `HH.py` with
	- inputs `A_tonic, A_sin, A_noise, T, K`, where
		- `A_tonic`: amplitude of tonic current drive,
		- `A_sin`: amplidue of sinusoidal current drive (fix period at 8 Hz).
		- `A_noise`:  amplidue of noise current input (Gaussian random noise with 0 mean).
		- `T`:  total time of simulation in seconds (e.g., 1 s).
		- `K`:  number of trials to simulate (e.g., 100).


and outputs `V`, `spike_times`, `I`, and `t`

