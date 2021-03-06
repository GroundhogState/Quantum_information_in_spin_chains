
## Related work

* de Tomasi
* Entanglement clusters
* Rispoli
* Entanglement renormalization
* Pairwise correlations
* Total correlations



#==================



## Background
Systems exhibiting a many-body localized phase have been extensively studied in recent years. One major landmark is the distinction between the extended and localized phases by the scaling of the entanglement of a part of the system with the size of the partition. In the extended phase, the entanglement between two subdivisions of the system (defined as the von Neumann entropy of the reduced density matrix of either piece of the partition) scales with the number of systems in the partition - a volume law. In the many-body localized phase, the entanglement scales as the surface area separating the two partitions of the system. This reduction in entropy is associated with an emergent integrability, wherein the system fails to 'forget' about its initial microscopic correlations. Over long times, the entropy of a partition in the localized phase remains well below the bound given by the total system size. In contrast, a partition of an extended system generally has entropy that is extensive in the partition size, and outcomes of local observables are drawn from a thermal distribution. The MBL transition has therefore been a central object in the study of quantum thermalization given its relevance to the unresolved Eigenstate Thermalization Hypothesis. Recent works have used the quantum mutual information as a lens to examine this transition at a microscopic scale - who is entangled with whom, and by how much? These notes report on recent work extending this work by computing the full statistics and spectral properties of a graph (or network) obtained from the quantum mutual information between all pairs of subsystems. First, I describe the construction of the graph along with the requisite background in quantum information theory. Then I examine structural properties of the state graphs for small instances of the Pal Huse model and describe the change in their universal scaling relations between the extended and localized phases. I then examine the algebraic properties of the graph matrix and, for small systems, their evolution in time. Finally, I discuss extensions to the theory and the recovery of known properties such as the cluster size distribution and entanglement scaling laws.


A central theme in the mathematical study of graphs is the search for heuristics of when graphs can be exactly or approximately partitioned by, for example, deleting all sufficiently weak couplings and retrieving a disjoint union of graphs. This captures the idea of cluster formation in many-body physics, and the graph construction provides several insights.
