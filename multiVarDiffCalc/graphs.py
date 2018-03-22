import matplotlib.pyplot as plt
import numpy as np

fileExt = '.pdf'

#################################
# Graph for Hyperbola as Envelope
#################################

sVals = 10**np.arange(-0.5, 0.5, 0.05)
crossings = { 'x' : 1 / sVals, 
              'y' : sVals } 

# Graph the Family of Lines First

for x, y in zip(crossings['x'], crossings['y']):
    plt.plot([0, x], [y, 0], color = 'black')

ax = plt.gca()
ax.set_title('Some Lines From The Family')
ax.set_xlabel('x')
ax.set_ylabel('y')
plt.savefig('hyperbolaFamily' + fileExt)

# Graph Family of Lines With Envelope Curve
# First regraph family of lines.

for x, y in zip(crossings['x'], crossings['y']):
    plt.plot([0, x], [y, 0], color = 'black')

# Now graph envelope curve.

xVals = np.linspace(10**-1, 1.0, num = 30)
xVals = np.concatenate([xVals, 
                       np.linspace(1.0, 10**0.5, num = 10)])
yVals = 1.0 / 4 / xVals
plt.plot(xVals, yVals, linewidth = "3", color = 'red')

ax = plt.gca()
ax.set_title('Envelope Curve of Family in Red')
ax.set_xlabel('x')
ax.set_ylabel('y')
plt.savefig('hyperbolaEnvelope' + fileExt)
