import math
import numpy as np
import matplotlib
matplotlib.use('SVG')

import matplotlib.pyplot as plt


fig, ax = plt.subplots()

a = 0.
b = 1.

f = lambda x: 5. *x
u = lambda x: -5. * x**3 / 6. + 5. * x / 6. + 0. * x * (1- x) / 2 + (b - a) * x + a

x0 = 0.
x1 = 1.
xs = np.linspace(x0, x1, 100)
ax.plot(xs, u(xs), linewidth=2, label = '$u(x)$')


ax.plot(xs, f(xs), linestyle='dashed', label = '$f(x)$')

ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)
ax.spines['bottom'].set_bounds(x0, x1)
ax.spines['bottom'].set_position('zero')
plt.tick_params(
    axis='y',
    which='both',
    left='on',
    right='off',
    labelleft='on')
ax.xaxis.set_ticks_position('bottom')

ax.set_xlim((x0, x1))
m = np.min(u(xs))
M = np.max(u(xs))
h = 0.1 * (M - m)
ax.set_ylim((m - h, M + h))
ax.set_xlabel('$x$')
ax.xaxis.set_label_coords(1.0, -0.025)
ax.set_ylabel('$y$', rotation=0)
ax.yaxis.set_label_coords(-0.025, 1.0)

ax.legend(frameon=False, loc='upper right')

plt.savefig('../img/simple_poisson.svg')
# plt.show()
