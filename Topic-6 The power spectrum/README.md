## Readings

(pdf) 	[Chapter 3 @ Kramer & Eden, Case studies in neural data analysis, 2016.](/Readings/Kramer_Eden_Chapter_3.pdf)

(pdf)   [Chapter 4 @ Kramer & Eden, Case studies in neural data analysis, 2016.](/Readings/Kramer_Eden_Chapter_4.pdf)

(pdf) 	[Kramer, SFN Short Course Document.](/Readings/Kramer_SFN_Short_Course.pdf)

(lib) 	Very Advanced: [Chapter 4 @ Percival & Walden, Spectral Analysis for Physical Applications.](https://www.cambridge.org/core/books/spectral-analysis-for-physical-applications/A9195239A8965A2C53D43EB2D1B80A33)

## Videos

(lec) POW Part 1 - see OneNote

(lec) POW Part 2 - see OneNote

(lec) POW Part 3 - see OneNote

(lec) POW Part 4 - see OneNote

## Code

(pynb)  Includes text, code, and videos: [The Power Spectrum (Part 1)](https://mark-kramer.github.io/Case-Studies-Python/03.html)

(pynb)  Includes text and code: [The Power Spectrum (Part 2)](https://mark-kramer.github.io/Case-Studies-Python/04.html)

## Discussion

0. Why brain rhythms?
1. Define the frequency resolution.  How do you “improve” it?
2. Define the Nyquist frequency.  How do you “improve” it?
3. Consider the case in which a collaborator demands a frequency resolution of 0.0001 Hz.  How much data must be recorded?  What are the disadvantages of recording the data required?
4. Describe in words (or equations) what the Fourier transform does?
5. What are the units on the power spectrum axes?
6. What is “negative power” (i.e., decibels)?
7. Given a time series, estimate (in your head) the power spectrum.
8. Given a power spectrum, estimate (in your head) the time series that created it. 

(pynb)  [Power-spectrum-for-class-Part1.ipynb](Power-spectrum-for-class-Part1.ipynb)

(pynb)  [Power-spectrum-for-class-Part2.ipynb](Power-spectrum-for-class-Part2.ipynb)

## Challenges

1. Load the file: `EEG-2.mat`, available on the Github repository into Python.
    1. What is the sampling interval?
    2. What is the total duration of the recording (T)?
    3. What is the frequency resolution (df)?
    4. What is the Nyquist frequency (fNQ)?
    5. Plot the data and visually inspect it.  Describe briefly (in a sentence or two) what rhythms - if any - you see in the data.
    6. Plot the spectrum versus frequency. You may choose to plot the spectrum on a decibel scale, or not. Defend your choice!
    7. Plot the spectrogram as a function of frequency and time.  You will need to choose the interval size and the overlap between intervals.  Do the rhythms in these data appear to change in time?
    8. Interpret (in a few sentences) the spectrum and spectrogram, and describe the rhythms present in the signal.  Compare your visual inspection of the data to the spectrum results - do the analyses agree or disagree?

6. Repeat Question (1) for the data set `EEG-3.mat`. Be sure to address each sub-question.
7. Repeat Question (1) for the data set `EEG-4.mat`. Be sure to address each sub-question.
8. Repeat Question (1) for the data set `EEG-5.mat`. Be sure to address each sub-question.

9. Consider the function `x(t) =  sin(2 pi t^2)`. That's a "t squared" input in the `sin` function.
    1. Simulate this function in Python using a sampling interval of dt = 0.001 s, and t = (0, 10) s.
    2. Compute the spectrum, and compute the spectrogram.
    3. Explain the results you find in each case, and how these results compare to your expectations.
