---
title: "Graphs and MBL"
author: Jacob Ross
date: Dec 2018
geometry: margin=2cm
output: pdf_document
---



# Introduction

The following is an exploration of the structure of many-body quantum states. The forward goals of this research Area
* To find a firm footing of the notion of *nonlocal degrees of freedom*;
* To understand the global structure of entangled many-body quantum states;
* To motivate a statistical approach to the stationary and dynamic properties of states of many entangled particles;
* To tease out the relationship between the nonlocal 'ground truth' of large quantum states and their manifestation in local observables
* Broadly speaking, this work looks to entanglement as a way to discuss the ways in which a gestalt emerges from the sum of atomistic pieces, creating something beyond the sum of its parts.

More directly, I intend to experiment with the *graph state* picture of many-body states by inverting the prescription for producing states given graphs. By envisioning a many-body state as a network whose connection strengths are measures of nonlocality, examining the global, hierarchical & statistical structure of these networks, and exploring their dynamics.

I define these graphs by using the quantum mutual information, which characterizes the sub-additivity of quantum entropy

 $$\mathbb{I}_{AB} = \mathcal{S}_A + \mathcal{S}_B - \mathcal{S}_{AB}$$

Where $\mathcal{S}_{(B)}$ is the (base-2) von Neumann entropy of the reduced density matrix of subsystem A (B), and $\mathcal{S}_{AB}$ is the von Neumann entropy of the complete system. The QMI is not an entanglement measure but it does have the advantage of being completely basis independent, and instead provides a bound on the degree of possible correlation observable between two systems. Further, the quantum mutual information can exceed the maximal classical mutual information if and only if the respective subsystems are entangled.

Given the mutual information between each subsystem of a many-body system, define
$$
\mathcal{I}_{ij} = S(\rho_i) + S(\rho_j) - S(\rho_{ij})
$$
whose positive off-diagonal $i,j$th elements are the mutual information between subsystems $i$ and $j$. By the additive property of independent systems, the diagonal entries are zero. In the parlance of graph theory, one then obtains a *weighted adjacency matrix*.

The preceding definition furnishes the graphs with the following properties
* The graph structure, characterized by $\mathcal{I}$, is invariant under local Hamiltonians.
* Two nodes are disconnected if and only if there is no mutual information between them. A product state is therefore equivalent to a completely disconnected graph. Similarly, a product of entangled states is given by a disjoint union of their respective graphs.
* The graph state presents a natural picture for entanglement scaling; the entanglement of a bipartition of a system is measured by the strength of the outgoing connections, which are generally strong at long distances in thermal states and hence produce an extensive scaling. (Caveat: In the below I consider only two-body and, to a limited extent, three-body connections, which does not fully characterize entanglement. )





# Graph states of spin chains

Below I study the Pal-Huse model, given by the Hamiltonian

$$
\mathcal{H} = J \sum_{i,j} \hat{\vec{S}}_i\hat{\vec{S}}_j + \mathcal{W}\sum_i h_i \hat{S}_{i}^{z}
$$
Where J is the coupling strength between nearest neighbours (set to 1 in this work to fix an energy scale), and $\mathcal{W}$ is the scaling parameter for the on-site transverse field whose local values are given by the $h_i$, randomly drawn from the interval $[-1,1]$. I sample eigenstates from the middle of the spectrum, (which is symmetric about the mean).


In the following, I study a periodic chain of nine sites by exact diagonalization. For each $\mathcal{W}\leq10$ there are $~3E^5$ disorder realizations, from each of which I select the 15 eigenstates of lowest abolute value (as the spectrum is symmetric about zero, this is the middle of the spectrum).  I have generated data for chains of length ten to fourteen, but due to the increasing runtime there are necessarily fewer samples. A major bottleneck in this work was the exhaustive computation of reduced density matrices, for which I have built a single-threaded recursive algorithm that achieves an exponential speedup with respect to chain length. I'll describe this in another document.

In this document, I examine the distribution of several attributes of the graph states in the vicinity of the many-body localization transition. Each display dramatic transformations either side of the transition, and a peak in the entropy of the respective distributions at $\mathcal{W}\approx 3$. In this work, and indeed in the present literature, many of the distributions studied are heavily skewed, and so the mean and variance alone are not enough characterize the distribution. I use the entropy of the distributions as a measure of distribution width. Define the entropy $\Omega$ of a histogram by Jayne's formula for the limiting density of discrete points. (NB: This measure depends on the choice of bin size, and so the absolute values of the vertical scales should be read as arbitrary.)

## Pairwise mutual information

The elementary quantity studied is, of course, the mutual information between pairs of spins in the chain. In figure 1, the probability distribution function of the pairwise QMI is displayed. n this and all plots, colours are matched between plots and lighter colours correspond too stronger disorder.

| ![weight_distribution](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/L9/01_Weight_distribution.png) |
|:--:|
**Figure 1.** Probability distribution for the QMI (and the negative log thereof) between spin pairs, and the entropy of the PDF of the QMI as computed by the limiting density of discrete points. |

Some notable features are immediately apparent:
* In the extended phase, the QMI is over likely to be large, approaching the upper bound of $2$. Thus most spins are mutually entangled.
* In the localized phase, the QMI almost vanishes, suggesting that the many-body state is 'almmost' factorizable.
* In both cases, a fraction of the QMI bonds are concentrated precisely at 1. I have no intuition for why this is the case, or the tiered structure evident in the logscale distributions in the localized phase.


## Degree distribution

Define the *degree* of a node in a graph by the sum of the weights of all the edges connected to it, $D_i = \sum_j \mathcal{I}_{ij}$, i.e the sum of the $i$th row of the adjacency matrix. The degree is a simple of connectedness of a node, and in this context is a measure of how correlated a node is with the *entire system*. Because each node can only be entangled with at most $L-1$ others, this is bounded above by $\Omega (L-1)$, where $\Omega$ is the maximum single-site entropy, so the plot below is scaled by $\Omega(L-1)$.

|![degree_dist](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/L9/02_degree_distribtion.png)|
|:--:|
**Figure 2** Probability distributions for the degree (upper left) and in logscale (upper right). Also, the PDF entropy (lower left) versus disorder strength.|

This figure corroborates the intuition from figure 1, and in context is fairly self explanatory. In the world of graph theory, the degree provides a first look at the scales of structure in a graph via a (weak) *centrality* measure.

## Spin Centrality

A central aspect in graph theory is the determination of which nodes in a graph are the most influential, significant, or connected. There are myriad metrics used for different aspects of this, but I define a simple one: The ratio of the degree of a node to the mean degree of its neighbours, weighted by the connection strength to that node.  
$$
\chi_i = \frac{D_i}{\sum_{j\neq i} \mathcal{I}_{ij} D_j/(L-1)}
$$

In a homogenous network will have many nodes with similar degrees to their neighbours (so $\chi\approx 1$). In a network with several characteristic scales $\chi$ will follow a broader distribution, where a 'central' node will have a stronger degree than all of its neighbours $\chi>1$ and a weakly integrated node will have $\chi<1$.

![centrality](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/L9/03_node_centrality.png)

This measure of centrality, or degree uniformity, shows a drastic change between the phases - from narrowly distributed about 1, where all strengths are equal (and maximal, c.f. figure 1), to a broad, weakly-peaked distribution. The latter shape shows that there are emergent scale lengths, with relatively few nodes of great centrality. It would be interesting to test this metric on some known graph structures, to try and understand what structures are forming in the localized phase. This measure is unique in that it shows monotonous growth of the entropy of the distribution.

## von Neumann Entropy & nonlocality

Turning to notions more grounded in physics, the single-site von Neumann entropy distribution can also provide a measure of entanglement. In this case, the von Neumann entropy distribution also corroborates the findings from figures $1$ and $2$: In the extended phase, most spins are almost fully mixed (hence entangled with the rest of the system), and the localized phase shows that while some spins remain strongly entangled, most are weakly entangled, if at all. The symmetric, binary nature of this transition is striking.

|![VN_entropy](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/L9/04_Single-site_entropy.png)|
|:--:|
Probability density of the single-site Von Neumann entropy (upper left), logscale (upper right), Logscale plot of the PDF of the log of the Von Neumann entropy (lower left), Shannon entropy of the PDF of the Von Neumann entropy (lower right).|

The remaining fraction of fully-mixed spins (the peak at 1 in the localized phase) may be related to the peak at $1$ in the two-body mutual information distribution; a fully mixed spin could be equally entangled with two neighbours, hence each pair would have a bond strength of $1$ and a each spin an entropy of $1$. For a state that is known to be pure, subsystem entropy implies entanglement, which supports this hypothesis.

Given that the global state is pure, it has zero entropy. The sum of all the single-site entropies is therefore a measure of the information bound up in correlations. This is bounded above by $L\Omega$, and is shown (scaled) below.

![Totalcorr](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/L9/05_Aleph_trace.png)

Extending this logic, the sum of single-site entropies *minus* the total two-body QMI is a measure of the information bound up in the $N\geq 3$-body correlations.

![ManyBodyCorr](C:/Users/jaker/Documents/Projects/ent_loc/ent_loc/ref/fig/L9/06_Total_higher_correlations.png)
