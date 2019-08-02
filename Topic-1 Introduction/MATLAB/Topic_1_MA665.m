%%  MA665 - Topic 1:  MATLAB Tutorial.
%   This tutorial follows closely Chapter 2 of the textbook 'MATLAB for
%   Neuroscientists' and Chapter 1 of 'Case Studeis in Neural Data Analysis'. If you
%   already know MATLAB, I suggest you quickly work through this tutorial, and confirm you're
%   up to speed.  If you've never used MATLAB (or any other programming
%   language) then I encourage you to work through this tutorial, and all of Chapter 1
%   'Case Studeis in Neural Data Analysis'.  We will use MATLAB throughout
%   this course.  And, you'll probably find MATLAB useful in other courses
%   here at BU, as well as throughout your graduate career as a
%   neuroscientist.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Example 1.  MATLAB is a calculator.
%   Enter the following command at the MATLAB prompt >>

4 + 3

%Q:  What do you get?  Does it make sense?

%%  Example 2.  MATLAB can compute complicated quantities.
%   Enter the following command at the MATLAB prompt >>

4/10^2

%Q:  Can you use parentheses to alter the result?

%%  Example 3.  MATLAB has useful built in functions.
%   A function is a program that operates on arguments.  Consider the 
%   following function >>

sin(2*pi)

%   Above, 'sin' is a function.  It operates on the argument '2*pi'.  Below
%   are three more examples of function that operate on arguments >>

cos(2*pi + 1/10)

exp(-2)

atan(2*pi)

%Q:  What is 'atan'?  To answer this, try using MATLAB Help.  To start the
%MATLAB Help, click on 'Help' at the top of your editor and select 'Product
%Help'.  This should open a new window.  In the Help Navigator type 'atan'
%and see what you find.

%NOTE:  The MATLAB Help is *extremely* useful.  Always look there when you
%have questions about a function.

%%  Example 4.  We can use MATLAB to define vectors.
%   A vector is a list of numbers.  Let's define one >>

[1 2 3 4]

%Q:  What happens when you type this in MATLAB?

%%  Example 5.  We can manipulate vectors by scalars.
%   A scalar is a single number.  Consider >>

[1 2 3 4] * 3

%Q:  What do you find?

%%  Example 6.  We can manupulate vectors with vectors >>

[1 2 3 4] .* [1 2 3 4]

%Q:  What does this return?

%NOTE:  Above we use the notation >> .* << to multiply.  This causes the
%vectors to be multiplied element-by-element.  To do so, the vectors must
%have the same number of elements.  Consider >>

[1 2 3 4] .* [1 2 3 4 5]

%Q:  What happens when you enter the above expression?

%NOTE:  The operator >> .* << differs from the operator >> * <<.  The
%latter operator performs "matrix multiplication", which is very different
%from the element-by-element multiplication we performed above.  If you've
%taken a class in linear algebra, then you've seen matrix multiplication.
%I don't think we will use matrix multiplication in this course (but it is
%an essential tool in more advanced data analysis).  The important point is
%the following:
%
%CAUTION:  >> .* << and >> * << are VERY DIFFERENT OPERATORS!!

%%  Example 7.  We can define variables in MATLAB.
%   In the previous examples, we typed [1 2 3 4] over and over again.  It's
%   easier to assign a variable to this vector, and then simply reference
%   this variable to access the vector.  Consider >>

a = 2
b = [1 2 3 4]

%  Here we have defined two variables.  The variable 'a' is a scalar and
%  assigned the number '2'.  The variable 'b' is a vector and assigned the
%  vector [1 2 3 4].  To work with these scalars and vectors, we can now
%  refer to the variables.  Consider >>

c = a*b
d = b.*b

%Q:  What are the new variables 'c' and 'd'?

%%  Example 8.  We can probe the variables we've defined in MATLAB.
%   A good place to start is the WORKSPACE WINDOW of MATLAB.  Look around
%   for this window on your desktop.  What variables do you see?  What
%   information do you learn about the variables by examining the
%   Workspace?

%  To see a list of the variables you've defined, type >>

who

%  To determine the size of a variable, type >>

size(c)

%%  Example 9.  We can "sum" the elements in a vector.
%   Sometimes it's useful to add up all the elements in a vector.  We can
%   do this by hand.  For example, let's look at the vector "c":

c

%   In this case, we can sum the elements by looking at the command line
%   and adding up the values.  But, there's an easier way:  we can use the
%   MATLAB command "sum",

sum(c)

%NOTE:  That's a new function.  What is the input?  What is the output?
%       Check out MATLAB Help!

%IN LAB Q:  Compare the result of the MATLAB command and your by-hand sum.
%Are the two the same?  They should be.

%%  Example 10.  Sometimes we need to clear all variables.
%   To clear all variables from the Workspace, type >>

clear

%Q:  Are all the variables gone?  How can you check?

%%  Example 11.  We can define matrices in MATLAB.
%   A matrix is a group of vectors.  Consider the following >>

p = [1 2 3; 4 5 6]

%   This creates a matrix with two rows and three columns.  We can
%   manipulate matrices like we manipulate vectors.  Consider >>

p + 2

%Q:  What happens?

%%  Example 12.  Indexing matrices and vectors.
%   Matrices and vectors are lists of numbers, and sometimes we want to
%   access individual elements or small subsets of these lists.  That's
%   easy to do in MATLAB.  Consider >>

a = [1 2 3 4 5]
b = [6 7 8 9 10]

%   To access the 2nd element of 'a' or 'b', type >>

a(2)
b(2)

%Q:  Do the results make sense?  How would you access the 4th element of
%each vector?

%   We can combine 'a' and 'b' to form a matrix.

c = [a; b]

%   To learn about 'c', type >>

size(c)

%   The size of 'c' is [2 5].  It has two rows and five columns.  To access
%   the individual element in the 1st row and 4th column of 'c', type >>

c(1,4)

%NOTE:  We access matrices using 'row,column' notation.  So c(1,4) means
%print the element in row 1, column 4 of c.


%   To access all columns in the entire first row of 'c', type >>
c(1,:)
%   The notation ':' means 'all indices'.


%   To access the 2nd thru 4th columns of row 1 of 'c', type >>
c(1,2:4)
%   The notation '2:4' means 'all integers from 2 to 4' which in this case
%   is 2,3,4.

%Q:  How do you access all rows in the 2nd column of 'c'?

%%  Example 13:  We can *find* subsets of elements in lists.
%   Sometimes we're interested in locating particular values within a
%   list.  For example, let's first define a list of numbers

a = [1,2,3,4,5,6,7,8,9,10]*2

%Q:  What is the size of the variable 'a'?  What are the values in the
%variable 'a'?

%   There's an easier way to define the same list of numbers.  Consider the
%   following

b = (1:1:10)*2

%Q:  What is the size of 'b'?  What are the values in 'b'?  How do the
%values in 'a' compare to the values in 'b'?

%   Now let's find the indicies for all values in 'b' that exceed 10.  We
%   could, of course, do this by hand.

%Q:  Determine by inspection the indices of 'b' that exceed 10.  What are
%they?  

%   It turns out there's a simple way to perform this operation in MATLAB.
%   To do so,

indices = find(b > 10)

%Q:  What is now stored in the variable "indices"?
%Q:  'find' is a function built into MATLAB.  What does find do?
%    HINT:  Look in MATLAB Help!

%We can examine the values of 'b' at the 'indices',

b(indices)

%We can mainpute the values of 'b' at the 'indices',

b(indices) = 0

%Q:  Now what is the largest value stored in vector 'b'?

%%  Example 14:  Plotting data in MATLAB.
%   It's not easy to look at lists of numbers and gain any intuitive
%   feeling for their behavior, especially when the lists are long.  In
%   these cases, it's much better to visualize the lists of numbers by
%   plotting then.  Consider >>

x = (0:1:10)

%   The above line constructs a vector that starts at 0, ends at 10, and
%   takes steps of size 1 from 0 to 10.  Then define >>

y = sin(x)

%   Looking at the values in 'y' can you tell what's happending?
%   To visualize 'y' versus 'x', execute >>

plot(x,y)

%  This command will produce a plot of x versus y.  It should look a bit
%  jagged, and not smooth like a sinusoid.  To make the curve more smooth,
%  let's redefine 'x' as >>

x = (0:0.1:10);

%Q:  Compare this definition of 'x' to the definition above?  How do these
%two definitions differ?
%Q:  What is the size of 'x'?  Does this make sense?

%NOTE:  You might notice that I've include a semicolon ';' at the end of
%the definition of the vector 'x' above.  This semicolon tells MATLAB *not*
%to write out the results of this command in the command window.  We don't
%want to write out 'x' because it contains lots of elements, and it's not
%useful for us to look at them anyway.

%  Now recompute 'y' as >>

y = sin(x);

%  Note the semicolon ending the line.  To plot u >>

plot(x,y)

%Q:  How does the plot look?

%%  Example 15:  We can make multiple plots, one atop the other.
%   Let's define a second vector >>

z = cos(x);

%   And plot it >>

plot(x,z)

%   We'd now like to compare 'y' and 'z'.  To do this,
%   let's plot both vectors on the same figure.  First, open a new figure
%   >>

figure(1)

%   And plot x versus z >>

plot(x,z)

%   Now, tell MATLAB to 'hold on' to this figure >>

hold on

%   And plot also on this figure x versus y >>

plot(x,y, 'Color', 'r')

%NOTE:  We've included more arguments to the function 'plot'.  We've here
%told plot to draw the curve in a particular color -  red.  There are many
%options we can use to plot;  to see more, check out 'plot' in MATLAB Help.

%   When we're done 'holding' the figure, we turn hold off >>

hold off

%   We can also label the axis and give the figure a title >>

xlabel('X axis is Time')
ylabel('Y axis is Voltage')
title('My plot of y and z')

%%  Example 16:  We can make random numbers in MATLAB.
%   To generate a single random number in MATLAB, type >>

randn(1)

%   In the command above, we are calling the MATLAB function 'randn'.  This
%   function returns a single random number.

%Q:  Execute this command a few times.  What do you get?

%   Sometimes, we would like to generate a list of random numbers.  To do
%   so, we can again use the 'randn' command, but this time with
%   different input arguments.  Consider the following line of code:

r = randn(10,1)

%   In the line above, we again call the function 'randn'.  But this time,
%   we call the function with two input arguments -- (10,1) -- and store
%   the results in the variable 'r'.

%IN LAB Q:  What is the size of of the variable 'r'?  What numbers do you find in
%'r'?

%IN LAB Q:  What happens to the size of 'r' as you change the values of the input
%arguments?  Consider, for example:
%
%  r = randn(100,1);
%  r = randn(10,10);
%
%What is the size of 'r' in each case?  What are the types of values you
%observe in 'r' in each case?

%   We sometimes will need to generate long lists of random numbers.  We
%   can do so using the 'randn' command as follows:

r = randn(1000,1);

%IN LAB Q:  How many elements are in the vector 'r'?

%   To see how these random numbers are distributed, we can visualize the
%   results.  To start, let's plot the variable 'r':

plot(r)

%IN LAB Q:  Examine the plot.  What values does 'r' take on?  What's the biggest
%value of 'r'?  The smallest?  The most common?

%%  Example 17:  We can make histograms in MATLAB.
%   There are many ways to display the data in 'r'.  Another way is to
%   construct a *histogram*.  A histogram displays the number of times we
%   observe a value in a list.  To start, consider the following list of
%   numbers stored in the variable 'a':

a = [0,0,0, 1,1,1,1, 3,3];

%   It's easy to construct a histogram of the values in 'a' using the built-in
%   MATLAB function 'hist'.  Let's do it.

hist(a, (0:1:5))

%IN LAB Q:  The result of the command above is to produce a plot.  Examine this
%plot.  What do you find?

%   The histogram indicates the number of times we observe each value in
%   the variable 'a'.  In this case, we observe the values:
%
%   0, 3 times.
%   1, 4 times.
%   3, 2 times.
%
%   Notice that, in the histogram plot, there are three bars.  The first
%   bar has an x-coordinate of 0, and a y-coordinate of 3.  This tells us
%   that, in the variable 'a', we obseve the value 0 three times.
%
%   Also notice that, in the 'hist' command, we specify two inputs:
%
%   1st input:  'a' -- the variable of interest.
%   2nd input:  The histogram 'bins', which specifies the center value of
%   each bin.
%
%   In this case, for the 2nd argument, we specify six bins:  the bins
%   start at a value of zero, and step forward in values of one, up to a
%   value of five.
%
%   For completeness, let's label the axes,

xlabel('Observed values')
ylabel('Counts, or Number of times observed')
title('Histogram of a')

%IN LAB Q:  Consider the x-coorindate location of 1 in the plot.  Do you observe a bar at
%this x-coordinate?  If so, what is the height?  How does this height correspond
%to the number of ones you observe in your list 'a'?  What about the
%x-coordinate of 2?  Of 3?

%IN LAB Q:  Consider how the histogram plot changes as the 2nd input to 'hist'
%(the 'bins') is varied.  More specifically, consider:
%
%  hist(a, (0:2:5))
%
%  AND
%
%  hist(a, (0:0.1:5))
%
%Compare the histograms you create in each case.  Do they make sense?

%   Finally, let's return to our list of random numbers that we stored in
%   the variable 'r' and plot a histogram:

hist(r, (-5:0.5:5))

%IN LAB Q:  Consider the histogram plot of 'r'.  What is the most common value (or
%in other words, which value has the most number of counts)?

%IN LAB Q:  How does the histogram of 'r' change as you vary the bins (the 2nd
%argument of the the 'hist' command)?

%   We'll talk more about histograms throughout the semester.

%%  Example 18:  Repeating commands over and over and over . . . 
%   Sometimes we'll want to repeat the same command over and over again.
%   What if we want to plot sin(x + k*pi/4) where k varies from 1 to 5 in
%   steps of 1;  how do we do it?  Consider the following >>

x = (0:0.1:10);  %Define a vector x that ranges from 0 to 10 with step 0.1.
k=1;
y = sin(x + k*pi/4);

figure(1)
plot(x,y)

k=2;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

k=3;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

k=4;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

k=5;
y = sin(x + k*pi/4);
hold on
plot(x,y)
hold off

%   That's horrible code!  All I did was cut and paste the same thing
%   four times.  As a general rule, if you're cutting and pasting in code,
%   you're doing something time-consuming and error-prone.  There's a much
%   more elegant way to do this, and it involves making a 'for' loop.
%   Consider >>

x = (0:0.1:10);             %First, define the vector x.
figure(1)                   %Open the figure.
for k=1:1:5                 %For each value of k from 1 to 5 in steps of 1.
    y = sin(x + k*pi/4);    %Define y (note the variable 'k' in sin).
    hold on                 %Hold the figure.
    plot(x,y)               %Plot x versus y.
    hold off                %Stop holding the figure.
end

%   The small section of code above replaces all the cutting-and-pasting.
%   Instead of cutting and pasting, we update the definition of 'y' and
%   plot it within this for-loop.

%Q:  Spend some time studying this for-loop.  Does it make sense?

%NOTE:  In this course, you'll encounter for-loops in some of the code we
%examine in class.  So, it's useful to be familiar with this type of
%operation.  We'll see it used again and again.

%%  Example 19:  Defining a new function: an M-file.
%   We've spent some time in this lab and the previous lab calling built-in
%   MATLAB functions (for example, the functions 'hist' or 'sin').  A
%   powerful feature of MATLAB is the ability to create our own functions,
%   to acheive whatever goals we are pursuing.  As an example of this,
%   let's write our own MATLAB function to compute:
%
%   y = 5x^2
%
%   Below we'll consider a 3 step process to create this
%   function.  Let's implement these steps now.
%
%   1.  Open a new file in the MATLAB editor and type:
%
%     function y = my_new_function(x)
%       y = 5*x^2;
%     end
%
%   2.  Save the file.
%
%IMPORTANT NOTE #1:  The file name and function name must match!  Notice in
%this case that the file name ('my_new_function.m') matches the function name
%('my_new_function') we call at the MATLAB prompt.
%
%   3.  Execute the function.
%       To do so, we execute the following commands in MATLAB,

a = 3;
b = my_new_function(a);

%Q:  What value is now stored in the variable "b"?
%
%IMPORTANT NOTE #2:  To call this function, we need to navigate MATLAB to
%the directory that holds the function file. Otherwise, when we attempt to
%execute,
%
% >> b = my_new_function(a);
%
%we'll get an error.  We get this error because MATLAB can't find the file
%'my_new_function.m'.  To fix this, we must navigate MATLAB to the directory
%where this file lives.   To do this, click on the '...' icon in the upper
%right of the MATLAB Command Window, and direct MATLAB to the folder
%location where you downloaded the file 'my_new_function.m'.

%%  Example 20:  Saving your work in MATLAB.
%   NOTE:  The function 'my_new_function.m' is a MATLAB function that we can
%   execute.  The file we are currently editing is *also* a MATLAB file
%   (notice the '.m' extension of the file 'Topic_1_MA665.m').  This file is
%   called a MATLAB 'script'.  It's usually useful to define scripts of your
%   own to save the work you're doing.  To do so, click on the following:
%
%    File ---> New ---> Script
%
%   You'll get a blank file where you can enter any commands you like.  You
%   can then execute this code by clicking on:
%
%    Cell ---> Evaluate Current Cell
%
%   This will execute all of the commands within the script.
%
%   You can then save this script (as a '.m' file), and return to it later.

%%  Example 21:  Loading data in MATLAB.
%   Sometimes we'll consider examples in this course that involve loading
%   data.  Fortunately, that's easy to do in MATLAB.  Consider the
%   following:
%
%   Vist the webpage,
%
%       https://github.com/Mark-Kramer/Case-Studies-Kramer-Eden/blob/master/Chapter1/Ch1-example-data.mat
%
%   and download the file "Ch1-example-data.mat".  We'd now like to open this data set.  The
%   first step is to direct MATLAB to the same directory that contains the
%   downloaded file.  To do this, click on the '...' icon in the upper
%   right of the MATLAB Command Window.
%
%   Once you're in the correct directory, type >>

clear                               %First clear the workspace,
load Ch1-example-data.mat           %Then load the data.

%   This command reads in the data stored in the file "Ch1-example-data.mat".

%Q:  What variables now exist in your workspace?  What is the size of
%variable 't1' and 'v1'?  Plot v1 versus t1 to get a sense for how
%they behave.