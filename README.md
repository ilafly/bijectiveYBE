# Bijective set-theoretic solutions to the Yang–Baxter equation

[!IMPORTANT]  
The file solutions5.g contains degenerate solutions of rank 5 with the assuption that $\lambda_1$ is not a permutation.

## Set-theoretic solutions to the Yang–Baxter equation

A pair $(X,r)$ is a *(set-theoretic) solution to the Yang–Baxter* equation if, in $X\times X \times X$, the equation 
$$(r\times \text{id})(\text{id}\times r)(r\times \text{id}) =(\text{id}\times r)(r\times \text{id})(\text{id}\times r)$$
holds.

We can write $r(x,y)=(\sigma_x(y),\tau_y(x))$ for $\sigma_x,\tau_x$ maps from $X$ to $X$.

With this notation, a pair $(X,r)$ is a solution if and only if  the following conditions hold for all $x,y,z\in X$:
1. $\sigma_x\sigma_y(z)=\sigma_{\sigma_x(y)}\sigma_{\tau_y(x)}(z)$,
2. $\tau_z\tau_y(x)=\tau_{\tau_z(y)}\tau_{\sigma_y(z)}(x)$,
3. $\sigma_{\tau_{\sigma_y(z)}(x)}\tau_z(y)=\tau_{\sigma_{\tau_y(x)}(z)}\sigma_x(y)$.

We say that the solution $(X,r)$ is *bijective* when $r$ is bijective, *left* (resp. *right*) *non-degenerate* when $\sigma_x$ (resp. $\tau_x$) is bijective for every $x\in X$.

In [1], Theorem 3.1 has been proved that if $X$ is finite and $(X,r)$ is left non-degenerate, then 
$$r \text{ is bijective } \iff (X,r) \text{ is right non-degenerate }.$$

## This repository

In the repository 

- `solutionN.g` contains all bijective solutions of size `N`.

- `solution_uptoisoN.g`  contains all bijective solutions up to isomorphism (i.e. relabeling) of size `N`.

- `solutions_degenerateN.g` contains all bijective degenerate solutions of size `N`.

- `solutions_degenerate_uptoisoN.g` contains all bijective degenerate solutions of size `N` up to isomorphism.

In the file `lib.g` there are some function to read an manipulate the data. 

## Construction

Given an $n$, we consider $X=\{1,\ldots, n\}$.

Using constraint programming, we compute two matrices $S=(S_{i,j})$ and $T=(T_{i,j})$. Each row $i$ of $S$ (resp. of $T$) represent $\sigma_i$ (resp. $\tau_i$) map. The constraints are as follows:
1. $\forall x,y,z\in X: S[x,S[y,z]]=S[S[x,y],S[T[y,x],z]]$
2. $\forall x,y,z\in X: T[z,T[y,x]]=T[T[z,y],T[S[y,z],x]]$ 
3. $\forall x,y,z\in X: S[T[S[y,z],x],T[z,y]]=T[S[T[y,x],z],S[x,y]]$
4. $\forall x,y\in X,\ \exists t,u\in X$ such that $S[t,u]=x$ and $T[u,t]=y$.

## Data 

A solution is represented as a list of two matrices.

### Example

For example, the  list 

`[ [ [ 1, 1, 1 ], [ 2, 2, 2 ], [ 3, 3, 3 ] ], [ [ 1, 1, 1 ], [ 2, 2, 2 ], [ 3, 3, 3 ] ] ]` 

represents the identity solution on the set $X=\{1,2,3\}$, i.e.
for all $x,y\in X$ we have that $\sigma_x(y)=x$ and $\tau_x(y)=x$ and $r(x,y)=(x,y)$.


## Reference 
1. Colazzo, I., Jespers, E., Van Antwerpen, A., & Verwimp, C. (2022). Left non-degenerate set-theoretic solutions of the Yang-Baxter equation and semitrusses. J. Algebra, 610, 409–462. https://doi.org/10.1016/j.jalgebra.2022.07.019

