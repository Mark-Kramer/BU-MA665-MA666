%%  MA665 - Week 2:  The integrate and fire neuron
%   In this Lab we will use MATLAB to simulate the integrate and fire
%   (I&F) neuron model.  We'll investigate, in particular, how the spiking
%   activity varies as we adjust the input current I.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Part 1:  Numerical solutions - Introduction
%   How do we compute a numerical solution to the integrate and fire model?
%   The basic idea is to rearrange the differential equation to get V(t+1) on
%   the left hand side, and V(t) on the right hand side.  Then, if we know
%   what's happening at time t, we can solve for what's happening at time t+1.
%   For example, consider the differential equation:
%
%   dV/dt = I/C   [***]
%
%   In words, we can represent:
%
%   "dV" as the "change in voltage V",
%
%   "dt" as the "change in time t".
%
%   Let's consider the case that we record V in discrete time steps. So
%   we observe:
%
%   V(1), V(2), V(3), ...
%
%   at times:
%
%   dt, 2*dt,  3*dt, ...
%
%   where "dt" is the time between our samples of V.
%
%   We can now write the "change in voltage V" as:
%
%   dV = V(t+1) - V(t)
%
%   Notice that the change in voltage is the difference in V between two
%   time samples.  Now, let's rewrite dV/dt as,
%
%   dV/dt = ( V(t+1) - V(t) ) / dt
%
%   where we've replaced dV.  Now, let's substitute  this expression into
%   Equation [***],
%
%   ( V(t+1) - V(t) ) / dt = I/C.
%
%   Solving this equation for V(t+1) you'll find  that:
%
%   V(t+1) = V(t) + dt*(I/C)
%
%   Now, let's program this equation in MATLAB.  First, let's set the values
%   for the parameters I and C.

C=1;
I=1;

  We also need to set the value for dt.  This defines the time step in the
  problem.  We must choose it small enough so that we don't miss anything
  interesting.  We'll choose:

dt=0.01;

%   Let's assume the units of time are seconds.  So, we step forward in
%   time by 0.01s.  The right hand side of our equation is nearly defined,
%   but we're still missing one thing, V(t).

%Q:  What value do we assign to V(t)?
%A:  We don't know --- that's why we're running the simulation in the first
%place!

%   So here's an easier question:  what *initial* value do we assign to
%   V(t)?  Let's choose a value of 0.2, which in our simple model we'll
%   assume represents the rest state.  Then set:

V(1)=0.2;

%Q:  Given the initial state V(1)=0.2, calculate V(2).  Then calcualte V(3).

  After the two calculations above, we've moved forward two time steps into
  the future, from t=0s to t=0.01s, and then from t=0.01s to t=0.02s.  But what
  if we want to know V at t=10s?  Then, this iteration-by-hand procedure becomes
  much too boring and error-prone.  So, what do we do?  Make the
  computer do it . . . 

%%  Part 2:  Numerical solutions - implementation
%   Let's computerize this iteration-by-hand procedure to find V(1000).
%   To do so, we'll use a "for-loop".  Here's what it looks like:

for k=1:999
    V(k+1) = V(k) + dt*(I/C);
end

%Q:  Does this loop make sense?  Describe what's happening here.  Use
%MATLAB Help if you don't remember the "for" command.

%Q:  Why do we end the loop at k=999?

%   Execute this for-loop and examine the results in vector V.  To do so,
%   let's plot V:

figure(10)
plot(V)

%Q:  What happens to the voltage after 1000 steps?
% 
%   This plot is informative, but not great.  Really, we'd like to plot the
%   voltage as a function of *time*, not steps or indices.  To do so, we
%   need to define a time axis:

t = (1:length(V))*dt;

%Q:  What's happening in the command above?  Does it make sense?  (If not,
%trying printing t at the command line, or plot(t).)

%   Now, with "time" defined let's redo the plot of the voltage with
%   the axes labeled appropriately.

figure(10)
plot(t,V)
xlabel('Time [s]');  ylabel('V');

%   Finally, let's put it all together . . .

%%  Part 3:  I&F CODE (version 1)
  In Parts 1 and 2, we constructed parts of the I&F model in bits-and-pieces.
  Let's now collect all of this code, compute a numerical solution to
  the I&F model, and plot the results (with appropriate axes).

clear                   %Q:  What is this?  See MATLAB Help.

I=1;                    %Set the parameter I.
C=1;                    %Set the parameter C.
dt=0.01;                %Set the timestep.
V(1)=0.2;               %Set the initial condition.

for k=1:1000-1          %Compute V, step-by-step.
    V(k+1) = V(k) + dt*I/C;
end

t = (1:1000)*dt;        %Define the time axis.

figure(10)              %Plot the results.
clf()                   %Q:  What is this?  See MATLAB Help.
plot(t,V)
xlabel('Time [s]');  ylabel('Voltage [mV]');

%Q:  Adjust the parameter I.  What happens to V(t) if I=0?  Can you set I
%so that V > 20 within 10 s?

%%  Part 4:  Voltage threshold
%   Notice, our model is missing something important:  the reset.  Without
%   the reset, the voltage increases forever (if I>0). Now, let's update
%   our model to include the reset.  To do so, we'll need to add two things
%   to our code.  First, we'll define the voltage threshold "Vth", and
%   reset voltage "Vreset". Second, we'll check to see if V exceeds
%   Vth using an "if-statement";  if it does, then we'll set V equal to
%   Vreset.  Here's what we'll add to the code:

Vth = 1;  %Define the voltage threshold.
Vreset = 0;  %Define the reset voltage.

%   And update the for-loop as follows:
for k=1:1000-1
    V(k+1) = V(k) + dt*I/C;
    if V(k+1) > Vth, V(k+1)=Vreset; end  % <--- Here's something new!
end

%Q:  What's happening here?  What role does the "if-statement" play?
%Describe in words what happens when V(k+1) is greater than Vth.

%  Finally, here's the updated code:

%%  Part 5:  I&F CODE (version 2)

clear

Vth = 1.0;      % <--- Here's something new!
Vreset = 0.0;   % <--- Here's something new!
I=1;
C=1;
dt = 0.01;
V(1)=0.0;

for k=1:1000-1
    V(k+1) = V(k) + dt*I/C;
    if V(k+1) > Vth, V(k+1)=Vreset; end  % <--- Here's something new!
end

t = (1:1000)*dt;
plot(t,V);
xlabel('Time [s]');  ylabel('Voltage [mV]')

%Q:  Adjust the parameter I.  What happens to V(t) if I=10?  If
%I=100?f

