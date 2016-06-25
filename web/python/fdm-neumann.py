import math
import numpy as np
import matplotlib
matplotlib.use('SVG')

import matplotlib.pyplot as plt


fig, ax = plt.subplots()

N = 5
M = 6
h = 1. / M

grid = [(h * i, h * j) for i in range(0, M + 1) for j in range(0, N + 1)]

sx, sy = zip(*grid)
ax.scatter(sx, sy, marker='+')

boundary = [(0, h * j) for j in range(1, N + 1)] + [(1., h * j) for j in range(1, N + 1)]
ax.scatter(*zip(*boundary), marker='s')

outside= [(-h, h * j) for j in range(0, N + 1)] + [(1. + h, h * j) for j in range(0, N + 1)]
ax.scatter(*zip(*outside), marker='*', color='gray')

initial = [(h * i, 0) for i in range(0, M + 1)]
ax.scatter(*zip(*initial), marker='D')

xi, ti = h * 2, h * 2

stencil = [(xi, ti), (xi - h, ti - h), (xi, ti - h), (xi + h, ti - h)]
stx, sty = zip(*stencil)
ax.scatter(stx, sty, marker='o')

stencil_labels = ['$(x_k, t_{i+1})$', '$(x_{k -1}, t_{i})$', '$(x_{k}, t_{i})$', '$(x_{k + 1}, t_{i})$']
for i in range(len(stencil)):
    x, y = stencil[i]
    ax.annotate(stencil_labels[i], xy=stencil[i], xytext=(x + 0.01, y + (- 0.05 if (i > 0) else 0.03)))

for i in range(1, len(stencil)):
    x, y = stencil[i]
    xx, yy = stencil[0]
    dx = xx - x
    dy = yy - y
    ax.annotate("", xy=(xx - dx * 0.1, yy - dy * 0.1), xytext=(x + dx * 0.1, y + dy * 0.1),
                arrowprops=dict(arrowstyle="-|>", color='black'))

# boundary stencil
xi, ti = h * M, h * 2

stencil = [(xi, ti), (xi - h, ti - h), (xi, ti - h), (xi + h, ti - h)]
stx, sty = zip(*stencil)
ax.scatter(stx[1:2], sty[1:2], marker='o')

stencil_labels = ['$(x_{M+1}, t_{i+1})$', '$(x_{M}, t_{i})$', '$(x_{M+1}, t_{i})$', '$(x_{M+2}, t_{i})$']
for i in range(len(stencil)):
    x, y = stencil[i]
    ax.annotate(stencil_labels[i], xy=stencil[i], xytext=(x + 0.01, y + (- 0.05 if (i > 0) else 0.03)), color=('gray' if i == 3 else 'black'))

for i in range(1, len(stencil)):
    x, y = stencil[i]
    xx, yy = stencil[0]
    dx = xx - x
    dy = yy - y
    ax.annotate("", xy=(xx - dx * 0.1, yy - dy * 0.1), xytext=(x + dx * 0.1, y + dy * 0.1),
                arrowprops=dict(arrowstyle="-|>", linestyle=('dashed' if i == 3 else 'solid'), color=('gray' if i == 3 else 'black')))

ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)
ax.spines['left'].set_position('zero')
ax.spines['bottom'].set_position('zero')
ax.xaxis.set_ticks_position('none')
ax.yaxis.set_ticks_position('none')

ax.set_xticks([h * i for i in range(0, M + 1)])
ax.set_xticklabels(["$x_{}$".format(i + 1) for i in range(M+1)])
ax.set_yticks([h * i for i in range(0, N + 1)])
ax.set_yticklabels(["$t_{}$".format(i) for i in range(N+1)])

ax.spines['bottom'].set_bounds(-0.01, 1.01)
ax.spines['left'].set_bounds(-0.01, N * h + 0.01)
ax.set_xlim((0 - 0.05 - h, 1 + 0.05 + h))
ax.set_ylim((0 - 0.05, N * h + 0.05))
ax.set_xlabel('$x$', rotation=0)
ax.xaxis.set_label_coords(1.0, -0.025)
ax.set_ylabel('$t$', rotation=0)
ax.yaxis.set_label_coords(-0.025, 1.0)

plt.savefig('../img/fdm-neumann.svg')
# plt.show()
