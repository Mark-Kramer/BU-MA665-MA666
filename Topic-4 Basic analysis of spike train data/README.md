## Readings

(pdf) [Mainen & Sejnowski, Science (1995) vol. 268, pp. 1503-6.](/Readings/Mainen_1995.pdf)

(pdf) *ADVANCED:* [Kramer & Eden, J Neurosci Methods (2010) 190, no. 1, 149–52.](/Readings/Kramer_Eden_2010.pdf)

## Videos

N/A

## Code

(pynb)  [Basic Analysis of Spike Train Data](Basic_Analysis_of_Spike_Train_Data.ipynb)

(pynb)  Advanced, but perhaps of interest: [Kramer & Eden, Case Studies, Ch 8](https://mark-kramer.github.io/Case-Studies-Python/08.html)

## Discussion topics

N/A

## Computer challenges

#### 1.  Analyze another data set.
In lab we studied an example of spike train data.  Let's now consider a
  second data set with the following properties:
```
  Number of trials:  1000
  Duration of each trial:  500 ms
  Samping rate:  1000 Hz.
```
  You can download this data set `Ch3_d2.mat`
  
1. Load this data set and calculate the average number of
spikes per trial, the average firing rate, the average ISI, and the Fano
factor.
2. Compute and plot the SNH, ISI histogram, and PSTH and indicate the
average value of each measure on each plot.
3. Compare the results for 'd1' and 'd2'.  How are
they similar?  How do they differ?
4. Using all of the tools at your disposal, conclude that either d1
and d2 display similar activity, or d1 and d2 display different activity.
5. Describe briefly in words (a few sentences) how the activity in d2 behaves.
6. We've assumed throughout our analysis a sampling
window of size T=500 ms - the length of each trial.  Is this the best
choice for d1 and d2?  Why?  Briefly justify your conclusion.

### 2. Simulating spike trains as coin flips.
In this problem we'll simulate spike train data by performing "coin
  flips".  We discussed this idea in class.  To perform the coin flips,
  we'll draw numbers from a binomial distribution.  We'll perform a coin
  flip for each 1 ms interval of a 500 ms trial, and repeat this
  procedure for 100 trials. We'll save the results (for all coin flips)
  in a new matrix "data" to hold the artifical data we've create.

  To start, let's define variables for the number of trials, the number of time
  points we'll collect per trial, and the data,

```
n_trials=100;
T = 500;
data = np.zeros([n_trials, T]);
```

Note that, we define the variable `data` to initially consist of all zeros.  We may think of this as an empty matrix, not yet consisting of any spike data.  Our goal is to fill in this matrix with observations ... which we'll now do.

For each trial, let's generate 500 coin flips.  To do so, we'll generate 500 Bernoulli random numbers.  Each time we draw a Bernoulli random number, we'll get either 1 or 0.  This is like a "coin flip"
  in that there are two outcomes, either 1 or 0. We'll think of 1 as 
  indicating a "spike", and 0 as indicating "no spike".  We'll also make
  our coin biased, so that probability (p) of drawing a value of 1 is 
  equal to 0.01.  In Python, we'll begin by setting these parameters,


```
p=0.01;
```

Here, `T` is the number of (biased) coin flip, and `p `is the probability
  of returning a value of 1 (i.e., a "spike") on each coin flip.  Now,
  let's generate the artificial spike train data.  To do so, we'll flip
  our biased coin 500 times per trial, for 100 trials.  We'll save the
  result of our biased coin flips in the matrix "data" as follows:

```
for k in np.arange(n_trials):                    #For each trial,
    spikes = np.zeros([T,1]);                    #... make an empty vector for "spikes",
    for i in np.arange(T):                       #... and for each time,
        spikes[i] = np.random.binomial(1,p);     #... "flip the coin" and save results in "spikes",
    data[k,:] = np.transpose(spikes);            #... and save this trial in "data".
```

By generating these "coin flip data" you've generated an artifical set
  of spike train data.  These data are based on the simple statistical
  model of a Poisson process.  As we discussed in class, an imporant
  assumption of this model is that the neural activity at each interval
  of time is *independent* of all other times.  In the following
  questions, you're asked to analyze these artifical data, using the same
  tools you applied to the other data sets in lab.

  1. Consider the synthetic data you've just created and determine the
average number of spikes per trial, the average firing rate, the average ISI,
and the Fano factor.
  2. How do you know that these synthetic data are Poisson?
  3. Compute and plot the SNH, ISI histogram, and PSTH and indicate the
average value of each measure on each plot.
  4. Describe briefly in words how the activity in "data" behaves.  
