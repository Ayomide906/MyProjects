from typing import Any

import numpy as np
from numpy import ndarray, dtype


def gradient_descent(x,y):
    m_curr=c_curr=0
    iterations=100000
    n=len(x)
    a=0.08 #upon testing, the most preferred learning rate is .08
    previous_cost=0
    import math
    for i in range(iterations):
        y_predicted =m_curr*x +c_curr
        cost=(1/n)*sum((y-y_predicted)*(y-y_predicted))
        if math.isclose(cost,previous_cost,rel_tol=1e-9):
            print(f'after {i} iterations, we are comfortable at our gradient decent')
            break
        md=-(2/n)*sum(x*(y-y_predicted))
        cd=-(2/n)*sum(y-y_predicted)
        m_curr-=a*md
        c_curr-=a*cd
        print(f'cost at iteration{i} is {cost}')
        previous_cost=cost
    print(m_curr,c_curr)
    print('cost at the end of iterations is {}'.format(cost))
x=np.array([1,2,3,4,5])
y=np.array([5,7,9,11,13])
#assignment
#x=np.array([92,56,88,70,80,49,65,35,66,67])
#y=np.array([98,68,81,80,83,52,66,30,68,73])

gradient_descent(x,y)