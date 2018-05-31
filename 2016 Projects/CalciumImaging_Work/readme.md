Janis and Byron's code for simulating calcium imaging data and segmenting ROIs

# Dependencies

Original GitHub repository (for reference): https://github.com/janisirene/MA666CalciumImaging

Helmchen lab simulation repository: https://github.com/HelmchenLab/CalciumSim

# Main Files

Segmentation Algorithms: CaImGetROIS.m (hierarchical clustering) and kmeans_CaImGetROIs.m (kmeans clustering method). These algorithms are mostly the same, but deviate at the clustering section of the code. Noise removal is also put together in a modular fashion so one function may contain parts that the other does not.

Simulation Function: simulateCalcImg.m outputs a 3d array and structure describing the true "cells" in the simulation. This code requires the use of the Helmchen lab repository linked above.

# Supporting Files

To run an algorithm on a simulation: testCaImGetROIsOnSimulation.m - simulates data, segments data, compares segmentation to true ROI

readTifStack: function to read tif stack into matlab as 3d array

noise3.m: generates 3d noise with PSD of form 1/f^a for simulation

To run many simulations and segmentations on the Shared Computing Clutering (SCC):
  - sccRunTests.m: wrapper function to run testCaImGetROIsOnSimulation on SCC
  - writeSCCInputList.m: script to print a text file listing parameters to run testCaImGetROIsOnSimulation
  - run_matlab.sh: bash script to run matlab code through SGE
  - batchTestOnSimulation.m: script to aggregate outputs of sccRunTests.m and plot ROC curves and other metrics

analyzeTifCharacteristics.m: sandbox script to investigate characteristics of real data
