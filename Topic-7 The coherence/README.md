## Readings

(pdf) [Chapter 5 @ Kramer & Eden, Case studies in neural data analysis, 2016.](/Readings/Kramer_Eden_Chapter_5.pdf)

(pdf) [Kramer, SFN Short Course Document.](/Readings/Kramer_SFN_Short_Course.pdf)

(pdf) [Chapter 25 @ M. X. Cohen, Analyzing neural time series data, 2014.](/Readings/Cohen_Chapter_25.pdf)

(pdf) [Chapter 26 @ M. X. Cohen, Analyzing neural time series data, 2014.](/Readings/Cohen_Chapter_25.pdf)

## Videos

(lec) COHR Part 1 - see OneNote

(lec) COHR Part 2 - see OneNote

(lec) COHR Part 3 - see OneNote

## Code

(pynb) Includes text, code [The Cross Covariance and Cohernece](https://mark-kramer.github.io/Case-Studies-Python/05.html)

## Discussion

1. Define the frequency resolution.  How do you “improve” it?  (What does that mean?)

2. Define the Nyquist frequency.  How do you “improve” it?  (What does that mean?)

3. Define the coherence in words.

4. What are the units of coherence?

5. What is the role of phase in the coherence?

6. How is coherence related to the power spectrum?

7. Given two example signals, what do you expect for the coherence?

(pynb) [Cross-covariance-and-coherence-for-class-Part-1.ipynb](Cross-covariance-and-coherence-for-class-Part-1.ipynb)

(pynb) [Cross-covariance-and-coherence-for-class-Part-2.ipynb](Cross-covariance-and-coherence-for-class-Part-2.ipynb)

## Challenges

1. Consider two signals `x` and `y`, where `x` is a cosine function and `y` is a sine function. Both signals are of duration 2 s and of frequency 10 Hz. Notice, in this case, the data consist of single trials.
    1. Simulate both signals (each with a sampling interval of 0.001 s) and compute their cross correlation. What do you find, and how do you interpret the results?
    2. Imagine that the signal `x` was collected from the scalp EEG of a human subject two years ago, while signal `y` was collected from a voltage recording made in rat hippocampus yesterday. Would you expect these two signals - collected from very diverse preparations - to be related? How does this knowledge impact your interpretation of the cross correlation result?

2. Generate synthetic data consisting of a sinusoid oscillating at frequency `f` plus additive Gaussian noise.  More specifically, generate 100 trials of 1 s data sampled at 500 Hz. For each trial, set the initial phase of the sinusoid to a random value between `0` and `2 π.` Repeat this procedure to create a second dataset, but in this case fix the initial phase of the sinusoid to `π`.
    1. Compute the coherence between these two synthetic datasets.
    2. What do you expect to find (i.e., do these two signals possess a constant phase relationship across trials at any frequency)?
    3. Do your coherence results match your expectation?

3. Consider the dataset `ECoG-2.mat` available in the GitHub repository. Please load these data into Python.  Upon doing so, you will find three variables in your workspace. The variables `x` and `y` correspond to two simultaneous recordings of ECoG activity from two electrodes. Both variables are organized so that the rows correspond to trials, and the columns to time.  You should find 100 trials, with 1000 time points per trial. The variable `t` corresponds to the time axis for these data, in units of seconds. Please use these data to answer the following questions.

    1. Visualize the data from each electrode.  What rhythms do you observe?
    2. Plot the trial-averaged spectrum versus frequency for each electrode.  Are the dominant rhythms in the spectrum consistent with your visual inspection of the data?
    3. Plot the trial-averaged cross correlation between the two datasets.  What features do you observe?
    4. Plot the coherence between the two datasets.  At what rhythms, if any, is the coherence large?
    5. Summarize (in a few sentences) the results of your data analysis.  What are the important features of these data you would communicate to a colleague?

4. Consider the dataset `ECoG-3.mat` available in the GitHub repository. Please load these data into Python.  Upon doing so, you will find three variables in your workspace. The variables `x` and `y` correspond to two simultaneous recordings of ECoG activity from two electrodes. Both variables are organized so that the rows correspond to trials, and the columns to time.  You should find 100 trials, with 1000 time points per trial. The variable `t` corresponds to the time axis for these data, in units of seconds. Please use these data to answer the following questions.

    1. Visualize the data from each electrode.  What rhythms do you observe?
    2. Plot the trial-averaged spectrum versus frequency for each electrode.  Are the dominant rhythms in the spectrum consistent with your visual inspection of the data?
    3. Plot the trial-averaged cross correlation between the two datasets.  What features do you observe?
    4. Plot the coherence between the two datasets.  At what rhythms, if any, is the coherence large?
    5. Summarize (in a few sentences) the results of your data analysis.  What are the important features of these data you would communicate to a colleague?
