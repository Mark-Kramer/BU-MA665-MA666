## Readings

(pdf) [Abbott, Brain Res Bull (1999) vol. 50 (5-6) pp. 303-4.](/Readings/Abbott_1999.pdf)

(pdf) [Chapter 8, pages 267-269 @ E. Izhikevich, Dynamical Systems in Neuroscience, 2007.](/Readings/Izhikevich_Chapter_8.pdf)

(pdf)	[Chapter 1, pages 5-12 @ C. Koch, Biophysics of computation, 1998.](/Readings/Koch_Chapter_1.pdf)

## Videos

(lec) [IF Part 1](https://youtu.be/KFv45vFILbw)

(lec) [IF Part 2](https://youtu.be/irgfUILDLR0)

<!--  (lec) [M. Kramer, Introduction to the integrate and fire model (Neural Spike Train Analysis)](https://www.samsi.info/news-and-media/27-jul-drs-m-kramer-and-u-eden-samsi)

  Slides available as [PDF](/Readings/Kramer_Slides_SAMSI_Lecture_1.pdf). !-->

## Code

(pynb) Includes text, video, and code: [Integrate and Fire Model](https://mark-kramer.github.io/Case-Studies-Python/IF.html)

(py)   Function to run the [IF](IF.py) model.

## Discussion

1. Describe the main components of the IF model. Draw it (in some way).
2. Describe the main components of the LIF model. Draw it (in some way).
3. Describe the differences and similarities between the IF and LIF models.
4. The IF model is meant to mimic a neurons activity. Describe what is realistic about the IF model? What is unrealistic?
5. Describe the roles of the IF model parameters `Vreset` and `Vthreshold`.
6. Consider the IF model. Sketch voltage (V) versus time (t) for a small input current, for a large input current.
    1. How does an increase in capacitance (C) impact the dynamics?
    2. Can you interpret this physically?
7. Consider the LIF model. Sketch voltage (V) versus time (t) for a small input current, for a large input current.
    1. How does an increase in the resistance (R) impact the dynamics?
    2. How does an increase in the capacitance (C) impact the dynamics?

## Challenges

1. Consider the LIF model. Sketch voltage (V) versus time (t) for a small input current, for a large input current.
2. How does an increase in the resistance (R) impact the dynamics?
3. Determine how the firing rate of the IF model varies with input I. Plot the firing rate vs I (the “f-I curve”).
4. Determine how the firing rate of the LIF model varies with input I. Plot the firing rate vs I (the “f-I curve”).
5. Develop a simulation of the quadratic integrate and fire neuron: `C dV/dt = V^2+I`
6. Plot examples of the output of your model for different values of input I. Determine the f-I curve.
7. [ADVANCED] Simulate the Izhikevich neuron. Provide examples of two different types of spiking activity.

