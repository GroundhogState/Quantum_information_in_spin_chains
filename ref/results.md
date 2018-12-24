# Contents
<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Contents](#contents)
- [Graph structure](#graph-structure)
	- [Weight distribution](#weight-distribution)
	- [Degree distribution](#degree-distribution)
- [The Laplacian](#the-laplacian)
			- [Properties of the Laplacian](#properties-of-the-laplacian)
	- [Spectral distribution](#spectral-distribution)
	- [Trace distribution](#trace-distribution)
	- [Entropy distributions](#entropy-distributions)
- [Properties of $\aleph$](#properties-of-aleph)
	- [Spectrum](#spectrum)
	- [Trace](#trace)
- [=============================================================================](#)
- [TODO](#todo)
- [Centrality](#centrality)

<!-- /TOC -->

# Graph structure

A graph is a tuple $(V,W)$ of a set of vertices $v \in V, |V|=N$ with a matrix W of *weights*,
$W: V\times V \mapsto \mathbb{R}^{N\times N}$
$W{i,j},i\neq j$ is the mutual information between spin $i$ and $j$, and $W_{i,i}$ has several useful
definitions.



## Weight distribution

Define the *adjacency matrix* $\gimel$ as the matrix $W $ with a zero diagonal, describing only the non-self connections.  


Define the entropy $\Omega$ of a histogram by Jayne's formula for the limiting density of discrete points,

$$
\Omega = - \sum_{i =1,\dots, N} p(x_i) \log p(x_i ) dx_i
$$

Which is the discrete approximation of the entropy of a continuous probability density function, defined on a histogram of $N$ bins with widths $dx_i$.

![](C:\Users\jaker\Documents\ent_loc\dat\ent_data\L13_dat\out\02_Weight_distribution.png)

```
The entropy (see main body) of the weight distribution (top left)
shown versus disorder strength.
Log-probability distributions for the MI of spin pairs (lower left)
and the base-10 logarithm of the MI of spin pairs. (right column),
shown on linear (top row0 and logarithmic (middle row) scales.

```

In the localized phase, the weight distribution is sharply peaked. In the localized phase, the distribution is visible broader, with many more edges at much lower strengths than the localized phase (note the negative log in the horizontal axis). CDF to be included in appendix.




## Degree distribution

Define the *degree* of a node in a graph by the sum of the weights of all the edges connected to it, $\daleth_i = \sum_j \mathcal{\gimel}_{ij}$, i.e the sum of the $i$th row of the adjacency matrix (for undirected graphs, this is also the column sum).


![alt text](https://github.com/GroundhogState/ent_loc/blob/master/fig/01_Degree_distribution.png)

```
Probability distributions for the degree (left)
and the base-10 logarithm of the degree (right),
shown on linear (top row0 and logarithmic (middle row).
Also, the entropy (in Jaynes' sense) of these distrutions (bottom row)
 shown versus disorder strength

```
In the extended phase, most nodes are equally well connected, with some more strongly than the mode. In the extended phase, most degrees are quite weak, reflecting poorly-connected nodes, with a small probability of being more strongly connected. The log-log plot suggests a power-law scaling of the probability of finding a node with a given degree, which is characteristic of scale-free graphs. Notice that for small disorder strength past the onset of localization, the mode of the degree distribution actually increases, suggesting a strengthening of the overall mutual information integration (CLARIFY) in the system.  The degree distribution exhibits a much clearer distinction thann the weight distribution between the localized and extended phases in its density diagram. Moreover, the probability distributions themselves have markedly different shapes, but I propose they are parametrized by a single probability distribution.



# The Laplacian

Define the *Laplacian* of the graph by

$$
L = \daleth - \gimel
$$


One can furnish the definition of $\gimel$ by constructing the *Laplacian* of the graph, defined by
where $\daleth$ is the diagonal matrix whose $ii$th entry is the degree of node $i$.
#### Properties of the Laplacian
* Discretized continuum Laplacian
* Graph partitioning
* Relation to graph Fourier transforms
* the number of zero eigenvalues of $L$ is the number of connected components in the graph}.
* For a disjoint union of $k$ graphs, then, the spectrum of $L$ has a $k$-degenerate null space.
* Equivalently, one can block-diagonalize both $\gimel$ and $L$ with one matrix block for each connected component.

## Spectral distribution

![lapspec](C:\Users\jaker\Documents\ent_loc\dat\ent_data\L13_dat\out\04_Laplacian_spectral_distribution.png)

```
Probability distributions of the eigenvalues of the Laplacian (upper & mid left),
the PDFs of the log of the eigenvalues (upper & mid right),
and the Shannon entropy (lower row) of the distributions versus disorder.
Lighter colours are higher disorder strengths.
What's up with lower right?!
```


Note the similarity to the degree distribution.

## Trace distribution

![tracedist](C:\Users\jaker\Documents\ent_loc\dat\ent_data\L13_dat\out\05_Laplacian_trace_distribution.png)


```
Probability distributions of the trace of the Laplacian (upper & mid left),
the PDFs of the log of the trace (upper & mid right),
and the Shannon entropy (lower row) of the distributions versus disorder.
Lighter colours are higher disorder strengths.
```

## Entropy distributions

![text](C:\Users\jaker\Documents\ent_loc\dat\ent_data\L13_dat\out\03_VN_Entropy_distribution.png)

Probability density of the single-site Von Neumann entropy (upper left),
Density plot of the Von Neumann entropy distribution versus
disorder bandwidth (upper right),
Logscale plot of the PDF of the Von Neumann entropy distribution (lower left),
Shannon entropy of the PDF of the Von Neumann entropy (lower right)
In the upper right, lighter colours are higher density.
Otherwise, more disordered.
# Properties of $\aleph$

Define the matrix $\aleph$ by setting the diagonal elements to the von Neumann entropy of the corresponding spin. $\aleph$ has similar properties to $L$, but $\aleph$ displays richer and more distinct variability, displaying the transformation from a simple unimodal distribution to a varied spectrum with at least five tiers of structure which are not visible in other constructions. The log-spectrum of $\aleph$ also show three distinct regimes across the localization transition.

## Spectrum
![alephspec](C:\Users\jaker\Documents\ent_loc\dat\ent_data\L13_dat\out\06_Aleph_spectral_distribution.png)
```
Probability distributions of the eigenvalues of Aleph  (upper & mid left),
the PDFs of the log of the eigenvalues (upper & mid right),
and the Shannon entropy (lower row) of the distributions versus disorder.
Lighter colours are higher disorder strengths.
```


## Trace

![alephtr](C:\Users\jaker\Documents\ent_loc\dat\ent_data\L13_dat\out\07_Aleph_trace_distribution.png)


```
Probability distributions of the trace of the Aleph (upper & mid left),
the PDFs of the log of the trace (upper & mid right),
and the Shannon entropy (lower row) of the distributions versus disorder.
Lighter colours are higher disorder strengths.
```
# =============================================================================

# TODO
*  Centrality measures
*  replace images with web links
*  Correlation lengths & graph linear algebra - length scales
*  Scaling
*  Find appropriate distribution form
*  Plot scale parameters vs W & guess functional form
*  Pick a reference length & apply scaling transform
*  Extend to bose hubbard model


# Centrality
One can phrase the question of centrality in other ways. For example, given a node of high degree, how likely is it to be connected to other nodes of high degree? Figure 3 shows the PDF and CDF of the weighted mean of neighbours. $\mu$ compares the mean of the degree of the neighbours of $i$ to the mean degree of all nodes other than $i$.  A value of $\mu_i=0$ shows that system $i$ is poorly connected, as either it has neighbours of low degree or it has only weak connections or both. A large $\mu_i$ indicates that the nodes connected strongly to system $i$ are also strongly connected relative to the mean, and so form a central cluster in the global system. For the localized phase, the distribution of $\mu$ peaks sharply at 1, showing that almost all nodes are equally central - the graph is nearly uniformly completely connected.
