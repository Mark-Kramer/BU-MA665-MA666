## Readings

(pdf) [Chapter 7 @ Kramer & Eden, Case studies in neural data analysis, 2016.](/Readings/Kramer_Eden_Chapter8.pdf)

(pdf) [Tort et al, J Neurophysiol, 2010.](/Readings/Tort_J_Neurophysiol_2010.pdf)

(pdf) [Hyafil et al, Trends Neurosci, 2015.](/Readings/Hyafil_TINS_2015.pdf)

## Videos

(lec) CFC Part 1 - see OneNote

(lec) CFC Part 2 - see OneNote

## Code

(pynb)  Python (includes text, code, and videos): [Cross-Frequency Coupling](https://mark-kramer.github.io/Case-Studies-Python)

## Discussion

1.	How does cross-frequency coupling differ from coherence?
2.	What are the basic steps to compute cross-frequency coupling?
    1.	What is the role of phase?
    2.	What is the role of amplitude?
3.	Why might cross-frequency coupling be useful in the brain?
4.	Given a signal, do you expect to find cross-frequency coupling?

## Challenges

1.	Load the file `LFP-2.mat` available at the GitHub repository into Python. You will find two variables. The variable `LFP` corresponds to an LFP recording. The variable `t` corresponds to the time axis, in units of seconds. Use these data to answer the following questions.
    1. Visualize the time series data. What rhythms do you observe? Do you detect evidence for CFC in your visualizations?
    2. Plot the spectrum versus frequency for these data. Are the dominant rhythms in the spectrum consistent with your visual inspection of the data?
    3. Apply the CFC method we discussed in class to these data. In doing so, you must choose the low-frequency and high-frequency bands. What choices will you make, and why? What – if any – CFC do you find?
    4. Describe (in a few sentences) your spectrum and CFC results, as you would to a colleague or collaborator.

2.	Load the file `LFP-3.mat` available at the GitHub repository into Python. You will find two variables. The variable `LFP` corresponds to an LFP recording. The variable `t` corresponds to the time axis, in units of seconds. Use these data to answer the following questions.
    1. Visualize the time series data. What rhythms do you observe? Do you detect evidence for CFC in your visualizations?
    2. Plot the spectrum versus frequency for these data. Are the dominant rhythms in the spectrum consistent with your visual inspection of the data?
    3. Apply the CFC method we discussed in class to these data. In doing so, you must choose the low-frequency and high-frequency bands. What choices will you make, and why? What – if any – CFC do you find?
    4. Describe (in a few sentences) your spectrum and CFC results, as you would to a colleague or collaborator.

3.	Generate synthetic data consisting of Gaussian noise. More specifically, generate 100 s of [artificial noise data](https://numpy.org/doc/stable/reference/random/generated/numpy.random.randn.html) sampled at 1000 Hz. Then compute the CFC of these data. To do so, use the low-frequency band of 5–7 Hz and the high-frequency band of 80–120 Hz. What do you expect to find (i.e., will this noisy signal exhibit CFC)? What do you find?

4.	(**ADVANCED**) In our analysis of CFC, we focused on distinct choices of high- and low-frequency bands. However, sometimes we would like to explore a broader range of potential cross-frequency interactions. To do so, we need a comodulagram. Use the code developed in this module to define a new function that computes a comodulogram. Your comodulogram should have two axes:
    1. x-axis: the phase frequency (e.g., 3 Hz to 12 Hz in 1 Hz steps)
    2. y-axis: the amplitude frequency (e.g., 50 Hz to 200 Hz in 10 Hz steps)
For each pair of (x-axis, y-axis) values, determine the statistic `h` and plot the three-dimensional results. For reference and motivation, consider the comodulograms in https://www.ncbi.nlm.nih.gov/pubmed/23345227
