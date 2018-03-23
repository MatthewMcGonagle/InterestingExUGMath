import numpy as np
import matplotlib.pyplot as plt

####################################
#### Graphs for Mercator Map 
###################################

# Graph for uniformly spaced lines of latitude and fixed angle of 45 degrees to magnetic north.
# We let theta be longitude (east-west angle) and phi be latitude (north-south angle). 
# Solving geometry, we get (d phi / d theta)^2 = (cos(45 degrees)^2) * (cos(phi) ^2 + (d phi / d theta)^2).
# Algebraic manipulation gives (d phi / d theta)^2 = cos(phi)^2.
# For increasing phi, we then get d phi / d theta = cos(phi).
# So for phi(0) = 0, we get log(sec(phi) + tan(phi)) = theta. 
# Thus it is easier to graph theta as a function of phi.

# More general is sin(magneticAngle) * d phi / d theta = cos(magneticAngle) * cos(phi).
# Which gives log(sec(phi) + tan(phi)) = theta * cot(magneticAngle).
# or theta = tan(magneticAngle) * log(sec(phi) + tan(phi)).

magAngle = np.pi / 6 
magCoeff = np.tan(magAngle) 

phiVals = 0.90 * np.linspace(-np.pi/2, np.pi/2, num = 40)
thetaVals = np.log(1.0 / np.cos(phiVals) + np.tan(phiVals)) * magCoeff

plt.plot(thetaVals, phiVals)
plt.plot(thetaVals[[0, -1]], phiVals[[0, -1]], color = 'red')

latTicks = np.linspace(-np.pi/2, np.pi/2, num = 5)
latLabels = ['-Pi/2', '-Pi/4', '0', 'Pi/4', 'Pi/2']
longTicks = latTicks
longLabels = latLabels

ax = plt.gca()
ax.set_xlim([-np.pi/2, np.pi/2])
ax.set_ylim([-np.pi/2, np.pi/2])
ax.set_xlabel('Longitude (Radians)')
ax.set_ylabel('Latitude (Radians)')
ax.set_title('Uniformly Spaced Lines of Latitude (Not Mercator)\nAngle to North is Pi/6 Radians')
plt.legend(['Constant Angle to North', 'Map Straight Line'], loc = (0.4, 0.1))
plt.yticks(latTicks, latLabels)
plt.xticks(longTicks, longLabels)
plt.savefig('nonMercator.pdf')
plt.show()

mercatorVals = np.log(1.0 / np.cos(phiVals) + np.tan(phiVals))
thetaVals = mercatorVals * magCoeff 

latLabels = ['-4Pi/9', '-Pi/3', '-2Pi/9', '-Pi/9', '0', 'Pi/9', '2Pi/9', 'Pi/3', '4Pi/9']
latTicks = np.linspace(-4 * np.pi/9, 4 * np.pi/9, num = 9)
mercatorTicks = np.log(1.0 / np.cos(latTicks) + np.tan(latTicks))

plt.plot(thetaVals, mercatorVals)
plt.yticks(mercatorTicks, latLabels)
ax = plt.gca()
ax.set_ylabel('Latitude (Radians)')
ax.set_xlabel('Longitude (Radians)')
ax.set_title('Mercator Map\nAngle to North is Pi/6 Radians')
plt.savefig('mercator.pdf')
plt.show()
