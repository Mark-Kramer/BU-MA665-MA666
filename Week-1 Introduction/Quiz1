"""
Quiz 1
Team members: Jing, Allison, Ying, Christopher, Guanying He
"""

import numpy as np
import matplotlib.pyplot as plt


# Task 1: Create 10x1000 matrix of normally dist. #s, find index of #s>0, assign 1 to those #s, plot as histogram
M=np.random.normal(0,1,(10*1000)) # Create vector of normally distributed #s
xy=[M>0] # Find #s>0
M[xy]=1 # Assign 1 to #s>0
Matrix=np.reshape(M,(10,1000)) # Here's the matrix as asked for
plt.xlim([min(M)-1, max(M)+1]) # Define x-axis range
plt.hist(M) # Plot histogram of values in M
plt.title('10,000 normally distributed variables with all positive values set to 1') # Titles and labels
plt.xlabel('Value')
plt.ylabel('Count')
plt.show

# Task 2: Create a function that returns a Fibonacci sequence of length n (seed of 1) and print the result to the console
def fbnq(n): # Define function
    aa=np.zeros(n) # Generate array of zeros with length n to fill
    aa[0]=1 # Seed F1
    aa[1]=1 # Seed F2
    ii=2 
    while ii<n:
        aa[ii]=aa[ii-1]+aa[ii-2] # Recursive relation 
        ii=ii+1
    print(aa)    
    return aa # Return the full sequence
