

## Background
Systems exhibiting a many-body localized phase have been extensively studied in recent years. One major landmark is the distinction between the extended and localized phases by the scaling of the entanglement of a part of the system with the size of the partition. In the extended phase, the entanglement between two subdivisions of the system (defined as the von Neumann entropy of the reduced density matrix of either piece of the partition) scales with the number of systems in the partition - a volume law. In the many-body localized phase, the entanglement scales as the surface area separating the two partitions of the system. This reduction in entropy is associated with an emergent integrability, wherein the system fails to 'forget' about its initial microscopic correlations. Over long times, the entropy of a partition in the localized phase remains well below the bound given by the total system size. In contrast, a partition of an extended system generally has entropy that is extensive in the partition size, and outcomes of local observables are drawn from a thermal distribution. The MBL transition has therefore been a central object in the study of quantum thermalization given its relevance to the unresolved Eigenstate Thermalization Hypothesis. Recent works have used the quantum mutual information as a lens to examine this transition at a microscopic scale - who is entangled with whom, and by how much? These notes report on recent work extending this work by computing the full statistics and spectral properties of a graph (or network) obtained from the quantum mutual information between all pairs of subsystems. First, I describe the construction of the graph along with the requisite background in quantum information theory. Then I examine structural properties of the state graphs for small instances of the Pal Huse model and describe the change in their universal scaling relations between the extended and localized phases. I then examine the algebraic properties of the graph matrix and, for small systems, their evolution in time. Finally, I discuss extensions to the theory and the recovery of known properties such as the cluster size distribution and entanglement scaling laws.


A central theme in the mathematical study of graphs is the search for heuristics of when graphs can be exactly or approximately partitioned by, for example, deleting all sufficiently weak couplings and retrieving a disjoint union of graphs. This captures the idea of cluster formation in many-body physics, and the graph construction provides several insights.

## Graph states

### Construction of graphs

A *graph state* usually refers to a specific construction in quantum computing theory, where a state of several qubits is constructed from a given graph by applying CNOT gates between qubits where an edge is present between the corresponding nodes in the graph. This work begins with the reversal of th. While we currently lack a rigorous definition of an efficiently computable entanglement measure in large systems, and of large mixed states, the quantum mutual information captures both classical and quantum correlations and, as I will discuss further to the existing literature, provides rich detail into the structure of many-body states. The quantum mutual information of a system composing of elements $A$ and $B$ is defined by the sub-additivity of the von Neumann entropy, $\mathcal{I}_{AB} = \mathcal{S}_A + \mathcal{S}_B - \mathcal{S}_{AB}$ ,

Where $\mathcal{S}_{(B)}$ is the von Neumann entropy of the reduced density matrix of subsystem A (B), and $\mathcal{S}_{AB}$ is the von Neumann entropy of the complete system. The QMI is not an entanglement measure but it does have the advantage of being completely basis independent, and instead provides a bound on the degree of possible correlation observable between two systems.

Given the mutual information between each subsystem of a many-body system, define
$$
W_{ij} = S(\rho_i) + S(\rho_j) - S(\rho_{ij})
$$
whose positive off-diagonal $i,j$th elements are the mutual information between subsystems $i$ and $j$. By the additive property of independent systems, the diagonal entries are zero. In the parlance of graph theory, one then obtains a \textit{weighted adjacency matrix}.

I apply this construction to the Pal-Huse model, a variation of the Heisenberg spin chain. The model is given by the Hamiltonian

$$
\mathcal{H} = J \sum_{i,j} \hat{\vec{S}}_i\hat{\vec{S}}_j + W\sum_i h_i \hat{S^z}_i
$$
Where J is the coupling strength between nearest neighbours (set to 1 in this work to fix an energy scale), and W is the scaling parameter for the on-site transverse field whose local values are given by the $h_i$, randomly drawn from the interval $[-1,1]$. The MBL transition is generally characterized by a region of transition between the extended and localized phases between $W\approx 1.5$ and $W\approx 4$. For various values of the disorder, I generate 8 disorder realizations and sample 21 eigenstates from the middle of the spectrum. For each of these eigenstates I compute the mutual information network by taking the repeated partial traces of the state density matrix. I use periodic boundary conditions on a chain of 12 spins.
