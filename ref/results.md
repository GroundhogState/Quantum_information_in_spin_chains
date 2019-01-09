---
title: "Graphs and MBL"
author: Jacob Ross
date: Dec 2018
geometry: margin=2cm
output: pdf_document
---


# Contents

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Contents](#contents)
- [Graph structure](#graph-structure)
	- [Weight distribution](#weight-distribution)
	- [Degree distribution](#degree-distribution)
- [The Laplacian](#the-laplacian)
			- [Properties of the Laplacian](#properties-of-the-laplacian)
	- [Spectral distribution](#spectral-distribution)
	- [Entropy distributions](#entropy-distributions)
	- [Trace distribution](#trace-distribution)
- [Properties of $\aleph$](#properties-of-aleph)
	- [Spectrum](#spectrum)
	- [Trace](#trace)
- [====](#)
- [TODO](#todo)

<!-- /TOC -->

# Graph structure
### Construction of graphs

A *graph state* usually refers to a specific construction in quantum computing theory, where a state of several qubits is constructed from a given graph by applying CNOT gates between qubits where an edge is present between the corresponding nodes in the graph. In this work I seek a reversal of this definition, whereby one constructs a graph from a given arbitrary state. The quantum mutual information captures both classical and quantum correlations and provides rich detail into the structure of many-body states. The quantum mutual information of a pair of systems $A$ and $B$ is defined by the sub-additivity of the von Neumann entropy, $\mathcal{I}_{AB} = \mathcal{S}_A + \mathcal{S}_B - \mathcal{S}_{AB}$ ,

Where $\mathcal{S}_{(B)}$ is the von Neumann entropy of the reduced density matrix of subsystem A (B), and $\mathcal{S}_{AB}$ is the von Neumann entropy of the complete system. The QMI is not an entanglement measure but it does have the advantage of being completely basis independent, and instead provides a bound on the degree of possible correlation observable between two systems.

Given the mutual information between each subsystem of a many-body system, define
$$
W_{ij} = S(\rho_i) + S(\rho_j) - S(\rho_{ij})
$$
whose positive off-diagonal $i,j$th elements are the mutual information between subsystems $i$ and $j$. By the additive property of independent systems, the diagonal entries are zero. In the parlance of graph theory, one then obtains a *weighted adjacency matrix*.


I apply this construction to the Pal-Huse model, a variation of the Heisenberg spin chain. The model is given by the Hamiltonian

$$
\mathcal{H} = J \sum_{i,j} \hat{\vec{S}}_i\hat{\vec{S}}_j + \mathcal{W}\sum_i h_i \hat{S}_{i}^{z}
$$
Where J is the coupling strength between nearest neighbours (set to 1 in this work to fix an energy scale), and $\mathcal{W}$ is the scaling parameter for the on-site transverse field whose local values are given by the $h_i$, randomly drawn from the interval $[-1,1]$. I sample eigenstates from the middle of the spectrum.




Much extant work studies the variance of certain intensive parameters across the MBL transition. In this work, and indeed in the present literature, many of the distributions under study are heavily skewed, and so the mean and variance alone are not enough characterize the distribution. I attempt to use the *entropy* of the distributions as a measure of distribution 'width' which is agnostic about the moments of the probability distributions. Define the entropy $\Omega$ of a histogram by Jayne's formula for the limiting density of discrete points. (NB: This measure scales with the choice of bin size, and so the absolute values of the vertical scales should be read as arbitrary.)

## Weight distribution

Define the *adjacency matrix* $\gimel$ as the matrix $W$ with a zero diagonal, describing only the non-self connections.  




| ![weight_distribution](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/02_Weight_distribution.png) |
|:--:|
**Figure 1.** Probability distribution for the QMI (and the log thereof) between spin pairs, and the entropy of the PDF of the QMI as computed by the limiting density of discrete points. Note the negative log on the horizontal axis in the left column. In this and all plots, lighter colours are higher disorder bandwidths, and are matched between plots.|

In the ergodic phase, the QMI between arbitrary pairs is drawn from a narrow distribution. In the localized phase, the distribution of QMI broadens considerably. I suspect the rise in *larger* QMI values corresponds to greater correlations on small length scales, and the tails of the distribution to the drop in long-range correlations. I haven't yet looked at QMI versus distance, but the next results corroborate this interpretation:






## Degree distribution

Define the *degree* of a node in a graph by the sum of the weights of all the edges connected to it, $\daleth_i = \sum_j \mathcal{\gimel}_{ij}$, i.e the sum of the $i$th row of the adjacency matrix (for undirected graphs, this is also the column sum). The degree is a simple of connectedness of a node, and in this context is (loosely) a measure of how correlated a node is with the *entire system*.


|![degree_dist](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/01_Degree_distribution.png)|
|:--:|
**Figure 2** Probability distributions for the degree (left) and the base-10 logarithm of the degree (right),shown on linear (top row0 and logarithmic (middle row). Also, the entropy (in Jaynes' sense) of these distrutions (bottom row) shown versus disorder strength.|

In the ergodic phase, most nodes are equally well connected. The log-log plot suggests a power-law scaling of the probability of finding a node with a given degree, which is characteristic of scale-free graphs. In the localized phase, the degrees are generally weaker, consistent with a decay of entanglement with the rest of the system. A multipartite distribution is clearly visible, with a sharp cutoff at $\lambda=2$. This is the bounding value for the QMI of a pair of spins, and QMI greater than this suggests a spin is *very* strongly correlated with others. However, the low probability of such connections, as well as the higher probability of lower QMI (see figure 1) in the localized phase are consistent with the formation of localized entanglement clusters. One wonders whether the cluster size distribution could be extracted from this data.


## Entropy distributions
|![VN_entropy](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/05_Single-site_entropy.png)|
|:--:|
Probability density of the single-site Von Neumann entropy (upper left), logscale (upper right), Logscale plot of the PDF of the log of the Von Neumann entropy (lower left), Shannon entropy of the PDF of the Von Neumann entropy (lower right).|

In the ergodic phase, the spins are overwhemingly likely to have near-unit von Neumann entropy, and therefore highly entangled. The QMI is employed as a lens to find out *where* this entanglement is - how distributed the quantum state of a spin is among the non-local degrees of freedom within the rest of the chain. In the localize phase, spins are more likely to have very low (even near-zero) entropy, suggesting that they could almost be factored out of the global quantum state. The localized phase has a distinct 'hump' just above zero entropy, and a thick tail trailing towards 1, showing that most spins are generally less entangled, but still bound in nonlocal subspaces. The 'hump' is also visible in the degree distribution. This is not surprising, as a nonzero single-spin entropy in a pure state reflects entanglement, and so there should be a correlation between degree (total QMI) and the von Neumann entropy (see later section)

The microscopic statistics of the entropy and the QMI are consistent with the construction of l-bits and the existence of clusters of entangled spins. The prospect of applying graph factorization to the state graph requires another line of inquiry, which directly examines the length scales of entanglement within the system. One way to do this is a recursive cluster-building algorithm (as has been explored in a recent Arxiv preprint). Another is to consider a cornerstone of the graph partitioner's toolkit: The graph Laplacian.

# The Laplacian

Define the *Laplacian* of the graph by

$$
L = \daleth - \gimel
$$


One can furnish the definition of $\gimel$ by constructing the *Laplacian* of the graph, defined by
where $\daleth$ is the diagonal matrix whose $ii$th entry is the degree of node $i$.
#### Properties of the Laplacian
* The graph Laplacian is the lattice approximation to the continuous Laplacian
* The graph laplacian is positive semidefinite, with a nullspace of dimension equal to the number of disjoint subgraphs within a graph. Thus, a connected graph has one zero eigenvalue.
* By analogy with the continuous Laplacian, which is diagonal in the Fourier basis, the eigenstates of the graph Laplacian are commonly referred to as the "fourier modes" of a function on the nodes of a graph. The eigenvalues are thus the (real) amplitudes of these modes.


## Spectral distribution

|![laplacian_spectrum](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/03_Laplacian_spectral_distribution.png)|
|:--:|
Probability distributions of the eigenvalues of the Laplacian (upper row), the PDF of the log of the eigenvalues (lower left), and the Shannon entropy (lower right) of the distributions versus disorder. |



## Trace distribution

|![laplacian_trace](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/04_Laplacian_trace_distribution.png)|
|:--:|
Probability distributions of the trace of the Laplacian (upper left), the PDFs of the log of the trace (upper right), and the Shannon entropy (lower row) of the distributions versus disorder. Lighter colours are higher disorder strengths.|

The trace of the Laplacian - by analogy, the total intensity of the lattice function - also shows a clear change across the localization transition. Something weird is going on in the lower right, though...

The large body of literature on graph laplacians would enable straightforward study of this object. In particular, the use of the Laplacian eigenvectors to approximate graph partitions may be related to the support of l-bits/Q-LIOMs. However, I have not made any advances towards this. There are some interpretational issues also;
* The physical meaning 'degree' of a node is not something I've worked out, and
* It's not clear what function the Laplacian is decomposing in the sense of a Fourier transform
so the Laplacian itself is physically ambiguous.


# Properties of $\aleph$

The final object I describe here is a variation on the Laplacian, with a better information-theoretic grounding. Define the matrix $\aleph$ by setting the diagonal elements of W to *twice* the von Neumann entropy of the corresponding spin$^*$  From this construction one can also retrieve the von Neumann entropy of any two-body density matrix. $\aleph$ has similar properties to $L$, but $\aleph$ displays richer and more distinct variability. The definition can be extended to a higher-rank tensor, which contains all of the (exponentially many) QMI between arbitrary sub-partitions of the system. Studying this extended $\aleph$ is prohibitively expensive given my current methods.

$^*$ The choice of *twice* the onsite entropy might seem strange, but in some of my other investigations (not complete enough to describe here), this definition appears to be 'correct' in that several properties become much clearer & consistent than, say, setting the diagonal to just the on-site entropy. More on this later perhaps.

## Spectrum

|![aleph_spectrum](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/06_Aleph_spectral_distribution.png)|
|:--:|
Probability distributions of the eigenvalues of $\aleph$  (upper row), the PDF of the log of the eigenvalues (mid left ), and the Shannon entropy (lower left & mid right) of the PDFs versus disorder.|

The spectrum shows a clear and distinct transition with increasing disorder. The off-diagonal elements, the QMI weights, alter the spectrum from the von Neumann entropy distribution to a remarkable 'tiered' structure, which resembles a combination of the degre

Currently I do not have a clear interpretation of this data, but the dramatic tiered structure of the (log) spectrum in the localized phase is in stark contrast with the narrow peak in the ergodic phase. The data is also visually much 'cleaner' than the Laplacian spectrum for the same data set.

## Trace

|![aleph_trace](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/07_Aleph_trace_distribution.png)|
|:--:|
Probability distributions of the trace of the Aleph (upper left), the PDF of the log of the trace (upper right), and the Shannon entropy (lower row) of the distributions versus disorder.|

The trace of $\aleph$ has a much clearer interpretation: The sum of the single-site von Neumann entropies. For a product of pure states, this is zero. Indeed there is a clear trend towards smaller traces with increasing disoder bandwidth. The trace of $\aleph$ is therefore just $2L$ times the average von Neuman entropy, which is clearly correlated with 'total' entanglement for a multipartite pure state, but I have yet to work through formally.

## Missing information

Observe that for a pure bipartite system,
$$
I_{AB} = S_A + S_B - S_{AB}
$$
$$
\implies S_{AB} = S_A + S_B - I_{AB} = 0
$$

hence the sum of the reduced entropies minus the QMI must be zero. For multipartite systems,  there should exist a hierarchy of conditions whereby the susbsystem entropies, the pairwise QMI, and the QMI between tuples of system should all sum to the total system entropy: Zero, in a pure state.

Therefore define the 'missing' information as the difference $\sum_i S_i - \sum_{ij} I_{ij}$, which is the amount of information bound up in higher-order correlations between spins.


|![aleph_trace](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/08_TMI.png)|
|:--:|
The greater the missing information, the more information is tied up in the higher-order correlations. For low disorder, more information is bound in higher-order correlations between clusters of spins. For strong disorder, much more of the entropy is bound up in pairwise correlations, suggesting that the state graph is more easily (approximately) factorized.|


# Other investigations

## Visualizing graph matrices

The structure of the matrices themselves - in partcular $\aleph$ with its PSD entries - is an illumuniating exercise.

Here are some examples, where lighter colours are larger entries, of the $\aleph$ for the localized and extended phases on 13 sites with periodic boundary conditions:

|![aleph_show](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/09_aleph_show.png)|
|:--:|
Entries of $\aleph$, for $\mathcal{W} = 0.1,1,3,5$ (increasing down the page), and for the even-numbered eigenstates $n=0,2,4,6,8,10$ (increasing to the right) for a fixed disorder realization.|


|![log_aleph_show](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/10_log_aleph_show.png)|
|:--:|
Log10 of entries of $\aleph$, for $\mathcal{W} = 0.1,1,3,5$ (increasing down the page), and for the even-numbered eigenstates $n=0,2,4,6,8,10$ (increasing to the right) for a fixed disorder realization.|

# ====

# TODO
* Graph structure
	* Centrality measures
	* Fielder vectors/partitions        
	* system composition as (generalized) graph product
* Connecting to contemporary studies
	* Area/Volume law
	* L-bits ~ decomposition into (approximate) union of subgraphs?
* Length Scaling
	* Plot distribution entropies vs W for various L on same plot
* Extensions
	* bose hubbard model
	* extended $\aleph$
		* two-body reduced entropies
  * Relation to correlation functions
  * Correlation lengths & graph linear algebra - length scales
* Other...
	* Time evolution of $\aleph$
	* What is the interpretation of these spectra?
	* disorder Temperature?
