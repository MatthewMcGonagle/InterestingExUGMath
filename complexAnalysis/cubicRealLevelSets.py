import numpy as np
import matplotlib.pyplot as plt

def plotRealLevelSets(z, cubic, critical_points):
    w = cubic(z)
    f = np.real(w)
    critical_values = np.real(cubic(critical_points))
    levels = np.linspace(np.min(f), np.max(f), 10)
    if min(critical_values) < max(critical_values):
        between_levels = np.linspace(min(critical_values), max(critical_values), 7)
    else:
        between_levels = [min(critical_values)]
    levels = np.sort(np.concatenate(
        [levels, between_levels]))

    cs = plt.contour(x, y, f, levels = levels)
    return cs

    
x = y = np.linspace(-2, 2, 100)
x, y = np.meshgrid(x, y)
z = x + 1j * y

# Case of branch points on different level sets.
def cubic(z):
    return z**3 - 3 * z

fig = plt.figure()
cs = plotRealLevelSets(z, cubic, critical_points = np.array([-1, 1]))
fig.colorbar(cs)
plt.title('Re($z^3 - 3z$)')
plt.xlabel('Re(z)')
plt.ylabel('Im(z)')
plt.tight_layout()
plt.savefig('_generated/cubicLevelSetBranchDiff.pdf')

# Case of connected level set for branch points.
def cubic(z):
    return (z**3 - 3 * z) * 1j 

fig = plt.figure()
cs = plotRealLevelSets(z, cubic, critical_points = np.array([-1, 1]))
fig.colorbar(cs)
plt.title('Re($iz^3 - 3iz$)')
plt.xlabel('Re(z)')
plt.ylabel('Im(z)')
plt.savefig('_generated/cubicLevelSetBranchSame.pdf')
