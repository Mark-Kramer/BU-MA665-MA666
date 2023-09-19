## Readings

Either: 
- (pdf)	[Chapter 2, pages 25-42 @ E. Izhikevich, Dynamical Systems in Neuroscience, 2007.](/Readings/Izhikevich_Chapter_2.pdf)
- or (pdf)	[Chapter 6, pages 142-159 @ C. Koch, Biophysics of computation, 1998.](/Readings/Koch_Chapter_6.pdf)

(pdf)	[Hodgkin-Huxley 1-page cheat sheet](/Readings/Hodgkin-Huxley_Cheat_Sheet.pdf)

(pdf)	Advanced: [Hodgkin and Huxley, J Physiol (Lond) (1952) vol. 117 (4) pp. 500-44.](/Readings/Hodgkin_Huxley_1952.pdf)

## Videos

(lec) HH Part 1 - See OneNote

(lec) HH Part 2 - See OneNote

(lec) HH Part 3 - See OneNote

<!-- (lec) [M. Kramer, Introduction to the Hodgkin-Huxley neuron (Neural Spike Train Analysis 5)](https://www.samsi.info/news-and-media/27-jul-drs-m-kramer-and-u-eden-samsi/)

- NOTE: The slides for this lecture are available as [PDF](/Readings/Kramer_Slides_SAMSI_Lecture_2.pdf). !-->

## Code

(pynb)  Includes text, video, and code: [The Hodgkin-Huxley Model](https://mark-kramer.github.io/Case-Studies-Python/HH.html)

(py)    [HH_functions.py](HH_functions.py)

## Discussion

1. How is the HH model different from / similar to the IF and LIF models?
2. What are the ion species simulated in the HH model?
3. Which ion species is fastest / slowest?
4. How many variables are in the HH model? Define each.
5. Sketch the model equations, in schematic form, to capture the “essence” of the behavior (don’t worry about the detailed values for parameters).
6. Which gating variables are depolarization activated / depolarization inactivated? 
7. Sketch the steady-state curves for the gating variables.
8. Consider the current: `I_K=g_K n^4  (E_K-V)`
    1. Define each term.
    2. How does this current behave for different values of V? 
9. Consider the current: `I_Na=g_Na m^3 h (E_Na-V)`
    1. Define each term.
    2. How does this current behave for different values of V?

## Challenges

1. Explain each line of the Python code that simulates the HH model.
3. Describe how the HH model behaves when the input current I is small.
4. Describe an action potential (i.e., describe how the HH model behaves when the input current I is large).
5. Determine how the firing rate of the HH model varies with input current I. Plot the firing rate vs I (the “f-I curve”).
6. How do the dynamics change as you increases / decrease the potassium conductance?
7. How do the dynamics change as you increases / decrease the sodium conductance?
8. Visualize the dynamics of the HH model in the three dimensional space (n,m,V). Describe how these dynamics change with changes in the input current I.
9. [ADVANCED] Simulate the FitzHugh-Nagumo model.

