import math
import numpy as np
import matplotlib
matplotlib.use('SVG')

import matplotlib.pyplot as plt


x1 = 2.
x = np.linspace(0, x1, 100)
plt.plot(x, np.exp(x), linewidth=2)

# dashes = [10, 5, 100, 5]  # 10 points on, 5 off, 100 on, 5 off
# line.set_dashes(dashes)

N = 4
h = x1 / N

sx = np.linspace(0, x1, N + 1)
sy = [(1 + h)**n for n in range(N + 1)]

plt.plot(sx, sy)
plt.scatter(sx, sy)

for i in range(1, N):
    plt.plot(x, np.exp(x) * sy[i] / math.exp(sx[i]), '--')

plt.savefig('../img/euler.svg')
