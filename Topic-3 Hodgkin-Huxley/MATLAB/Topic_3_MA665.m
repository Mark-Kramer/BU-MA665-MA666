%%  MA665 - Topic 3:  The Hodgkin-Huxley equations and their simplification.
%   In this lab we will use MATLAB to simulate the Hodgkin-Huxley
%   neuron model.  This model is arguably the *most* important
%   computational model in neuroscience.  We'll focus today
%   on simulating this model and understanding its pieces.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Part 1:  The Hodgkin-Huxley (HH) equation code.
%   Download the MATLAB file (available on Blackboard),
%
%   HH0.m
%
%IN LAB Q:  Examine this code.  Can you make sense of it?  Can you identify the
%gating variables?  The rate functions?  The equations that define the dynamics?
%We'll try to do all of this in lab.

%   Whenever examining code, it's useful to consider the *inputs* to the
%   code, and the *outputs* produced by the code.  There are two INPUTS to
%   HH0:
%
%    I0 = the current we inject to the neuron.
%    T0 = the total time of the simulation in [ms].
%
%   And there are five OUTPUTS:
%
%    V = the voltage of neuron.
%    m = activation variable for Na-current.
%    h = inactivation variable for Na-current.
%    n = activation variable for K-current.
%    t = the time axis of the simulation (useful for plotting).

%%  Part 2:  At low I0, examine the HH dynamics.  %%%%%%%%
%   To understand how the HH model works, we'll start by focusing on the
%   case when I0 is small. Let's fix the input current to zero,

I0 = 0;

%   and let's simulate the model for 100 ms,

T0 = 100;

%   We've now defined both inputs to the "HH" function, and can execute it,
%   as follows,

[V,m,h,n,t] = HH0(I0,T0);

%   Notice that the function returns five outputs, which we assign to the
%   variables 'V', 'm', 'h', 'n', and 't'.

%IN LAB Q:  What are the dynamics of the voltage (variable V) resulting
%from this simulation?  HINT:  Plot V vs t.

%IN LAB Q:  What are the dynamics of the gating variables (m, h, n)
%resulting from this simulation?  HINT:  Plot them!

%IN LAB Q:  What are the final values (after the 100 ms of simulation) of
%V, m, h, and n ?

%CONCLUSION:  At this value of input current (I0=0), the model dynamics
%approach a "fixed point", whose location we can identify as a point in 
%four dimensional space.

%%  Part 3:  At high I0, examine the HH dynamics of a spike.  %%%%%%%%%%
%   Let's now increase the input current to the HH model and get this model
%   to generate repeated spiking activity.  To do so, let's set,

I0 = 10;

%   We can now simulate this model,

[V,m,h,n,t] = HH0(I0,T0);

%IN LAB Q:  What happens to the dynamics?  HINT:  Plot V vs t.

%   You should have found that, at this value of input current, the model
%   generates repeated spikes.  Let's now explore how the combined gates
%   and dynamics evolve.  To do so, let's start by focusing our plot on a
%   single spike.  As a first step, we'll make a seperate subfigure to plot
%   the voltage,

subplot(2,1,1)

%   This "subplot" command divides the figure window into two rows, and one
%   column, and tells MATLAB we'll start in the first row.  See MATLAB Help
%   for more details.

%   Now, let's plot the voltage, and choose the time axis to focus on a
%   single spike,

plot(t,V,'k')
xlim([42 56])
ylabel('V [mV]')

%   Okay, we've now plotted the voltage dynamics for a single spike (and
%   colored the curve black).  Let's now plot the three gating variables.
%   To do so, we'll move to the next subplot,

subplot(2,1,2)

%   (the next row in the figure).  Within this subplot, let's start by
%   displaying the gating variable 'm' over the same x-limits,

plot(t,m,'r')
xlim([42 56])

%   Within this subplot, we can also simultaneously show the gating
%   variables 'h' and 'n'.  To do so, we first freeze the plot,

hold on

%   This tells MATLAB not to erase anything in the current graphics window.
%   Now, let's plot the other two gating variables,

plot(t,h,'b')
plot(t,n,'g')

%   Finally, we stop holding the plot,

hold off

%   Label the x-axis,

xlabel(['Time [ms]'])

%   And add a legend

legend('m', 'h', 'n')

%IN LAB Q:  Using the figure above describe how the gates swing open and
%closed during a spike.

%ASIDE:  Here's a nice plotting trick, to link the x-axes of our two
%subfigures.  Linking the axes is useful so that, when we zoom or move one
%subfigure, the other subfigure will match the x-axis.

ax(1) = subplot(2,1,1);
ax(2) = subplot(2,1,2);
linkaxes([ax(2) ax(1)], 'x')

%%  Part 4:  At high I0, describe the dynamics of the conductances.  %%%%%%
%   In Part 3, we explored how the three gates 'm', 'h', and 'n' evolve
%   during a spike.  By combining these terms, we can visualize how the
%   *conductances* evolve during a spike.  To do so, let's stick with the
%   simulation results we generated in Part 3, and focus our plot on a
%   single spike,

subplot(3,1,1)                  %Make a subplot,
plot(t,V,'k')                   %... and plot the voltage,
xlim([42 56])                   %... focused on a single spike,
ylabel('V [mV]')                %... with y-axis labeled.

%  Now, to plot the conductances, let's define three new variables,

gNa0 = 120;
gNa = gNa0*m.^3.*h;
gK0  = 36;
gK  = gK0*n.^4;
gL0  = 0.3;
gL  = gL0;

%IN LAB Q:  Where do these terms come from?

%  Finally, let's plot these conductances,

subplot(3,1,2)                  %Make a second subplot,
plot(t,gNa,'m')                 %... and plot the sodium conductance,
hold on                         %... hold the graphics window,
plot(t,gK, 'g')                 %... and plot the potassium conductance,
plot(t,gL, 'k')                 %... and plot the leak conductance.
hold off                        %... release the graphics window,
xlim([42 56])                   %... focus on a single spike,
xlabel('Time [ms]')             %... label the x-axis.
ylabel('mS/cm^2')               %... and label the y-axis.
legend('gNa', 'gK', 'gL')       %... make a legend.

%IN LAB Q:  How do the conductances evolve during a spike?

%%  Part 5:  At high I0, describe the dynamics of the *currents*.  %%%%%%
%   In Part 4, we explored how the three conductances (gNa, gK, gL) evolve
%   during a spike.  Let's now visualize how the *ionic currents* evolve
%   during a spike.  To do so, let's stick with the same setting of
%   Part 4 and use the same simulation result.  Again, we'll focus our plot
%   on a single spike,

%  Now, to plot the *current*, let's define the new variables,
gNa0 = 120;  ENa=115;
INa = gNa0*m.^3.*h.*(ENa-(V+65));
gK0 = 36;  EK=-12;
IK  = gK0*n.^4.*(EK-(V+65));
gL0 = 0.3;  EL=10.6;
IL  = gL0*(EL-(V+65));

subplot(3,1,3)                  %Make a third subplot,
plot(t,INa,'m')                 %... and plot the sodium current,
hold on                         %... hold the graphics window,
plot(t,IK, 'g')                 %... and plot the potassium current,
plot(t,IL, 'k')                 %... and plot the leak current.
hold off                        %... release the graphics window,
xlim([42 56])                   %... focus on a single spike,
xlabel('Time [ms]')             %... label the x-axis.
ylabel('mA/cm^2')               %... and label the y-axis.
legend('INa', 'IK', 'IL')       %... make a legend.

%IN LAB Q:  How do the conductances evolve during a spike?

%ASIDE:  Here's a nice plotting trick, to link the x-axes of our three
%subfigures.  Linking the axes is useful so that, when we zoom or move one
%subfigure, the other subfigure will match the x-axis.

ax(1) = subplot(3,1,1);
ax(2) = subplot(3,1,2);
ax(3) = subplot(3,1,3);
linkaxes([ax(3) ax(2) ax(1)], 'x')