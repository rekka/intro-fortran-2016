import math
import numpy as np
import matplotlib
matplotlib.use('SVG')

import matplotlib.pyplot as plt


fig, ax = plt.subplots()

x1 = 2.
x = np.linspace(0, x1, 100)
ax.plot(x, np.exp(x), linewidth=2, label = '$x(t)$')

# dashes = [10, 5, 100, 5]  # 10 points on, 5 off, 100 on, 5 off
# line.set_dashes(dashes)

N = 4
h = x1 / N

sx = np.linspace(0, x1, N + 1)
sy = [(1 + h)**n for n in range(N + 1)]


ax.plot(sx, sy, marker='.', markersize=10, label='$x_i$')

for i in range(1, N):
    ax.plot(x, np.exp(x) * sy[i] / math.exp(sx[i]), '--')

# ax.spines['left'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)
ax.spines['bottom'].set_bounds(0, x1)
# ax.yaxis.set_ticks_position('left')
plt.tick_params(
    axis='y',
    which='both',
    left='on',
    right='off',
    labelleft='off')
ax.xaxis.set_ticks_position('bottom')
ax.set_xticks(sx)
ax.set_xticklabels(["$t_{}$".format(i) for i in range(N+1)])
ax.set_xlim((0 - 0.05, x1 + 0.05))
ax.set_ylabel('$x$', rotation=0)
ax.yaxis.set_label_coords(-0.025, 1.0)

ax.legend(frameon=False, loc='upper left')

plt.savefig('../img/euler.svg')
