
## Background
Systems exhibiting a many-body localized phase have been extensively studied in recent years. One major landmark is the distinction between the extended and localized phases by the scaling of the entanglement of a part of the system with the size of the partition. In the extended phase, the entanglement between two subdivisions of the system (defined as the von Neumann entropy of the reduced density matrix of either piece of the partition) scales with the number of systems in the partition - a volume law. In the many-body localized phase, the entanglement scales as the surface area separating the two partitions of the system. This reduction in entropy is associated with an emergent integrability, wherein the system fails to 'forget' about its initial microscopic correlations. Over long times, the entropy of a partition in the localized phase remains well below the bound given by the total system size. In contrast, a partition of an extended system generally has entropy that is extensive in the partition size, and outcomes of local observables are drawn from a thermal distribution. The MBL transition has therefore been a central object in the study of quantum thermalization given its relevance to the unresolved Eigenstate Thermalization Hypothesis. Recent works have used the quantum mutual information as a lens to examine this transition at a microscopic scale - who is entangled with whom, and by how much? These notes report on recent work extending this work by computing the full statistics and spectral properties of a graph (or network) obtained from the quantum mutual information between all pairs of subsystems. First, I describe the construction of the graph along with the requisite background in quantum information theory. Then I examine structural properties of the state graphs for small instances of the Pal Huse model and describe the change in their universal scaling relations between the extended and localized phases. I then examine the algebraic properties of the graph matrix and, for small systems, their evolution in time. Finally, I discuss extensions to the theory and the recovery of known properties such as the cluster size distribution and entanglement scaling laws. 

##Graph states

###Construction of graphs

A *graph state* usually refers to a specific construction in quantum computing theory, where a state of several qubits is constructed from a given graph by applying CNOT gates between qubits where an edge is present between the corresponding nodes in the graph. This work begins with the reversal of th. While we currently lack a rigorous definition of an efficiently computable entanglement measure in large systems, and of large mixed states, the quantum mutual information captures both classical and quantum correlations and, as I will discuss further to the existing literature, provides rich detail into the structure of many-body states. The quantum mutual information of a system composing of elements $A$ and $B$ is defined by the sub-additivity of the von Neumann entropy, $\mathpzc{I}_{AB} = \mathpzc{S}_A + \mathpzc{S}_B - \mathpzc{S}_{AB}$ ,

Where $\mathpzc{S}_{(B)}$ is the von Neumann entropy of the reduced density matrix of subsystem A (B), and $\mathpzc{S}_{AB}$ is the von Neumann entropy of the complete system. The QMI is not an entanglement measure but it does have the advantage of being completely basis independent, and instead provides a bound on the degree of possible correlation observable between two systems.

Given the mutual information between each subsystem of a many-body system, define 
$$ 
\gimel_{ij} = S(\rho_i) + S(\rho_j) - S(\rho_{ij})
$$
whose positive off-diagonal $i,j$th elements are the mutual information between subsystems $i$ and $j$. By the additive property of independent systems, the diagonal entries are zero. In the parlance of graph theory, one then obtains a \textit{weighted adjacency matrix}.

I apply this construction to the Pal-Huse model, a variation of the Heisenberg spin chain. The model is given by the Hamiltonian

$$
\mathscr{H} = J \sum_{i,j} \hat{\vec{S}}_i\hat{\vec{S}}_j + W\sum_i h_i \hat{S^z}_i
$$
Where J is the coupling strength between nearest neighbours (set to 1 in this work to fix an energy scale), and W is the scaling parameter for the on-site transverse field whose local values are given by the $h_i$, randomly drawn from the interval $[-1,1]$. The MBL transition is generally characterized by a region of transition between the extended and localized phases between $W\approx 1.5$ and $W\approx 4$. For various values of the disorder, I generate 8 disorder realizations and sample 21 eigenstates from the middle of the spectrum. For each of these eigenstates I compute the mutual information network by taking the repeated partial traces of the state density matrix. I use periodic boundary conditions on a chain of 12 spins.

###Structural properties

The most obvious avenue of inquiry is the distribution of weights among the graph. As found by de Tomasi et al, the extended phase is characterized by robust long-distance (with respect to the underlying lattice) QMI, while the localized phase corresponds to moderate short-range connections and a strong suppression of long-range correlations. The detailed distibution of weights in the graph support this, as shown in figure 1.

\begin{figure}[h!]
\begin{center}
\includegraphics[width=1.3\textwidth]{figures/weight_distribution.png}
\caption{Upper left: Weight distribution of the QMI graph. Upper centre: Weight distribution displayed on a log-log scale. Upper right: Density plot of the weight distribution as a function of disorder strength. For each disorder strength, the histogram is the probability distribution of edge weights as obtained in the generated data. Lower row shows the cumulative distribution function for the corresponding PDFs above. \com{The vertical axis on the density plot is wrong. Add titles.}}
\end{center}
\end{figure}


In the localized phase, the weight distribution is sharply peaked. In the localized phase, the distribution is visible broader, with many more edges at much lower strengths than the localized phase (note the negative log in the horizontal axis). The change in concentration of edge strengths can also be seen in the cumulative distribution functions.

One can also define the \textit{degree} of a node in a graph by the sum of the weights of all the edges connected to it, $d_i = \sum_j \mathcal{I}_{ij}$, i.e the sum of the $i$th row of the adjacency matrix (for undirected graphs, this is also the column sum). This is one measure of the centrality of the nodes of a graph, which in this context means sites that are strongly entangled with other, potentially distant, sites. The degree distribution is visible in figure 2. 

\begin{figure}[h!]
\begin{center}
\includegraphics[width=1.3\textwidth]{figures/degree_distribution.png}
\caption{Upper left: Degree distribution of the QMI graph. Upper centre: Degree distribution displayed on a log-log scale. Upper right: Density plot of the Degree distribution as a function of disorder strength. For each disorder strength, the histogram is the probability distribution of node degrees as obtained in the generated data. Lower row shows the cumulative distribution function for the corresponding PDFs above. \com{The vertical axis on the density plot is wrong. Add titles.}}
\end{center}
\end{figure}

In the extended phase, most nodes are equally well connected, with some more strongly than the mode. In the extended phase, most degrees are quite weak, reflecting poorly-connected nodes, with a small probability of being more strongly connected. The log-log plot suggests a power-law scaling of the probability of finding a node with a given degree, which is characteristic of scale-free graphs. Notice that for small disorder strength past the onset of localization, the mode of the degree distribution actually increases, suggesting a strengthening of the overall mutual information integration in the system.  The degree distribution exhibits a much clearer distinction thann the weight distribution between the localized and extended phases in its density diagram. Moreover, the probability distributions themselves have markedly different shapes, but I propose they are parametrized by a single probability distribution.

One can phrase the question of centrality in other ways. For example, given a node of high degree, how likely is it to be connected to other nodes of high degree? Figure 3 shows the PDF and CDF of the weighted mean of neighbours, defined by $\mu_i = \frac{(L-1)\sum_{ij}\mathcal{I}_{ij}d_j}{\sum_{j\neq i} d_i}$, where $L$ is the total number of systems. $\mu$ compares the mean of the degree of the neighbours of $i$ to the mean degree of all nodes other than $i$.  A value of $\mu_i=0$ shows that system $i$ is poorly connected, as either it has neighbours of low degree or it has only weak connections or both. A large $\mu_i$ indicates that the nodes connected strongly to system $i$ are also strongly connected relative to the mean, and so form a central cluster in the global system. For the localized phase, the distribution of $\mu$ peaks sharply at 1, showing that almost all nodes are equally central - the graph is nearly uniformly completely connected. 

\begin{figure}[h!]
\begin{center}
\includegraphics[width=1.3\textwidth]{figures/centrality_by_neighbour.png}
\caption{Upper left: Distribution of weighted node centrality of the QMI graph. Upper centre: Distribution of weighted node centrality displayed on a log-log scale. Upper right: Density plot of the distribution of weighted node centrality as a function of disorder strength. For each disorder strength, the histogram is the probability distribution of node degrees as obtained in the generated data. Lower row shows the cumulative distribution function for the corresponding PDFs above. \com{The vertical axis on the density plot is wrong. Add titles.}}
\end{center}
\end{figure}

One can also ask \textit{how many} neighbours a node is well-connected to. For example, one can imagine a many-body state consisting of weakly entangled subsystems who are themselves internally strongly entangled. This question naturally leads to the study of partitions of the QMI graph and to the application of spectral graph theory to the information-theoretic structure of quantum many-body physics.

###Graph spectral analysis

A central theme in the mathematical study of graphs is the search for heuristics of when graphs can be exactly or approximately partitioned by, for example, deleting all sufficiently weak couplings and retrieving a disjoint union of graphs. This captures the idea of cluster formation in many-body physics, and the graph construction provides several insights. 

One can furnish the definition of $\gimel$ by constructing the \textit{Laplacian} of the graph, defined by 
$$
L = \daleth - \gimel
$$
where $\daleth$ is the diagonal matrix whose $ii$th entry is the degree of node $i$. The Laplacian has the useful property that \textit{the number of zero eigenvalues of $L$ is the number of connected components in the graph}. For a disjoint union of $k$ graphs, then, the spectrum of $L$ has a $k$-degenerate null space. Equivalently, one can block-diagonalize both $\gimel$ and $L$ with one matrix block for each connected component. 
\com{Return to this. It's important.}



\section{To do list}
\begin{enumerate}
    \item Correlation lengths & graph linear algebra - length scales
    \item Scaling
    \begin{enumerate}
        \item Find appropriate distribution form
        \item Plot scale parameters vs W & guess functional form
        \item Pick a reference length & apply scaling transform
    \end{enumerate}
    \item Computational bottlenecks
        \begin{enumerate}
            \item Port TrX to C
        \end{enumerate}
    \item Extend to lattice model
\end{enumerate}

