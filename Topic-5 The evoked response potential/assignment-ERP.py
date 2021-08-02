#######################################################################################
# 1.	Load the file:
#
#           EEG-2.mat, available on the this repository into Python. You’ll find two variables:
#
#  EEG = the EEG data, consisting of 1,000 trials, each observed for 1 s;
#  t = the time axis, which ranges from 0 s to 1 s.
# 
# These data have a similar structure to the data studied in class. To collect these data, a stimulus was presented to the subject at 0.25 s. Analyze these data for the presence of an evoked response. To do so, answer the following questions:
#  a.	What is the time between samples (dt) in seconds?
#  b.	Examine these data. Explain what you observe in pictures and words.  From your visual inspection, do you expect to find an ERP in these data?
#  c.	Compute the ERP for these data, and plot the results. Do you observe an ERP (i.e., times at which the 95% confidence intervals do not include zero)? Include 95% confidence intervals in your ERP plot, and label the axes. Explain in a few sentences the results of your analysis, as you would to a collaborator who collected these data.

import numpy as np                  # Import functions for calculations.
import matplotlib.pyplot as plt     # Import functions for plotting
from scipy.io import loadmat        # Import function to read data.

data = loadmat('EEG-2.mat')         # Load the data for this example.

# a. What is the time between samples (dt) in seconds?
dt = [???]

# b. Examine these data. Explain what you observe in pictures and words. From your visual inspection, do you expect to find an ERP in these data?

plt.plot(???)                               # Plot something useful.
plt.xlabel(???)                             # Label the x-axis ...
plt.ylabel(???)                             # Label the y-axis ...
plt.title(???)                              # Add a title ...
plt.plot([0.25, 0.25], [-4,4], 'k', lw=2)   # Add a vertical line to indicate the stimulus time

plt.imshow(???,                             # Make an *image* of something useful
           extent=[t[0], t[-1], 1, ntrials],# ... with nice x-limits. 
           aspect='auto',                   # ... set aspect ratio 
           origin='lower')                  # ... put origin in lower left corner
plt.xlabel(???)                             # Label the axes
plt.ylabel(???)
plt.colorbar()                              # Show voltage to color mapping
plt.vlines(0.25, 1, 1000, 'k', lw=2)        # Indicate stimulus onset with line
show()

#  c.	Compute the ERP for these data, and plot the results. Do you observe an ERP (i.e., times at which the 95% confidence intervals do not include zero)? Include 95% confidence intervals in your ERP plot, and label the axes. Explain in a few sentences the results of your analysis, as you would to a collaborator who collected these data.

plt.plot(???)                               # Plot the ERP for each condition.
xlabel(???)                                 # ... label the axes
ylabel(???)             
title(???)                                  # ... provide a title

#######################################################################################
# 2.	Load the file:
#
#           EEG-3.mat, available on the this repository into Python. You’ll find two variables:
#
#  EEG = the EEG data, consisting of 1,000 trials, each observed for 1 s;
#  t = the time axis, which ranges from 0 s to 1 s.
# 
# These data have a similar structure to the data studied in class. To collect these data, a stimulus was presented to the subject at 0.25 s. Analyze these data for the presence of an evoked response. To do so, answer the following questions:
#  a.	What is the time between samples (dt) in seconds?
#  b.	Examine these data. Explain what you observe in pictures and words.  From your visual inspection, do you expect to find an ERP in these data?
#  c.	Compute the ERP for these data, and plot the results. Do you observe an ERP (i.e., times at which the 95% confidence intervals do not include zero)? Include 95% confidence intervals in your ERP plot, and label the axes. Explain in a few sentences the results of your analysis, as you would to a collaborator who collected these data.

import numpy as np                  # Import functions for calculations.
import matplotlib.pyplot as plt     # Import functions for plotting
from scipy.io import loadmat        # Import function to read data.

data = loadmat('EEG-3.mat')         # Load the data for this example.

# -------- Now, re-use your code from above! --------

#######################################################################################
# 3.	Load the file:
#
#           EEG-4.mat, available on the this repository into Python. You’ll find two variables:
#
#  EEG = the EEG data, consisting of 1,000 trials, each observed for 1 s;
#  t = the time axis, which ranges from 0 s to 1 s.
# 
# These data have a similar structure to the data studied in class. To collect these data, a stimulus was presented to the subject at 0.25 s. Analyze these data for the presence of an evoked response. To do so, answer the following questions:
#  a.	What is the time between samples (dt) in seconds?
#  b.	Examine these data. Explain what you observe in pictures and words.  From your visual inspection, do you expect to find an ERP in these data?
#  c.	Compute the ERP for these data, and plot the results. Do you observe an ERP (i.e., times at which the 95% confidence intervals do not include zero)? Include 95% confidence intervals in your ERP plot, and label the axes. Explain in a few sentences the results of your analysis, as you would to a collaborator who collected these data.

import numpy as np                  # Import functions for calculations.
import matplotlib.pyplot as plt     # Import functions for plotting
from scipy.io import loadmat        # Import function to read data.

data = loadmat('EEG-4.mat')         # Load the data for this example.

# -------- Now, re-use your code from above! -------

#######################################################################################
# 4. In the previous question, you considered the dataset EEG-4.mat and analyzed these data for the presence of an ERP.  To do so, you (presumably) averaged the EEG data across trials.  The results may have surprised you . . . Modify your analysis of these data (in some way) to better illustrate the appearance (or lack thereof) of an evoked response.  Explain “what's happening” in these data as you would to a colleague or experimental collaborator.

#######################################################################################
# 5. Compare the datasets EEG-3.mat and EEG-4.mat studied in the previous problems.  Use a bootstrap procedure to test the hypothesis that the evoked response is significantly different in the two datasets.


