%%  MA665 - Topic 4: EEG and ERPs
%   This tutorial follows closely the Chapter 2 of "Case Studies in Neural Data
%   Analysis". Our goal is to continue using MATLAB, and explore analysis
%   methods for ERP data.  We will consider an example of the Central
%   Limit Theorem, and how we can perform a bootstrap procedure to
%   construct error bars for trial based EEG data.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Part 1. Loading the EEG data, identifying basic quantites, and visualization.
%
%   Our first objective is to load the data.  Please download the data from
%   here,
%
%   https://github.com/Mark-Kramer/Case-Studies-Kramer-Eden/blob/master/Chapter2/Ch2-EEG-1.mat
%
%   The MATLAB file contains EEG data collected by our collaborator during a
%   trial based experiment.  In this experiment, the same stimulus was
%   applied in multiple trials, and the brain response observed.  Let's load
%   these data in MATLAB, and see what we find,

load('Ch2-EEG-1.mat')

%IN LAB Q:  What do you observe?  What are some important features of the
%data?

%   Our collaborator informs us that these data consist of 1000 trials.
%   Each trial consists of 1 second of EEG data, sampled 500 times per second
%   (i.e., the sampling frequency is 500 Hz).  In this case, we are
%   provided with two experiments, which record the evoked EEG under two
%   conditions.  In both cases, the stimulus is delivered at time 0.25 s.

%   To get a sense for how the data behave, let's examine the data from a
%   single trial of one data set ("EEGa"). A useful way to do so is
%   to *plot* the data.

%IN LAB Q:  Plot the data from the first trial of EEGa.  What do you find?
%Be sure to plot the data as a function of *time*, and label the axes.
%HINT:  What does the variable "t" indicate?

%   For our analysis of these EEG data, we can define variables that will be
%   useful later on.  Let's start by defining the number of trials,
%
%   >> ntrials = ??? 

%IN LAB Q:  How do we define "ntrials"?

%%  Part 2:  The ERP.
%
%   The EEG data were recorded during presentation of a stimulus.  Our
%   collaborator has put forward the hypothesis that the brain responds
%   - in some way - to the stimulus.  Can we identify any features of a 
%   response in the EEG data?
%
%IN LAB Q:  Consider the single trial data for EEGa.  By plotting single
%trials, do you observe a "response", following the stimulus?

%   So far, we have focused on plots of individual trials.  That's fine, and
%   often extremley useful.  However, we may also benefit for examining all
%   of the data at once.  Fortunately, there's a simple way to do so in
%   MATLAB.  Consider the following command,

imagesc(EEGa)

%IN LAB Q:  What is the x-axis?  What is the y-axis?  What is the z-axis?

%IN LAB Q:  Using the results of the "imagesc" command, do you observe an
%"evoked response" in the EEG data?

%   Our conclusions from the single trial observations are not encouraging.
%   It may be that the brain resposne to the stimulus is present, but weak,
%   and hidden by other co-occurring signals in the brain.  To emphasize
%   these weak signals - that appear consistently with each presentation
%   of the stimulus - we may *average* the EEG data across trials.

%IN LAB Q:  How do we average the EEG data across trials in MATLAB?  Do so,
%and plot the results versus time.  This is the *evoke response potential* or
%ERP.  Examine the ERP, and report what you find.  Do you now observe an
%evoked response?  If so, what is it?  How did we "tease out" this evoked
%response?

%%  Part 3:  An aside - the normal distribution.
%
%   We discussed in class the normal distribution.  You've probably heard
%   of it before, since it appears in many contexts (e.g., human height).
%   It's easy to generate in MATLAB random numbers that follow a normal
%   distribution:

N = 10+randn(1,500);

%   The above generates a vector with 500 random numbers drawn from a
%   normal distribution with mean 10 and standard deviation of 1.

%IN LAB Q:  Compute the mean of N.  What do you find?

%IN LAB Q:  Compute the standard deviation of N.  What do you find?

%IN LAB Q:  Visualize N.  Does it look "normal"?  HINT:  Plot a histogram.

%   A nice features of normal distrubitions is that 95% of the values tend
%   to lie within 2 standard deviations of the mean.  Let's check this in
%   MATLAB . . . consider the following snippet of code:

length(find(N > mean(N)-2*std(N) & N < mean(N)+2*std(N)))/length(N)

%IN LAB Q:  What's happening in the line of code above?  HINT:  Consider
%each piece of the statement separately, and use MATLAB Help to look up
%functions you don't known.  What is the output of this line of code?

%CONCLUSION:  In this case, for a normal distribution with mean 10 and
%standard deviation 1, we expect 95% of the numbers we draw from this
%distribution to lie in the interval [8, 12].

%%  Part 4: Confidence bounds for the ERP.
%
%   In Part 2, we computed the ERP.  However, in our initial plot of the ERP,
%   we have not included any sense of variability in the measure;  the ERP
%   only indicates the mean across trials of the EEG.  How confident are we
%   in the estimates of the mean at each time?  We'll address this in two ways.
%   First, in this Part of the lab, we'll use the central limit theorem (CLT)
%   to create a confidence interval for our ERP.  We stated the CLT in class,
%   and we can restate it informally here:
%
%   "The mean of a bunch of random things is approximately normally
%   distributed."
%
%IN LAB Q:  How is the ERP the "mean of a bunch of things"?

%   Using the CLT, it's easy to construct confidence intervals for the ERP
%   in MATLAB. Let's do so now.  First, we compute the ERP:

ERP = mean(EEGa,1);

%   Note that the ERP is the *mean* of the EEG traces across trials.  Now,
%   we compute the standard deviation of the mean.

%IN LAB Q:  How do we compute the SDOM?  HINT:  See your lecture notes, or
%the Chapter 2 handout.

%   Now, we're ready to plot the ERP with confidence intervals.  For a
%   normal variable, the 95% confidence interval ranges from:
%
%   [mean - 2*SDOM, mean + 2*SDOM]
%
%   So, to plot the ERP and the 95% confidence interval (computed using the
%   CLT at each point in time), we execute the following,

ERP = mean(EEGa,1);           %Compute the mean EEG across trials (the ERP).
plot(t, ERP, 'LineWidth', 2)  %Plot the ERP of condition A, make the line thick.
hold on
plot(t, ERP+2*sdom);          %Plot the upper confidence interval.
plot(t, ERP-2*sdom);          %Plot the lower confidence interval.
hold off
xlabel('Time [s]')           %Label the x-axis as time.
ylabel('Voltage [\mu V]')    %Label the y-axis as voltage.
title('ERP of condition A')  %Provide a useful title.

%   Note that the snippet of code above requires that we first define the
%   variable "sdom" = the standard deviation of the mean.

%   You'll observe in this case that the ERP data initially fluctuates
%   around a value of 0.  Notice that the ERP is near zero and the
%   confidence intervals include 0.  Between approximately [0.3 - 0.5]s, the
%   ERP fluctuates away from zero;  notice that, in these
%   intervals, the confidence intervals around the ERP do *not* include 0.
%   This result provides evidence that an ERP appears in the data;
%   following the stimulation at 0.25 s, the ERP fluctuates away from 0. 

%%  Part 5: Computing confidence intervals for the ERP - the bootstrap.
%
%   In Part 4, we used the CLT to create 95% confidence intervals for the
%   ERP.  To do so, we made some (reasonable) assumptions about the data.
%   In this part of the lab, we'll compute 95% confidence intervals for the
%   ERP in another way - using a bootstrap.  The bootstrap is a very
%   powerful procedure with many applications.  We'll explore one concrete
%   application here.

%   We discussed the idea of a bootstrap in class.  Let's implement these steps
%   here, using a simple example.  We'll start by focusing on a
%   single point in time, and use the bootstrap procedure to estimate 95%
%   confidence intervals for this single point in time.
%
%   Let's grab a single point in time from the EEG, and call it "x",

x = EEGa(:,300);

%   This moment in time corresponds to time

t(300)

%   in the data.  You'll see that x is a list of numbers; namely a list of
%   1000 numbers, corresponding to the 1000 trials observed at the time index
%   300.  It's easy to compute the mean of x,

mn = mean(x);

%   Now, we'll create a 95% confidence interval for the mean of x.  To do
%   so, we'll implement a bootstrap procedure.  We outlined this procedure
%   in class, and we'll now implement it here,

%   Step 1:  Draw a bootstrap sample of the data.
%
%   To draw the bootstrap sample, we "sample with replacement" from the
%   data x.  What this means - in practice - is that we pick values at
%   random from the vector x.  Conceptually, we can think of a sack with
%   1000 marbles.  We paint on each marble "i" the value of x(i).  Then, we
%   draw a marble from the sack and read off the number painted on it.  We
%   replace this marble in the sack, and draw again.  Repeating this
%   procedure 1000 times, we create a new vector.  It's easy to perform this
%   "sampling with replacement" in MATLAB.  The first step is to create a
%   vector that represents our 1000 samples,

i = randsample(ntrials,ntrials,1);

%IN LAB Q:  Examine the variable i.  What is it?
%
%IN LAB A:  "i" is a vector with 500 entries.  Each value of "i" indicates
%an index i that we'll draw from x.  Examine the first 10 entries of "i" and
%see what you find.  With these indices - which represent our random
%samples of the data, we're now ready to draw our bootstrap sample,

s = x(i);

%IN LAB Q:  Examine s.  What values do you find?

%   Step 2:  Compute the quantity of interest from the bootstrap sample.
%
%   The vector 's' represents one bootstrap sample of the data.  Rememeber,
%   we're interested in the mean of the data, and creating its 95%
%   confidence interval.  To that end, let's compute the mean of s,

mnB = mean(s);

%IN LAB Q:  Compare the mean of the bootstrap ("mnB") to the mean of the data
%("mn").  Are the two values the same, or different?

%   Step 3:  Repeat steps 1 and 2 many times, and examine the distribution
%   of values you find.
%
%   To repeat the steps above 5000 times, we'll use a for-loop,

B=5000;
for b=1:B
    i = randsample(ntrials,ntrials,1);
    s = x(i);
    mnB(b) = mean(s);
end

%   We can think of Step 3 as "performing new experiments" or "performing
%   new measurements" from the data we've already collected.  We're drawing
%   observations from the original data in new ways, and using this to
%   recompute the measure of interest - the mean of the vector x - and
%   saving this result (here in the variable "mnB").  Finally
%   to create the 95% confidence interval of x, we identify the interval that
%   contains 95% of the values in "mnB".  To do so in MATLAB, it's useful
%   to first sort the values in mnB,

sorted_mnB = sort(mnB);

%   We can visualize these sorted values by plotting them,

plot(sorted_mnB)

%IN LAB Q:  What is plotted on the x-axis?  The y-axis?

%   From this sorted vector, we may now determine the 95% confidence
%   intervals.  To do so, we'll determine the threshold below which 2.5% of
%   the "mnB" values reside, and the threshold above which 97.5% of the values
%   of "mnB" reside.

ciL  =sorted_mnB(0.025*B);  %Determine the lower confidence interval.
ciU  =sorted_mnB(0.975*B);  %Determine the upper confidence interval.

%   This establishes the 95% confidence interval for a single instant in
%   time (here we chose the index i=300).  We find:
%
%   Mean   =  -0.0633
%   95% CI = [-0.144,  0.036]

%%  Part 6:  Applying the bootstrap to the ERP.
%   The example above focused on only a single point in time.  We can use
%   the same procedure to construct the 95% confidence interval for the
%   entire ERP, over all time.  Let's implement that procedure now.  The
%   main difference with the example in Part 5 is that we will now work
%   with the entire EEG data matrix.

%   We'll begin by reviewing the steps to compute a single bootstrap
%   sample, and then apply this procedure for multiple bootstrap samples.

%   Step 1:  Draw a bootstrap sample of the data.
%
%   To start, we'll again create a vector of indices that represents 
%   a random selection of the 500 trials,

i = randsample(ntrials,ntrials,1);

%   Now, let's create a bootstrap sample of the EEG data using these trials.
%   In this case, each index "i" corresponds to a trial of the EEG data.
%   We'll use these  indices to create a new realization of the 500 trials
%   of the EEG data. This is easy to do in MATLAB,

EEG0 = EEGa(i,:);

%IN LAB Q:  What are the dimensions of EEG0?  How does EEG0 represent a
%bootstrap sample of the origninal EEG data?

%   Step 2:  Compute the quantity of interest from the bootstrap sample.
%
%   In this case, we're interested in the ERP, which is the average of the
%   data across trials.  So, we need to compute the ERP for the new
%   realization of the data "EEG0",

ERP0 = mean(EEG0,1);

%IN LAB Q:  Plot the new realization of the bootstrapped ERP.  How does it
%compare to the original ERP?

%   Step 3:  Repeat steps 1 and 2 many times, and examine the distribution
%   of values you find.
%
%   To repeat the steps above, we'll use a for-loop,

B=2000;
ERPB = zeros(B,500);
for b=1:B
    i = randsample(ntrials,ntrials,1);
    EEG0 = EEGa(i,:);
    ERPB(b,:) = mean(EEG0,1);
end

%   Now, we can use these bootstrap realizations to compute the 95%
%   confidence intervals for the EEG.  To do so,

sERPB=sort(ERPB);            %Sort each column of the resampled ERP.
ciL  =sERPB(0.025*B,:);      %Determine the lower confidence interval.
ciU  =sERPB(0.975*B,:);      %Determine the upper confidence interval.

%   Finally, we can plot the observed ERP and the 95% confidence intervals.

ERP = mean(EEGa,1);          %Compute the mean EEG across trials (the ERP).
plot(t, ERP, 'LineWidth', 3) %Plot the ERP
hold on
plot(t, ciU);                %Plot the upper confidence interval.
plot(t, ciL);                %Plot the lower confidence interval.
hold off
xlabel('Time [s]')           %Label the x-axis as time.
ylabel('Voltage [\mu V]')    %Label the y-axis as voltage.
title('ERP of condition A (Bootstrap)')  %Provide a useful title.

%   You'll find here results similar to Part 4.  Following stimulation at
%   t=0.25 s, an evoked response appears - the ERP fluctuates above and
%   below 0.  Importantly, notice that the confidence intervals in this
%   interval do *not* include 0 (except transiently, as the data
%   transitions from postive to negative, or vice versa).
