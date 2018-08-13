%%  MA665 - Week 5:  Coherence
%   In this lab we will review the power spectrum, develop our own code to
%   compute the coherence, and apply these measures to example simulated data.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Part 1:  Warm-up, Computing the power spectrum in 3 ways.
%   In Week 4, we discussed the discrete Fourier transform and power
%   spectrum.  Let's compute these quantities in three ways.  We'll begin
%   by writing out every step, and conclude using a built-in MATLAB
%   routine.

%   Let's begin by clearing the workspace.
clear

%  First, we'll create simulated data.
dt = 0.001;             %The sampling interval.
N = 1000;               %The number of time steps.
t = (0:N-1)*dt;         %Define a time axis.
T = N*dt;               %Define the total time of the simulation.

%  Then, create the data, a simple sinusoid + noise.
x = sin(2.0*pi*t*10) + randn(1,N);

%  Now, define the frequencies at which we'll evaluate the Fourier
%  transform.  We consider frequencies between the +/- Nyquist frequency
%  (the sampling frequency divided by two), in steps of 1/T = the frequency
%  resolution.  Here we arrange the frequencies following the MATLAB
%  convention.
fj = [(0:N/2-1)*(1/T), (-N/2:-1)*(1/T)];

%  For each freq compute the Fourier transform and save in "X".
X = zeros(1,length(fj));
n = (1:N);
for j=1:length(fj)
    X(j) = sum(x .* exp(-2*pi*1i*fj(j)*t));
end

%  Compute the power spectrum.
pow = 2*dt^2/T * (X.*conj(X));

%  And plot it on a decibel scale.
subplot(3,1,1)
plot(fj, 10*log10(pow), '*');
xlim([-20 20]);  ylim([-50 0])
xlabel('Freq [Hz]');  ylabel('Power')

%  Second, let's compute the Fourier transform using built-in MATLAB
%  routines.  Then, it's one step,
X = fft(x);

%  Re-compute the power spectrum.
pow = 2*dt^2/T * (X.*conj(X));

%  And plot it on a decibel scale.  Note that we'll use the same frequency
%  axis defined above.
subplot(3,1,2)
plot(fj, 10*log10(pow), '*');
xlim([-20 20]);  ylim([-50 0])
xlabel('Freq [Hz]');  ylabel('Power')

%  Third, use a built-in MATLAB routine to compute and plot spectrum.
subplot(3,1,3)
periodogram(x, [], N, 1/dt);
xlim([-20 20]);  ylim([-50 0])

%  All three measures should give the same result.  Confirm this.

%%  Part 2:  Compute the the squared coherence (by hand) between two signals.
%   In Chapter 5 of Kramer and Eden, we developed an expression for the
%   squared coherence.  Let's now write code to compute the squared coherence.
%   We'll work through the following code in lab, and make sure we understand it.

%   Again, let's begin by clearing the workspace.
clear

%   Let's define two signals.  Can you guess their coherence?
dt = 0.001;             %The sampling interval.
N = 1000;               %The number of time steps.
t = (0:N-1)*dt;         %Define a time axis.
T = N*dt;               %Define the total time of the simulation.
x = randn(1,N);         %Signal x, random noise.
y = randn(1,N);         %Signal y, random noise.

%   Let's also define the frequency axis.  We'll do so using slightly
%   different notation than above.  Note that, here, we've already shifted
%   the frequency axis so that the frequencies increase from negative to
%   positive,
df = 1/T;
fNQ = 1/dt/2;
faxis = (-fNQ:df:fNQ-df);

%  Compute the Fourier transform of x.
Xd = fft(x);

%  Compute the Fourier transform of y.
Yd = fft(y);

%  Compute the auto and cross spectra, and organize vectors by increasing frequency.
Sxx = 2*dt/N*(Xd.*conj(Xd));  Sxx = fftshift(Sxx);
Syy = 2*dt/N*(Yd.*conj(Yd));  Syy = fftshift(Syy);
Sxy = 2*dt/N*(Xd.*conj(Yd));  Sxy = fftshift(Sxy);

%  Compute the squared coherence.
cohr = Sxy.*conj(Sxy) ./ (Sxx.*Syy);

%  Plot the results.
subplot(5,1,1)
plot(t,x)
hold on
plot(t,y, 'g')
hold off
xlabel('Time [s]');  ylabel('Data')

subplot(5,1,2)
plot(faxis, Sxx);  ylabel('Abs(Sxx)^2');  xlim([-50,50])
subplot(5,1,3)
plot(faxis, Syy);  ylabel('Abs(Syy)^2');  xlim([-50,50])
subplot(5,1,4)
plot(faxis, Sxy.*conj(Sxy));  ylabel('Abs(Sxy)^2');  xlim([-50,50])
subplot(5,1,5)
plot(faxis, cohr)
xlabel('Freq [Hz]'); ylabel('Squared Coherence'); xlim([-50,50]); ylim([-0.1,1.1])

% Hmm . . . something odd happening here?  What is it?

