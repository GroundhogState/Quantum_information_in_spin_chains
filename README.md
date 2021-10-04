# Many-body localization through the graph state lens

Concepts from quantum information theory are used to reverse the conventional definition of a graph state and assign to a given many-body state a *mutual information graph*. Structural properties of this graph and the spectrum of its matrix representation are found to uncover signatures of the many-body localization transition in the Pal-Huse model.
For more background on the motivation for this project, see the readme for [this repo](https://github.com/GroundhogState/aubry_andre) (no longer maintained, and for some intermediate results see the [results](/ref/results.md) page.

**Status:** This project has been on the shelf for a while. The numerical work is mostly complete, but there is still some work to do in polishing/debugging graphs before they're presentable. 

# Using this project

## Getting started

The program is encapsulated and configured in `main.m`.

For a primer on the physics background to this project, read the [background](ref/background.md).

The findings of this project are reported in [results](ref/results.md) (also in [HTML](ref/results.html).)

### Prerequisites

Currently this project requires MATLAB R2018b or later. With a little extra work it should be possible to run in Octave.

#### Dependencies

This code makes use of
* [QETLAB](https://github.com/nathanieljohnston/QETLAB)
* Toby Cubitt's [TrX](http://www.dr-qubit.org/matlab/TrX.m) function  

### Installing

`git clone` into a directory of your convenience.


#### Generating data
Data generation is configured with the subfields of `config.gen`.
Set the `bc` and `L` fields determine the system size and boundary conditions.
The `Ws` field specifies the values of the disorder bandwidth to generate, and `num_samples` fixes the number of realizations of each disorder strength. `sel` specifies the indices of the eigenstates to sample from the spectrum, and `num_vecs` is saved as a field for convenience. Enable data writing with the `save` field, which writes to the directory specified in `savepath`.

The configs are passed to `gen_data()` which does the heavy lifting. Generating 20 samples of 20 disorder strengths and computing the QMI graphs for 40 eigenstates in each sample (that is, 16000 graphs) took me a whole weekend. Thus a central goal is to speed up this program - the repeated partial tracing is currently the bottleneck, which could be addressed by a better algorithm (this is the task of my [rho_reduce](https://github.com/groundhogstate/rho_reduce) repo), or maybe just by porting to a faster language.

Currently the best version I have is `v2g_rec()`, a depth-1 recursive method. It might be advantageous to extend this, and is called from within `gen_data()`.
(Update: I have implemented a functional recursive partial-tracing algorithm which led to later, as-yet-undocumented progress on this project).

To save generation time, some test data can be retrieved from my [Google drive](https://drive.google.com/open?id=1AL4ht4CKF_xUYg2D3hfJzdQP8q6KcRUO), request for invite.

##### Data formatting
The program iterates over disorder strengths and saves a single output .m struct per disorder strength. Each saved struct has fields:
`L`: System size
`W` Disorder strength
`num_samples`: The number of realizations with this disorder strength
`num_eigs`: The number of eigenstates converted to graph
`sel`: The indices of the selected eigenvalues
`samp`: A cell array of length `num_samples` containing the detailed data. Each entry of the cell is a struct with fields:
  * `h_list`: The specific on-site $\sigma_z$ coefficients for this sample
  * `nrg`: The rescaled (between 0 and 1) energy of the sampled eigenstates
  * `v_sel`: The eigenvectors selected
  * `A_list`: A cell array whose elements are the matrix Aleph, as described in [results](/ref/results.md). The off-diagonal elements are the QMI between spin pairs, and the diagonals are the individual von Neumann entropies.

All the analysis thus far is on the properties of the graph and its matrix descriptions. It would be fruitful to compare the results so far with more 'physical' measures of structure within the eigenstates.

#### Importing

The 'unpacking' of the data is achieved by `import_network_data(config)` which loops over all .mat files in a directory specified by `config.gen.savepath`

`import_network_data()` returns a cell array, one cell per .mat file. Each cell is a struct `net_data` with several subfields. Each subfield is an array of floats, vectors, or matrices as appropriate, indexed by the (sample #, eigenstate)
* `net_data.prm`: Parameters of the samples: `l` ,`W`,`num_eigs`,`num_samples`
* 'net_data.G' : Fields pertaining to the structural properties of the graphs
* `net_data.L` : Fields pertaining to the *Laplacian* representation of the graphs
* `net_data.A` : Fields pertaining to the *Aleph* representation of the graphs
* `net_data.P` : Fields with a more direct physical interpretation, eg von Neumann entropies or energy eigenvalues.

####  Processing

The sad truth is that hereon the program constructs a ton of histograms. The parameters of these histograms varies a great deal so we make heavy use of `config` in the hope of maintaing the abstraction scheme. The process is encapulated in `system_proc()`. Core stages:
```
% Set up config for property to examine
% Extract the property to examine
data_for_analysis = cellfun(@(x) x.field_of_interest, net_data)
viz_data = distribution_viz(net_data,config)
```
The function of `distribution_viz` is to take the data collated by `import_network_data` and produce histograms.

`distribution_viz` accepts the aggregated data of a specific property (e.g. edge weights, some subset of eigenvalues of the Laplacian, whatever), indexed by (disorder, num_samples, num_eigs) and produces, for each disorder strength:
* PDF Histogram of data collected over all samples and all eigenvectors
* PDF Histogram of the logarithm of the data collected over all samples and all eigenvectors
* The entropy of the PDFs above, computed using the limiting density of discrete points

All these data are returned by `system_proc`, and used later to examine trends across system size.

##### Settings for `distribution_viz`
`num_bins` :
`scaling` : If `true` enabled, all data is divided by `scale`  
`win` : Defines the range over which the histogram is plotted
`log_scaling` : If `true`, all the data is rescaled by `log_scale` *before* taking the logarithm
`log_win` :  Defines the range over which the histogram of the log data is plotted
`fid` : An integer handle specifying the figure object
`fig_title` :  The caption of the figure displayed

NB: The current implementation of hist_entropy depends on the bin sizes. This is to be expected I guess (consider a uniform density with two bins (low ent) versus 100 bins (high ent)). Further unit testing required.

#### Presentation

Plotting the data is done by

### Algorithms

* Generating eigenstates
* Trace graphs

## Author
**Jacob Ross** [GroundhogState](https://github.com/groundhogstate)
