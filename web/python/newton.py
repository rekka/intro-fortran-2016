import math
import numpy as np
import matplotlib
matplotlib.use('SVG')

import matplotlib.pyplot as plt


fig, ax = plt.subplots()

g = lambda x: x**8 - 2.
dg = lambda x: 8. * x**7

x0 = 0.9
x1 = 2.
xs = np.linspace(x0, x1, 100)
ax.plot(xs, g(xs), linewidth=2, label = '$g(y)$')

N = 4
x = 1.9

sx = [x]
# newton's method
for i in range(N):
    x = x - g(x)/dg(x)
    sx.append(x)

sx = np.array(sx)
sy = g(sx)

ax.scatter(sx, sy)

for x in sx[:-1]:
    ax.plot(xs, dg(x) * (xs - x) + g(x), linestyle='dashed')

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

ax.set_xticks(sx.tolist() + [2.**(1./8.)])
ax.set_xticklabels(['$y_{}$'.format(i) for i in range(N+1)] + ['$y_\infty$'])
ax.set_yticks([0.])
ax.set_yticklabels(['$0$'])
ax.set_xlim((x0, x1))
m = np.min(g(xs))
M = np.max(g(xs))
h = 0.1 * (M - m)
ax.set_ylim((m - h, M + h))
ax.set_xlabel('$y$')
ax.xaxis.set_label_coords(1.0, -0.025)
ax.set_ylabel('$g$', rotation=0)
ax.yaxis.set_label_coords(-0.025, 1.0)

ax.legend(frameon=False, loc='upper right')

plt.savefig('../img/newton.svg')
# plt.show()
