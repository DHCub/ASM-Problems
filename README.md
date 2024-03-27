# Problems Solved in Assembly and with Algorithmic State Machines

## First Computer Architecture Project

_MATCOM Faculty_

_University of Havana_

_2024_

## Authors

Francisco Préstamo Bernadez

Darío Hernández Cubilla

## Pseudocode

### Problem 017

#### Simple

``` Python
def IsDivisible(a, b): # b|a?
    if (b == 0): return False
    if (a == 0): return True
    
    if (a < b): return False

    while(True):
        a -= b
        if (a == 0): return True
        if (a < b): return False
```

#### Efficient

``` Python
# O(n) where n is the amount of bits necessary to represent the numbers
def IsDivisible(a, b): # b|a?
    if (b == 0): return False
    if (a == 0): return True
    
    if (a < b): return False

    l1 = leadingZeroes(bin(a))
    l2 = leadingZeroes(bin(b))
    c = l2 - l1 # a should have less leading zeroes than b
    b *= 2**(l2 - l1)

    while(True):
        if b <= a:
            a -= b
            if a == 0: return True

        b /= 2
        c -= 1
        if c < 0: return False

def leadingZeroes(str): # assuming 8-bit numbers
    ctr = 0
    for c in str[2:]:
        if c == '0':
            ctr += 1
        else: return ctr + 8 - (len(str) - 2)
```

### Problem 079

``` Python
def GetFraction(a, b, c, d):
    z = gcd(b, d)
    x = a*d/z
    y = c*b/z
    return (x - y, (b * d)/z)

def gcd(a, b)
    if a == b: return a
    if a < b: return gcd(a, b)

    r = a%b
    if r == 0:
        return b
    else:
        return gcd(b, r)

```

### Problem 095

We just used the provided code:

```
Algoritmo InsertionSort(A)
    Para i desde   1 hasta longitud(A) -   1 hacer
        clave = A[i]
        j = i -   1
        Mientras j >=   0 y A[j] < clave hacer
            A[j +   1] = A[j]
            j = j -   1
        Fin Mientras
        A[j +   1] = clave
    Fin Para
Fin Algoritmo
```
