Key Concepts:


/= for inequality checks
(variable, width => 0) <- For formatting

Approach:

Store all polynomial expressions (Exponents) in a linked list.
If the exponent is equal to 0, the term will not have a variable
If the coefficient is negative, it will cause subtraction when that term is reached
If the polynomial itself has a value of 0, it is represented as an empty list

Create Multiple Lists for each Polynomial so have a check to let the user end the creation 
of a polynomial and give them the option to create future Polynomials

Rules for polynomial addition. If the terms in question have the same exponent,
all functions (Addition/Subtraction/Multiplication/Division) are allowed.

Addition/Subtraction: Only Coefficients are added/subtracted

Multiplication: Coefficients are multiplied and the Exponents are Added

Division: Coefficients are divided and the Exponents are Subtracted

 
 ______________________________

polyLink Functionality:
1. Deals with the input, output, and storage of the polynomials using a linked list
2. Has two subprograms, readPOLY and writePOLY.
- readPOLY reads and stores the polynomial
- writePOLY outputs the polynomial to the screen

Current Tasks:
1. Create two lists and concatenate the second list to the first list by adding nodes where necessary
- Will require the comparison between exponents and replacement of node values
- Special condition: If there is a node in the second list that has an exponent that is not present in the first list,
Assuming that the operation in question is either Addition or Subtraction, just place that node into the list

2. Get the intended operation first. Addition, Subtraction or Multiplication. Based on this, after the second list is 
inputted, perform the calculation, update the first list, and empty the second list so that the user can input another list.
Directly after this, prompt the user to enter what operation they would like to input.
