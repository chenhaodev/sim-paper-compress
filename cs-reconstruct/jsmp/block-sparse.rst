Block Sparsity Model
====

> CITE    : Richard Baraniuk, Volkan Cevher, Marco Duarte, Chinmay Hegde
>          "Model-based compressive sensing", submitted to IEEE IT, 2008.

What
----
The second structured sparsity model accounts for the
fact that the large coefficients of many sparse signals clus-
ter together [8,9]. Such a so-called block sparse model is
equivalent to a joint sparsity model for an ensemble of J,
length-N signals [10], where the supports of the signals’
large coefficients are shared across the ensemble. 

Usage
----
Clustered Sparsity Model.

Performance
----
Cited reference's conclusion:
M = O(K), without loss of roboustness, while CoSaMP and IHT needs O(JK).

Run
----
Run jsmp_example.m

Relate to JSM
----
JSM refers to the 'joint sparsity model', which matches the define of model in cited paper. The algorithm JSM-2's model is introduced in http://www.ece.rice.edu/~shri/pub/SPARS2005.pdf, Duarte, Marco F., et al. "Joint sparsity models for distributed compressed sensing.",2005 

Intro to JSM-2 model
----
In this model, all signals are constructed from the same sparse set of basis vectors, but with different coefficients; that is,

$ x_j = \Psi \theta_j , j \in {1,2,... J} $

where each $\theta_j$ is supported only on the same $\omega \in {1,2,...,N}$ with $\|\omega\| = K$. Hence, all signals have L0 sparsity of K, and all are constructed from the same K basis elements, but with arbitrarily different coefficients.
> JSM-1, JSM-3 are ...
