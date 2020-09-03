####### Setup #######

library(png)
library(jpeg)
library(grid)
library(NNLM)
library(tidyverse)

# Change WD respectivly:
# setwd("...")

####### Creating separated matrix for every RGB color channel #######

photo <- readJPEG("University.jpg")

r <- photo[,,1]
g <- photo[,,2]
b <- photo[,,3]

vComp = c(10,25,100,150)

####### Compression by PCA #######

start_time <- Sys.time()

  r.pca <- prcomp(r, center = F, scale = F)
  g.pca <- prcomp(g, center = F, scale = F)
  b.pca <- prcomp(b, center = F, scale = F)
  
  rgb.pca <- list(r.pca, g.pca, b.pca)
  
  
  for (i in vComp) {
    
    pca.img <- sapply(rgb.pca, function(j) {compressed.img <- j$x[,1:i] %*% t(j$rotation[,1:i])}, simplify = 'array')
    
    writeJPEG(pca.img,paste('PCA_photo_',i, '_components.jpg', sep = ''))
  }

end_time <- Sys.time()
end_time - start_time

####### Compression by Non-negative matrix factorization #######

start_time <- Sys.time()

  for (i in vComp) {
    for (j in c(1,5,25,100)){
      
      cat(paste("Computing Red for",i,"Atoms and",j,"as Lambda"),"\n")  
      r.nnmf <- nnmf(r, k=i, beta=c(0,0,j), n.threads = 4) # Change amount of cores based on used processor
      cat(paste("Computing Green for",i,"Atoms and",j,"as Lambda"),"\n")
      g.nnmf <- nnmf(g, k=i, beta=c(0,0,j), n.threads = 4)
      cat(paste("Computing Blue for",i,"Atoms and",j,"as Lambda"),"\n")
      b.nnmf <- nnmf(b, k=i, beta=c(0,0,j), n.threads = 4)
      
      rgb.nnmf <- list(r.nnmf, g.nnmf, b.nnmf)
      
      nnmf.img <- sapply(rgb.nnmf, function(v) {compressed.img <- v$W %*% v$H}, simplify = 'array')
      
      writeJPEG(nnmf.img, paste('NNMF_photo_',i, '_atoms_',j,'_lambda.jpg', sep = ''))
    }
}

end_time <- Sys.time()
end_time - start_time

####### Compression by Non-negative matrix factorization with Overcomplete Dictionary #######

# Not in Report

photoSmall <- readJPEG("UniversitySmall.jpg") 

r.small <- photoSmall[,,1]
g.small <- photoSmall[,,2]
b.small <- photoSmall[,,3]

start_time <- Sys.time()

  r.nnmf.small <- nnmf(r.small, k=2000, beta=c(0,0,10), n.threads = 4, max.iter = 1000)
  g.nnmf.small <- nnmf(g.small, k=2000, beta=c(0,0,10), n.threads = 4, max.iter = 1000)
  b.nnmf.small <- nnmf(b.small, k=2000, beta=c(0,0,10), n.threads = 4, max.iter = 1000)
  
  rgb.nnmf.small <- list(r.nnmf.small, g.nnmf.small, b.nnmf.small)
  
  nnmf.img.small <- sapply(rgb.nnmf.small, function(v) {compressed.img <- v$W %*% v$H}, simplify = 'array')

end_time <- Sys.time()
end_time - start_time

writeJPEG(nnmf.img.small, paste('NNMF_Overcomplete_',2000, '_atoms_',10,'_lambda.jpg', sep = ''))

####### Denoising by Non-negative matrix factorization #######

photo.bw <- readJPEG("LenaSmall.jpg")

bar<- photo.bw[,,1] + photo.bw[,,2] + photo.bw[,,3]

photo.bw <- bar/max(bar)

start_time <- Sys.time()

  bw.nnmf <- nnmf(photo.bw, k=100, beta=c(0,0,70), n.threads = 4, max.iter = 500)
  
  nnmf.img.bw <- bw.nnmf$W %*% bw.nnmf$H

end_time <- Sys.time()
end_time - start_time

par(mfrow = c(1,2))
image(t(photo.bw[nrow(photo.bw):1,]),useRaster=TRUE, axes=FALSE , col = grey(seq(0, 1, length = 256)))
image(t(nnmf.img.bw[nrow(nnmf.img.bw):1,]),useRaster=TRUE, axes=FALSE , col = grey(seq(0, 1, length = 256)))

writeJPEG(nnmf.img.bw, paste('NNMF_photo_BW_Denoising.jpg', sep = ''))

####### Denoising by PCA #######

k = 25

start_time <- Sys.time()

  bw.pca <- prcomp(photo.bw, center = F, scale = F)
  
  pca.img.bw <- bw.pca$x[,1:k] %*% t(bw.pca$rotation[,1:k])

end_time <- Sys.time()
end_time - start_time

par(mfrow = c(1,3))
image(t(photo.bw[nrow(photo.bw):1,]),useRaster=TRUE, axes=FALSE , col = grey(seq(0, 1, length = 256)))
image(t(pca.img.bw[nrow(nnmf.img.bw):1,]),useRaster=TRUE, axes=FALSE , col = grey(seq(0, 1, length = 256)))
image(t(nnmf.img.bw[nrow(nnmf.img.bw):1,]),useRaster=TRUE, axes=FALSE , col = grey(seq(0, 1, length = 256)))

writeJPEG(pca.img.bw, paste('pca_photo_BW_Denoising.jpg', sep = ''))

####### Denoising by Non-negative matrix factorization and Overcompletion #######

photo.bw.small <- readJPEG("LenaSmallEyes.jpg")

bar <- photo.bw.small[,,1] + photo.bw.small[,,2] + photo.bw.small[,,3]

photo.bw.small <- bar/max(bar)

start_time <- Sys.time()

  bw.nnmf.small <- nnmf(photo.bw.small, k=2000, beta=c(0,0,25), n.threads = 4, max.iter = 1000)
  
  nnmf.img.bw.small <- bw.nnmf.small$W %*% bw.nnmf.small$H

end_time <- Sys.time()
end_time - start_time

par(mfrow = c(1,2))
image(t(photo.bw.small[nrow(photo.bw.small):1,]),useRaster=TRUE, axes=FALSE , col = grey(seq(0, 1, length = 256)))
image(t(nnmf.img.bw.small[nrow(nnmf.img.bw.small):1,]),useRaster=TRUE, axes=FALSE , col = grey(seq(0, 1, length = 256)))

writeJPEG(nnmf.img.bw, paste('NNMF_Overcomplete_BW_Denoising.jpg', sep = ''))
