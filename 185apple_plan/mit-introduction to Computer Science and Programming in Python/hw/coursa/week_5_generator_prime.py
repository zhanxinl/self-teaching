import math
def isPrime(n):
    if n<=1:
        return False
    if n==2:
        return True
    if n%2==0:
        return False

    i=3

    while i<=math.sqrt(n):
        if n%i==0:
            return False

        i+=2

    return True

    

def getPrime():
    n=1

    while True:
        n+=1
        if isPrime(n):
            yield n
                   
