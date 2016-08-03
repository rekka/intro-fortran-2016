---
title: 'Lecture 16: Final report problems'
---

**[日本語へ](#japanese)**


# English

Write a Fortran code for the following problems, and upload the requested files to
the Acanthus portal in __`テスト・アンケート　→　Final report`__.

The submission deadline is __Thursday, August 4th, 14:45__.

When preparing the final report, you can use any resources provided by
these lecture notes, including code examples. However, do not discuss the
solution or the code with other students, and do not use other students'
code.

The maximum score is 50 points.

## Problem 1 (20 points)

Use Newton's method to find the numerical solution $x$ of the following
equation^[The solution of this equation $x(y)$ is called the [Lambert
W-function](https://en.wikipedia.org/wiki/Lambert_W_function).] for given $y$:

$$
y = x e^x.
$$

Use $5$ iterations of Newton's method with initial guess $x_0 = \ln
y$ (function `log` in Fortran).

Set
$$
y_0 = 1 + (\text{the last 2 digits of your student ID number
(学籍番号)}).
$$

Compute the values of $x(y_i)$ for $y_i = y_0 + i$, $i = 0, \ldots, 100$.
Plot the values $x(y)$ as a function of $y$ using the values above.

__Upload the code as `newton.f90`.__ The code should compile, and when run, it should
print the values $y_i$, $x(y_i)$ one pair per line in the following form:

```
   1.00000000      0.567143321
   2.00000000      0.852605522
   3.00000000       1.04990888
    ...
```

__Upload the plot as `newton.png`.__
Use __your name in romaji__ as the plot title.
You can use the following code to generate the plot (save the output of
the Fortran program to `sol.dat` first):

```gnuplot
set term pngcairo size 1024,768
set output 'newton.png'
set title 'your name'

plot 'sol.dat' with lines

set output
```

## Problem 2 (10 points)

Compute the discrete $l^2$-distance and the maximum distance between the values of $\sin \pi x$ and
$\cos \pi x$ at points $x_1, \ldots, x_N$, defined as $x_k = k h$,
where $h = 1/N$. The _discrete $l^2$-distance_ is defined as

$$
d_2 := \sqrt{\frac 1N \sum_{k = 1}^N |\sin(\pi x_k) - \cos(\pi x_k)|^2}.
$$

The _maximum distance_ is defined as

$$
d_\infty := \max \{|\sin(\pi x_k) - \cos(\pi x_k)|: 1 \leq k \leq N\}.
$$

Use

$$
N = 100 + (\text{the last 3 digits of your student ID number (学籍番号)}).
$$

__Upload the code as `dist.f90`.__ The code should compile, and when run, it should
print the value of the discrete $l^2$ distance $d_2$ and the maximum
distance $d_\infty$ in the following form ($d_2$ on the first line, the
actual numbers are different):

```
4.2341
0.5234
```

## Problem 3 (20 points)

Solve the Dirichlet problem for the heat equation

$$
\begin{align}
\left\{
\begin{aligned}
u_t(x, t) &= u_{xx}(x, t),       && 0 < x < 1, 0 < t < t_1,\\
  u(x, 0) &= u_0(x),           && 0 < x < 1,       \\
  u(0, t) &= a_0,                && 0 < t < t_1,           \\
  u(1, t) &= a_1,                && 0 < t < t_1,
\end{aligned}
\right.
\label{heat}
\end{align}
$$

using the
Crank-Nicholson method

$$
\begin{align*}
u_{i+1, k} = u_{i, k} &+ \frac \tau {2h^2} (u_{i + 1, k + 1} - 2 u_{i + 1, k} + u_{i + 1, k - 1})\\
                      &+ \frac \tau {2h^2} (u_{i, k + 1} - 2 u_{i, k} + u_{i,  k - 1})
\end{align*}
$$

Let us for simplicity denote $v_k = u_{i+1,k}$ and $u_k = u_{i,k}$.
Fix parameters $h > 0$, $\tau > 0$, $x_k = (k - 1) h$, $t_i = \tau i$,
$1 \leq k \leq M+1$, $0 \leq i \leq N$.
To find the approximate solution at time $t_{i+1}$ (the unknown values $v_2,
\ldots, v_M$), we need to
find the solution of the linear system:

$$
\begin{align*}
(1 + 2 c) v_{2} - c v_{3} &= 2 c a_0 + (1- 2c) u_2 + c u_3\\
-c v_{2} + (1 + 2 c) v_{3} - c v_{4} &=  c u_2 + (1 - 2c) u_3 + c u_4\\
&\vdots\\
-c v_{k - 1} + (1 + 2 c) v_{k} - c v_{k + 1} &= c u_{k-1} + (1 - 2c) u_k
 + c u_{k+1}\\
&\vdots\\
-c v_{M - 2} + (1 + 2 c) v_{M - 1} - c v_{M} &= c u_{M-2} + (1 - 2c)
 u_{M-1}
 + c u_M\\
-c v_{M - 1} + (1 + 2 c) v_{M} &= c u_{M-1} + (1 - 2c) u_M + 2 c a_1
\end{align*}
$$
where $c := \frac{\tau}{2h^2}$, and $a_0, a_1$ are given boundary data in
$\eqref{heat}$.

Once you compute the right-hand side and store it in an array, you
can use the function `tridial_solve` that we already implemented in
[`implicit_heat.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec14/implicit_heat.f90)
to
find the array $v$ since the matrix of the system is tridiagonal.

Use the following parameters: $M = 64$, $h = 1/M$, $t_1 = 0.1$,
$\tau = h$, $N = \lfloor t_1 / \tau \rfloor$ (see ^[The
[floor](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions) of $t_1 /
\tau$]), $a_0 = -1$, $a_1 = 2$,

$$
u_0(x) = -\cos (3 \pi x) + x.
$$

__Upload the code as `crank.f90`.__ The code should compile, and when run, it should
print the values of the solution, one point per line, with
individual time steps separated by empty lines:

```
t_0   x_1       u_{0, 1}
t_0   x_2       u_{0, 2}
...
t_0   x_{M+1}   u_{0, M+1}


t_1   x_1       u_{1, 1}
t_1   x_2       u_{1, 2}
...
t_1   x_{M+1}   u_{1, M+1}

t_2   ...
...

```

__Plot the graph of the solution using gnuplot and upload it as
`crank.png`.__

Use __your name in romaji__ as the title.
You can use the following gnuplot commands to produce a 3D plot.

```gnuplot
set term pngcairo size 1024,768
set output 'crank.png'
set title 'your name'

splot 'sol.dat' with lines

set output
```

Here `sol.dat` is a file where you stored the output of your program.


_Hint._ This is a simple modification of
[`implicit_heat.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec14/implicit_heat.f90).


# Japanese

以下の問題では,Fortranのプログラムコードを書き,
要求されたファイルをアカンサスポータル __`テスト・アンケート → Final
report`__ にアップロードしなさい.

__提出期限は8月4日14:45です__.

最終レポートの作成の際,本講義で用いた資料を参考にして構いません.
ただし,他の学生との相談,他の学生のコピーはしてはいけません.

50点満点

## 問題 1 (20点)


ニュートン法(Newton's method)を用いて以下の方程式
^[この方程式の解$x(y)$は[ランベルトのW関数](https://ja.wikipedia.org/wiki/ランベルトのW関数)
と呼ばれる]
の数値解$x$を求めなさい.$y$は与えられたものとする.

$$
y = x e^x.
$$

初期値を$x_0=\ln y$として,$5$回反復のニュートン法を用いなさい.
($\ln$はFortranでは関数`log`を用いる)

$$
y_0 = 1 + (\text{学籍番号の下二桁}).
$$
として,

$x(y_i)$ for $y_i = y_0 + i$, $i = 0, \ldots, 100$を計算しなさい.
また,その結果を用いて$x(y)$の値を$y$の関数としてプロットしなさい.

__`newton.f90`をアップデートしなさい.__
そのコードをコンパイル後,実行した際,$y_i$, $x(y_i)$の値が以下のように出力されればよい:

```
   1.00000000      0.567143321
   2.00000000      0.852605522
   3.00000000       1.04990888
    ...
```

__`newton.png`をアップロードしなさい.__
プロットのタイトルに __自分自身の名前(ローマ字)__ を用いなさい.
プロットのタイトルの設定,pngファイルの作成は,以下のコードを参考にするとよい.
(以下のコードでは,Fortranプログラムの出力を`sol.dat`で実行したものとしている.)

```gnuplot
set term pngcairo size 1024,768
set output 'newton.png'
set title 'your name'

plot 'sol.dat' with lines

set output
```

## 問題 2 (10点)

$\sin \pi x$と$\cos \pi x$の離散$l^2$距離$d_2$と最大距離$d_\infty$を計算しなさい.
ただし, $x_1, \ldots, x_N$, defined as $x_k = k h$で, $h=1/N$とする.
$d_2$と$d_\infty$はそれぞれ以下のように定める.

$$
d_2 := \sqrt{\frac 1N \sum_{k = 1}^N |\sin(\pi x_k) - \cos(\pi x_k)|^2}.
$$

$$
d_\infty := \max \{|\sin(\pi x_k) - \cos(\pi x_k)|: 1 \leq k \leq N\}.
$$

$$
N = 100 + (\text{学籍番号の下三桁}).
$$
を用いなさい.

__`dist.f90`をアップロードしなさい.__
そのコードをコンパイル後,実行した際,離散$l^2$距離$d_2$と最大$d_\infty$の値が以下のように出力されればよい($d_2$は一行目):

```
4.2341
0.5234
```


## 問題 3 (20点)

熱方程式のディリクレ問題(Dirichlet problem)を解きなさい

$$
\begin{align}
\left\{
\begin{aligned}
u_t(x, t) &= u_{xx}(x, t),       && 0 < x < 1, 0 < t < t_1,\\
  u(x, 0) &= u_0(x),           && 0 < x < 1,       \\
  u(0, t) &= a_0,                && 0 < t < t_1,           \\
  u(1, t) &= a_1,                && 0 < t < t_1,
\end{aligned}
\right.
\label{heatj}
\end{align}
$$

クランク-ニコルソン法(Crank-Nicholson method)を用いる.

$$
\begin{align*}
u_{i+1, k} = u_{i, k} &+ \frac \tau {2h^2} (u_{i + 1, k + 1} - 2 u_{i + 1, k} + u_{i + 1, k - 1})\\
                      &+ \frac \tau {2h^2} (u_{i, k + 1} - 2 u_{i, k} + u_{i,  k - 1})
\end{align*}
$$

簡単のために, 以下では$v_k = u_{i+1,k}$, $u_k = u_{i,k}$と書く.
パラメータを次のように固定する:
$h > 0$, $\tau > 0$, $x_k = (k - 1) h$, $t_i = \tau i$, $1 \leq k \leq M+1$, $0 \leq i \leq N$.
時刻$t_{i+1}$での近似解(未知数$v_2,\ldots, v_M$)を求めるために, 次の線形方程式の解を求める必要がある.

$$
\begin{align*}
(1 + 2 c) v_{2} - c v_{3} &= 2 c a_0 + (1- 2c) u_2 + c u_3\\
-c v_{2} + (1 + 2 c) v_{3} - c v_{4} &=  c u_2 + (1 - 2c) u_3 + c u_4\\
&\vdots\\
-c v_{k - 1} + (1 + 2 c) v_{k} - c v_{k + 1} &= c u_{k-1} + (1 - 2c) u_k
 + c u_{k+1}\\
&\vdots\\
-c v_{M - 2} + (1 + 2 c) v_{M - 1} - c v_{M} &= c u_{M-2} + (1 - 2c)
 u_{M-1}
 + c u_M\\
-c v_{M - 1} + (1 + 2 c) v_{M} &= c u_{M-1} + (1 - 2c) u_M + 2 c a_1
\end{align*}
$$
ただし, $c := \frac{\tau}{2h^2}$とし, $a_0, a_1$は$\eqref{heatj}$で与えられた境界値とする

まず,線形方程式の右辺を計算し,その値を配列に格納する.
今,線形方程式の行列は三重対角行列なので,$v$を求めるために,`tridial_solve`(既に
[`implicit_heat.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec14/implicit_heat.f90)
で実装済み)を用いることができる.

次のパラメータを用いなさい: $M = 64$, $h = 1/M$, $t_1 = 0.1$,
$\tau = h$, $N = \lfloor t_1 / \tau \rfloor$ (see ^[ $t_1 /
\tau$の[床関数](https://ja.wikipedia.org/wiki/%E5%BA%8A%E9%96%A2%E6%95%B0%E3%81%A8%E5%A4%A9%E4%BA%95%E9%96%A2%E6%95%B0)]), $a_0 = -1$, $a_1 = 2$,

$$
u_0(x) = -\cos (3 \pi x) + x.
$$

__`crank.f90`をアップロードしなさい__
そのコードをコンパイル後,実行した際,解の値が以下のように出力されればよい(時間ステップを空白の一行で区切る):

```
t_0   x_1       u_{0, 1}
t_0   x_2       u_{0, 2}
...
t_0   x_{M+1}   u_{0, M+1}


t_1   x_1       u_{1, 1}
t_1   x_2       u_{1, 2}
...
t_1   x_{M+1}   u_{1, M+1}

t_2   ...
...

```

__gnuplotを用いて解のグラフをプロットし,`crank.png`をアップロードしなさい__

タイトルには __自分自身の名前(ローマ字)__ を用いなさい.
3Dプロットのやり方などは,以下のgnuplotのコマンドを参考にすればよい.

```gnuplot
set term pngcairo size 1024,768
set output 'crank.png'
set title 'your name'

splot 'sol.dat' with lines

set output
```

ここでは,`sol.dat`がFortranの出力ファイル名である.


_ヒント._ [`implicit_heat.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec14/implicit_heat.f90)を少しの修正するだけ.
