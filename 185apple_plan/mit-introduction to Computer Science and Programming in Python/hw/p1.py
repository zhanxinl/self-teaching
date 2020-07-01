## Problem 1.  Write a program that computes and prints the 1000th prime number.
## This problem took just over one hour to program.



def isPrim (x):
    """
    input: a int
    output: bool whether x is prime number or not
    """

    if x<=1:
        return False

    for i in range (2,x):
        if x%i==0:
            return False

    return True



    
            
counter=0
number=0

while counter<1000: # counter=1000 stop
    number+=1 
    res=isPrim (number)

    if res:
        counter+=1

    
print(number)



## Problem 2.  Write a program that computes the sum of the logarithms of all the primes from 2 to some number n,
## and print out the sum of the logs of the primes, the number n, and the ratio of these two quantities. Test this for different values of n.
## You should be able to make only some small changes to your solution to Problem 1 to solve this problem as well.
## Hints:  While you should see the ratio of the sum of the logs of the primes to the value n slowly get closer to 1, it does not approach this limit monotonically.

## Probably took two hours+ to make this work.

import math

def sumlogPrim(n):
    """
    input: a int the upper bound of the sum
    output: a  set with
        1. float sum of log(prime)
        2. a int n
        3. float log(prime)/n

    we expect log(prime)/n-> 1, as n increase.
    """
    s=0
    for i in range (2,n+1):
        if isPrim(i):
            s+=math.log(i)
    return s, n, s/n

test=[5,10,20,100,500,1000]
for i in test:
    print(sumlogPrim(i))
            
        

