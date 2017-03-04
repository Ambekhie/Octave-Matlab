# Part 1
## Objective:
* The aim of this project is to compare and analyze the behavior of the different numerical methods
 * Bisection
 * False-position
 * Fixed point
 * Newton-Raphson
 * Secant 
 * Bierge Vieta.

## Description:
* a root finder program which takes as an input the equation, the technique to use and its required parameters (e.g. interval for the bisection method).Also, general algorithm that takes as an input the equation to solve and outputs its roots.

### Specification:
* An interactive GUI that enables the user to enter equations containing different functions such as: {poly, exp, cos, sin}. Reading from files are available as well.
* Differentiation and Parsing.
* A way to choose a method to solve the given equation.
* A plot of the function with the boundary functions in case of bisection and false position, g(x) with y = x in case of fixed point, f’(x) in the remaining cases.
* A way to enter the precision and the max number of iterations otherwise default values are used, Default Max Iterations = 50, Default Epsilon = 0.00001;
* The answer for the chosen method indicating the number of iterations, execution time, all iterations, approximate root, and precision.
* Compute the theoretical bound of the error for the methods.

## The report contains:
 * Flowchart or pseudo-code for each method and the general algorithm.
 * general algorithm and the reason behind the decisions.
 * Data structure used and how helpful was the choices.
 * Analysis for the behavior of different examples using the analysis template, and your conclusion about the behavior of each method (at least three examples).
 * Problematic functions and the reason for their misbehavior and suggestions (if exists).
 * Sample runs and snapshots from the GUI.

## Bonus:
 * Single step mode simulation showing the iterations on the drawn function for one method of choice.

# Part 2
## Objective:
  * The aim of this part is to compare and analyze the behavior of numerical methods 
   * Newton interpolation 
   * Lagrange interpolation.

## Description:
  * You are required to implement a program for querying the values of specific points using interpolation which takes as an input the polynomial order, sample point(s), corresponding value(s),the interpolation technique to use (Newton – Lagrange) and the query point(s).

### Specification:
 * An interactive GUI that enables the user to enter an order, a set of data point(s) and corresponding value(s). Reading from files available as well.
 * A way to choose a method for interpolation.
 * A way to enter the point(s) where we need to find a value.
 * The answer for the chosen method indicating the the execution time, solution.
 * The polynomial function obtained from the interpolation and its plot in the data set range.

## The report contains:
 * Flowchart or pseudo-code for each method.
 * Data structure used and how helpful was the choices.
 * Analysis for the behavior of different examples using the analysis template, and conclusion about the behavior of each method (at least three examples).
 * Problematic functions and the reason for their misbehavior and your suggestions (if exists).
 * Sample runs and snapshots from your GUI.
