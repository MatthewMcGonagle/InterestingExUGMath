import matplotlib.pyplot as plt
import numpy as np

def folium(t, C = 1.0):
    '''
    The parameterization of the folium of Descartes in the form x^3 + y^3 = 3Cxy is
    x(t) = 3Ct / (1 + t^3),
    y(t) = 3Ct^2 / (1 + t^3). 
    Here the parameterization is given by t = y / x.
    Params
    ------
    t : numpy array 
       The times to evaluate at. One branch is from times -infinity to -1. The other branch is
       from -1 to infinity. 
    C : scalar
       The scalar quantity in the equation for the folium of Descartes.

    Returns
    -------
    Points : Numpy array
        Numpy array of points. The shape is (t.shape, 2) so that the xy points are on the last dimension.
    '''

    denom = 1 + t**3
    x = 3 * C * t / denom 
    y = 3 * C * t**2 / denom 
    points = np.stack([x, y], axis = -1)
    return points

nPoints = 150
distToSingularity = 0.75
smallSlope = -1.75
largeSlope = 8
t1 = np.linspace(-largeSlope, smallSlope, int(nPoints / 2)) 
t2 = np.linspace(1 / smallSlope, largeSlope, int(nPoints / 2))
points1 = np.flip(folium(t1), axis = 0)
origin = np.zeros((1,2))
points2 = np.flip(folium(t2), axis = 0)
points = np.concatenate([points1, origin, points2], axis = 0)

plt.plot(points[:, 0], points[:, 1])
plt.title("Folium of Descartes for C = 1")
plt.xlabel('x')
plt.ylabel('y')
plt.tight_layout()
plt.savefig("_generated/graphFoliumDescartes.pdf")
plt.cla()

# Get the transformation xz-graph
nPoints = 100
t1 = np.linspace(0, 3, nPoints+1)[1:] 
points1 = folium(t1)
zs = points1[:, 1] / points1[:, 0]**2 
points1 = np.stack( [points1[:,0], zs], axis = -1)
points1 = np.concatenate([ [[0, 1/3]], points1], axis = 0)
plt.plot(points1[:, 0], points1[:, 1])
plt.title('xz-Coordinates of Loop For C = 1')
plt.xlabel('x')
plt.ylabel('z')
plt.tight_layout()
plt.savefig('_generated/xzGraphFolium.pdf')
