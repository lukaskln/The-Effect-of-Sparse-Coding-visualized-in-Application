[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/lukaskln/The-Effect-of-Sparse-Coding-visualized-in-Application">
    <img src="https://github.com/lukaskln/The-Effect-of-Sparse-Coding-visualized-in-Application/blob/master/Graphics/Compression-1.jpg" alt="Logo" width="800">
  </a>

  <h3 align="center">The Effect of Sparse Coding visualized in Application</h3>

  <p align="center">
    Area of Multivariate Analysis.
    <br />
    <a href="https://github.com/lukaskln/The-Effect-of-Sparse-Coding-visualized-in-Application"><strong>Explore the Project »</strong></a>
    <br />
    <br />
    <a href="https://github.com/lukaskln/The-Effect-of-Sparse-Coding-visualized-in-Application/issues">Report Bug</a>
  </p>
</p>

## About the Project

Sparse coding is applied in this project on picture compression and reconstruction for black
& white and coloured pictures. The programming language R with the NNLM
package offering non-negative matrix factorization (NNMF) with ℓ1 regularization on
the score matrix is used. We use NNMF since classical dictionary learning
is not implemented as a package in R. If the reader wants to try out dictionary
learning and online dictionary learning, Mairal et al. implemented their solutions in
C++ with different interfaces [[Mairal, 2020](http://spams-devel.gforge.inria.fr/index.html)].

Like dictionary learning NNMF wants to minimize the sum of squared distances
between the original data and the reconstruction. Again, we induce sparsity of the
coefficient or score matrix by an ℓ1 regularization term. The main difference is that
NNMF assumes fully non-negative data X and has the constrain that every element in
the dictionary and coefficient matrix has to be grater or equal to zero. Since over completion
of the dictionary and different levels of sparsity are possible in this model too,
our findings apply in general for dictionary learning as well.

## The Code 

The code is fully in R and in one script. The "Pictures" folder includes the original pictures used for the demonstrations. In the "Graphics" folder examples of compression and denoising with different parameters can be found. For data rights reasons is the respective training dataset not included in this repository.

## Contact

Lukas Klein - [LinkedIn](https://www.linkedin.com/in/lukasklein1/) - lukas.klein@etu.unige.ch

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=flat-square
[license-url]: https://github.com/lukaskln/The-Effect-of-Sparse-Coding-visualized-in-Application/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/lukasklein1/
