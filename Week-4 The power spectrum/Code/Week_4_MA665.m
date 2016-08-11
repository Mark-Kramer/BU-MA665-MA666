%%  MA665 - Week 4:  Analysis of rhythmic data
%   In this lab we will develop our analysis of rhythmic activity in
%   field data.  We'll focus on some practical notions of spectral
%   analysis, including the frequency resolution, Nyquist frequency,
%   and aliasing.  We'll also apply these ideas to brain data.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Part 1.  Using "fft" to compute the Fourier transform.
%   We'll begin by examing the built-in the MATLAB function "fft".
%   Let's start by generating some data, whose
%   power spectrum we know, or at least have a good guess for how the power
%   spectrum should behave.  First, we'll define a time axis,

t = (0.001:0.001:2);

% Q:  What type of MATLAB object is "t"?  When does time start?  When
%does time end?  What is the sampling interval (i.e., the time between
%samples)?

%   Now, let's define a new variable that represents a sinusoid,

x = sin(2*pi*t*10);

% Q:  What is the frequency of this sinusoid?

%   Then, compute the "fft" of x,

xf = fft(x);

plot(xf);  xlim([-1000 1000]);  ylim([-1000 1000])

%   The function "fft" computes the "fast Fourier transform" of the input
%   x.  In essence, this operation compares sinusoids of different
%   frequency to x, and returns large amplitudes for those sinusoids that
%   match x.

% Q:  What are the dimensions of the result?  Examine "xf".  What do
%you find?

%   We can then compute the *power* using the formula in Kramer & Eden, 
%   Chapter 3 ... let's compute the power of x, and store our answer in a
%   variable called "Sxx". 

%%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt = t(2)-t(1);                     %Define the sampling interval.
T  = t(end);                        %Define the total time.
Sxx = 2*dt^2/T * (xf.*conj(xf));    %Compute the power spectrum.
plot(Sxx)                           %Plot it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Q:  What are the dimenisons of "Sxx"?  What values do
% you observe in "Sxx"?  Does the result make sense?  NOTE:  Do not worry
% about the frequency axis, for now ...

% Q:  Vary the amplitude of the data x and re-compute the power of x.  
%What values do you observe in the power?  Does the result make sense?

%%  Part 2.  Define the frequency axis.
%   We discussed in in Kramer & Eden, Chapter 3 that the frequency axis corresponding to the
%   power spectrum ("Sxx" in Part 1) is stored in a particular way.  Remember
%   that, to define the frequency axis, we need two important quantities:
%
%   fNQ = the Nyquist frequency,
%   df  = the frequency resolution.
%
%   Our goal in this part of the lab is to define these quantities, and
%   create the appropriate frequency axis for these data.

% Q:  Define the frequency axis corresponding to the variable "Sxx"
% produced in Part 1.  Call this variable "faxis".  Plot the result of Sxx
% versus faxis.  Does the resulting plot make sense?  This plot is the POWER
% SPECTRUM.  NOTE: For this example, plot both the postive and negative
% frequencies.

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt = t(2)-t(1);                     %Define the sampling interval.
T  = t(end);                        %Define the total time.
Sxx = 2*dt^2/T * (xf.*conj(xf));    %Compute the power spectrum.
df  = 1/T;                          %Define the frequency resolution.
fNQ = 1/dt/2;                       %Define the Nyquist frequency.
                                    %Now, define the frequency axis,
faxis = [(0:df:fNQ), (-fNQ+df:df:-df)];  %... here for both pos and neg freq!
plot(faxis, Sxx)                %Plot the power versus frequency.
%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Q: Consider a *cosine* function, instead of sine, at the same
% frequency as x.  How does the power spectrum of the *cosine* function compare
% to the power spectrum of the *sine* function?

%NOTE:  The plot of power ("Sxx") versus frequency ("faxis") has a
%bothersome issue.  Because the frequency axis is out of order (we define
%first the increasing positive frequencies, then the decreasing negative
%frequencies) our plot includes a nearly horizontal line, connecting the
%power at Nyquist frequency (at the far right of our figure) to the power
%at negative Nyquist frequency (at the far left of our figure). To modify
%this, we can simply plot *only* the non-negative components of the power
%spectrum.

% Q:  Update your code to plot only the non-negative components of
%the power spectrum.  Be careful to update your frequency axis ("faxis") to
%match your modified Sxx variable!

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
df  = 1/T;                          %Define the frequency resolution.
fNQ = 1/dt/2;                       %Define the Nyquist frequency.
faxis = (0:df:fNQ);                 %Now, define the frequency axis,
Sxx = 2*dt^2/T * (xf.*conj(xf));    %Compute the power spectrum.
Sxx = Sxx(1:length(Sxx)/2+1);       %... and keep only power at pos freq.
plot(faxis, Sxx)                    %Plot the power versus frequency,
xlabel('Frequency (Hz)');           %... and label the axes.
ylabel('Power');
%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Part 3.  Aliasing.
%   In Parts 1 and 2 we examined a sinusoid at a fixed frequency (10 Hz).
%   Let's now use the analysis we've developed to examine sinusoids at
%   different frequenies.  To do so, we'll construct these sinusoids, and
%   then compute the power spectrum.

% Q.  Please increase the frequency of the sinusoid "x" (defined in 
% Part 1) and compute the power spectrum for this new sinusoid.  Repeat this
% procedure for sinusoids of larger and larger frequency.  Do you ever observe
% "strange effects"? If so, at what frequency does this behavior occur?
% Why does this strange behavior occur.

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create the data.
f  = 100;                           %Define the frequency of the sinusoid,
t  = (0.001:0.001:2);               %... and the time axis,
x  = cos(2*pi*t*f);                 %... and create the sinusoid.

%Define the power spectrum.
dt = t(2)-t(1);                     %We need the sampling interval,
T  = t(end);                        %... and the total time of recording.
xf = fft(x);                        %Compute the Fourier transform,
Sxx = 2*dt^2/T * (xf.*conj(xf));    %... and then the power spectrum,
Sxx = Sxx(1:length(Sxx)/2+1);       %... and keep only power at pos freq.

%Define the frequency axis.
df  = 1/T;                          %Define the frequency resolution.
fNQ = 1/dt/2;                       %Define the Nyquist frequency.
faxis = (0:df:fNQ);                 %Now, define the frequency axis,

%Plot the results.
plot(faxis, Sxx)                    %Plot the power versus frequency,
xlabel('Frequency (Hz)');           %... and label the axes.
ylabel('Power');
%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Part 4.  Aliasing (Part 2).
%   We can also illustrate the phenomenona of aliasing more directly, by
%   considering a simulation experiment.  To do so, let's first define a
%   "true signal" which we'll sample at a very high rate.

fs = 12;                    %The "true signal" frequency.
Fs = 10000;                 %... we'll create the true signal high temporal resolution.
t = (0:1/Fs:1);          
x = cos(2.0*pi*t*fs);

%   Now, let's plot "samples" of this true signal using different sampling
%   frequency f0.

f0 = 13;
plot(t,x, 'k', 'LineWidth', 4)
hold on
plot(t(1:Fs/f0:end), x(1:Fs/f0:end), '-go', 'MarkerFaceColor', 'g')
hold off

% Q: Adjust the sampling frequency f0.  How does the sampled signal
% compare to the true signal as f0 is decreased?


%%  Part 5.  Compute the power spectrum of data.
%   In the last section of this lab, we'll load in example data, and apply
%   the methods we've developed above to compute the power spectrum.  Let's
%   start by downloading a data set from the course website,
%
%   https://github.com/Mark-Kramer/Case-Studies-Kramer-Eden/blob/master/Chapter3/Ch3-EEG-2.mat
%
%   Please load these data into MATLAB, compute the power spectrum, and
%   plot it.  Remember, when plotting the power spectrum, to label your
%   axes appropriately.  Below you'll find code to complete each step of
%   this process. Be sure you understand what's happening in each part!

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('Ch3-EEG-2')
%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%


%   i)  Define two important quantities from the data: the sampling
%   interval (dt) and the total duration of the recording (T).  Use these
%   quantities to define the Nyquist frequency and the frequency
%   resolution.

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt = t(2)-t(1);                     %Define the sampling interval,
T  = t(end);                        %Define the total time of recording.
df  = 1/T;                          %Define the frequency resolution.
fNQ = 1/dt/2;                       %Define the Nyquist frequency.
faxis = (0:df:fNQ);                 %Define the frequency axis.
%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   ii)  Compute the power spectrum of the data?

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

x  = EEG;                                   %For convenience, call the data "x".
xf = fft(x);                                %Compute fft of rect. taper data.
Sxx = 2*dt^2/T*(xf.*conj(xf));              %Compute power of rect. taper data.
Sxx = Sxx(1:length(Sxx)/2+1);               %Keep pos. freqs.
%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   iii)  Plot the power spectrum.  Will you plot the power in decibels, or
%   not?

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure

%Plot the power spectrum on a linear scale.
plot(faxis, Sxx)
xlabel('Freq [Hz]')
ylabel('Power')

%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   iv)  Interpret the results.  What rhythms are present in your data?  Do
%   these rhythms match you visual inspection, or intution for these data?