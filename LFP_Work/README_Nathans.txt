READ_ME_Nathanael_Cruzado

Instructions for utilizing Nathan's final project:

Run Final_Project_Data_Simulation.m or load Final_Project_Data_set_example_preprocessed.mat to get example data to work with
Then run 
either Final_Project_MSCohere.m to calculate magnitude squared coherence
or Final_Project_PLV.m to calculate phase locking value and PLV difference

In general, to use either of these tools, you should format your data you will input to them as follows:
time_step should be the step size in time
time_axis should be a vector of all the time_step values
LFP_Hip_incorr and LFP_PFC_incorr should be the LFP values for one condition (incorrect in the examples) in two separate areas (LFP and PFC in the examples)
LFP_Hip_corr and LFP_PFC_corr should be the LFP values for the other condition (correct in the examples) in two separate areas (LFP and PFC in the examples)
all four of these variables are expected to be organized by trial in the second dimension and the LFPs for each trial in the 1st dimension
trials_corr and trials_incorr have the number of trials for each of the two conditions

Final_Project_MSCohere.m can run on either the correct or incorrect condition, just comment-out and uncomment-out the first several lines to change what is set as x, y, and trials 

In Final_Project_MSCohere.m some extra plots have been commented out.  Uncomment out to see additional plots of cross-coherence and auto-coherence. 
