# Week 3 — Functions for Engineering Computation

## Topics
- Defining functions with `def`
- Parameters and arguments
- Returning values
- Local and global variables
- Default arguments
- Lambda functions
- Reusable engineering calculations

## Berkeley reference
- Chapter 3: Functions
- https://pythonnumericalmethods.studentorg.berkeley.edu/notebooks/chapter03.00-Functions.html

## Engineering examples
Create reusable functions for:
- Force
- Stress
- Density
- Electrical power
- Cylinder volume
- Temperature conversion
- Cantilever beam deflection

## Example
```python
def stress(force, area):
    return force / area

sigma = stress(12000, 0.004)
print(sigma)
```

## Learning outcomes
Students should be able to break an engineering program into reusable functions and distinguish between inputs, returned results, and printed output.
