## Readings

Either: 
- (pdf)	[Chapter 2, pages 25-42 @ E. Izhikevich, Dynamical Systems in Neuroscience, 2007.](/Readings/Izhikevich_Chapter_2.pdf)
- or (pdf)	[Chapter 6, pages 142-159 @ C. Koch, Biophysics of computation, 1998.](/Readings/Koch_Chapter_6.pdf)

(pdf)	[Hodgkin-Huxley 1-page cheat sheet](/Readings/Hodgkin-Huxley_Cheat_Sheet.pdf)

(pdf)	Advanced: [Hodgkin and Huxley, J Physiol (Lond) (1952) vol. 117 (4) pp. 500-44.](/Readings/Hodgkin_Huxley_1952.pdf)

## Videos

(lec) [HH Part 1](https://youtu.be/yQvw8v8zyPA)

(lec) [HH Part 2](https://youtu.be/kEtqK6oKWvQ)

(lec) [HH Part 3](https://youtu.be/wLlRKc9HMjg)

<!-- (lec) [M. Kramer, Introduction to the Hodgkin-Huxley neuron (Neural Spike Train Analysis 5)](https://www.samsi.info/news-and-media/27-jul-drs-m-kramer-and-u-eden-samsi/)

- NOTE: The slides for this lecture are available as [PDF](/Readings/Kramer_Slides_SAMSI_Lecture_2.pdf). !-->

## Code

(pynb)  Includes text, video, and code: [The Hodgkin-Huxley Model](https://mark-kramer.github.io/Case-Studies-Python/HH.html)

## Discussion

1. How is the HH model different from / similar to the IF and LIF models?
2. What are the ion species simulated in the HH model?
3. Which ion species is fastest / slowest?
4. How many variables are in the HH model? Define each.
5. Sketch the model equations, in schematic form, to capture the “essence” of the behavior (don’t worry about the detailed values for parameters).
6. Which gating variables are depolarization activated / depolarization inactivated? 
7. Sketch the steady-state curves for the gating variables.
8. Consider the current: `I_K=g_K n^4  (V-E_K)`
    1. Define each term.
    2. How does this current behave for different values of V? 
9. Consider the current: `I_Na=g_Na m^3 h (V-E_Na)`
  1. Define each term.
  2. How does this current behave for different values of V?
10. Describe an action potential.
11. Describe how the HH model behaves when the input current I is really small, really big …

## Challenges

1. Explain each line of the Python code that simulates the HH model.
2. Determine how the firing rate of the HH model varies with input current I. Plot the firing rate vs I (the “f-I curve”).
3. How do the dynamics change as you increases / decrease the potassium conductance?
4. How do the dynamics change as you increases / decrease the sodium conductance?
5. Visualize the dynamics of the HH model in the three dimensional space (n,m,V). Describe how these dynamics change with changes in the input current I.
6. [ADVANCED] Simulate the FitzHugh-Nagumo model.

