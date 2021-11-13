## Readings

(pdf) [Lecture Slides for Perceptron](/Readings/MA666_Neural_Networks_and_Learning.pdf)

(pdf) [Lecture Slides for Backpropagation](/Readings/MA666_Backpropagation.pdf)

(pdf) [The Nature of Code](https://natureofcode.com/book/chapter-10-neural-networks/)

## Videos

(mp4)  [MIT 6.034 F10 Artificial Intelligence, Lecture 12](https://archive.org/details/MIT6.034F10/MIT6_034F10_lec12_300k.mp4)

(vinemo) [Inside an artificial brain](https://vimeo.com/132700334)

(mp4)  [MIT 6.034 F10 Artificial Intelligence, Lecture 12A](https://archive.org/details/MIT6.034F10/MIT6_034F10_lec12A_300k.mp4)

(mp4)  [MIT 6.034 F10 Artificial Intelligence, Lecture 12B](https://archive.org/details/MIT6.034F10/MIT6_034F10_lec12B_300k.mp4)

## Discussion

(pynb) [Training a Perceptron (Part 1)](training-a-perceptron-Part-1.ipynb)

(pynb) [Training a Perceptron (Part 1)](training-a-perceptron-Part-2.ipynb)

(pynb) [Backpropagation Example](backpropagation-example.ipynb)

## Challenges

1. Load the file `training_and_testing_values.mat` available on the course repository. You will find that this `.mat` file contains a dictionary with the following important variables:

Training Data
`x_training` 		= x-coordinate to train the network,
`y_training `		= y-coordinate to train the network
`correct_answer `	= vector of 0’s and 1’s.

These three variables define the training data. For each (x,y)-coordinate, the correct_answer indicates whether the point is above (1) or below (0) the line. There are 1000 example (x,y)-cooridates, each with a correct classification.

Testing Data
x_testing 		= x-coordinate to test the network
y_testing 		= y-coordinate to test the network

The challenge is to determine whether each (x,y)-coordinate in the testing data is above or below the line. To do so, train a perceptron using the training data. Then, apply your trained perceptron to the testing data.
a.	How many points in the testing data are above the line, below the line?
b.	What is the slope of the line?
c.	What is the intercept?

2.	Load the file training_and_testing_values_3.mat available on GitHub into Python. You will find that this .mat file contains a dictionary with the following important variables:

Training Data
training is an array with dimensions (4,1000). Each row includes an (x,y,z)-coordinate (columns 0-2), and a classification of this coordinate as either above (1) or below (0) a plane (column 3). There are 1000 example points each with a correct classification.

Testing Data
testing = is an array with dimensions (3,1000). Each row includes an (x,y,z)-coordinate (columns 0-2). The classification for these points, as either above or below the plane, is unknown.

The challenge is to correctly classify each point in the testing data as above or below the plane. To do so, train a perceptron using the training data. Then, apply your trained perceptron to the testing data.
a.	How many points in the testing data are above the plane, below the plane?
b.	Can you use the results of your trained perceptron to write an equation for the plane? Hint: write the equation in this form,

	a x + b y + c z = d

and determine the unknown parameters a, b, c, d.

