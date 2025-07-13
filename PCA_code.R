#Pakieciki
library(readxl)
install.packages("psych")
library(psych)
install.packages("stats")
library(stats)
library(factoextra)
library(gridExtra)
library(MASS)
library(scatterplot3d)

#PCA
#jako ze wartosci zmiennych sa rozne zastosuje macirz korelacji po standaryzacji
standaryzowane <- MamNadziejeZeOstatnieDane
standaryzowane[, -1] <- scale(MamNadziejeZeOstatnieDane[, -1])

#macierz kolrelacji
macierz_korelacji <- cor(standaryzowane[, -1])
cortest.bartlett(macierz_korelacji) #korelacje istotne mozna robic PCA

#KMO
kmo_wynik <- KMO(macierz_korelacji)
kmo_wynik

#PCA
pca <- prcomp(macierz_korelacji, center=TRUE, scale=TRUE)
pca


wektory_wlasne <- pca$rotation
wektory_wlasne

#Test osypiska 
eigenvalues <- pca$sdev^2
plot(eigenvalues, type = "b", main = "Test osypiska", xlab = "Składowe główne", ylab = "Wartości własne")
abline(h = 2, col = "red", lty = 2)  # Linia pomocnicza dla kryterium Kaisera

wartosci_wlasne <- pca$sdev^2
print(wartosci_wlasne)

wartosci_glowne <- pca$x
print(wartosci_glowne)

#wykresy
fviz_eig(pca, addlabels = TRUE) +
  ggtitle("Proporcja wyjaśnionej wariancji przez składowe główne")

plot1 <- fviz_contrib(pca, choice = "var", axes = 1) + 
  ggtitle("Udział zmiennych w pierwszej składowej") +
  theme(plot.title = element_text(size = 14))

plot2 <- fviz_contrib(pca, choice = "var", axes = 2) + 
  ggtitle("Udział zmiennych w drugiej składowej")+
  theme(plot.title = element_text(size = 14))

plot3 <- fviz_contrib(pca, choice ="var", axes=1:2)+ 
  ggtitle("Udział zmiennych w pierwszej i drugiej składowej") +
  theme(plot.title = element_text(size = 14))

grid.arrange(plot1, plot2, plot3,ncol = 3)

#wykres ładunków czynnikowych 
fviz_pca_var(pca) +
  ggtitle("Wykres ładunków czynnikowych")

cor(macierz_korelacji, pca$x[,1:2])

cos <- pca$rotation[, 1:2]
rzutowanie <- as.data.frame(as.matrix(standaryzowane[, -1]) %*% pca$rotation[, 1:2])
colnames(rzutowanie) <- c("PC1", "PC2")
rzutowanie$Region <- MamNadziejeZeOstatnieDane[, 1]

# Wykres PCA z obiektami
library(ggplot2)
rzutowanie50<-rzutowanie[297:314, ]
ggplot(rzutowanie50, aes(x = PC1, y = PC2, label = Region$...1)) +
  geom_point(size = 2) +            
  geom_text(vjust = -0.7, size = 5) + 
  theme_minimal() +
  labs(
    title = "Wykres PCA"
  )

################################################################################################
#MDS
#standaryzuje i biore macierz korelacji, licze odleglosci 

macierz_odleglosci <- dist(standaryzowane, method = "euclidean")
macierz_odleglosci <- as.matrix(macierz_odleglosci)
mds1 <- cmdscale(macierz_odleglosci, k = 1)
mds2 <- cmdscale(macierz_odleglosci, k = 2)
mds3 <- cmdscale(macierz_odleglosci, k = 3)

mds3_df <- as.data.frame(mds3)
mds3_df$Name <- standaryzowane[, 1]
mds3_df_ogr<- mds3_df[297:314, ]

rekonstrukcja <- dist(mds1)
rekonstrukcja <- as.matrix(rekonstrukcja)

rekonstrukcja2 <-dist(mds2)
rekonstrukcja2 <- as.matrix(rekonstrukcja2)

rekonstrukcja3 <-dist(mds3)
rekonstrukcja3 <- as.matrix(rekonstrukcja3)

# Obliczanie współczynnika stresu
stress1 <- sqrt(sum((macierz_odleglosci - rekonstrukcja)^2) / sum(macierz_odleglosci^2))
stress2 <- sqrt(sum((macierz_odleglosci - rekonstrukcja2)^2) / sum(macierz_odleglosci^2))
stress3 <- sqrt(sum((macierz_odleglosci - rekonstrukcja3)^2) / sum(macierz_odleglosci^2))
print(stress1)
print(stress2)
print(stress3)


s3d<-scatterplot3d(
  x = mds3_df_ogr$V1,
  y = mds3_df_ogr$V2, 
  z = mds3_df_ogr$V3,  
  type = "h",       
  pch = 16,        
  color = "blue",    
  xlab = "Wymiar 1",
  ylab = "Wymiar 2",
  zlab = "Wymiar 3"
)

text(s3d$xyz.convert(mds3_df_ogr$V1, mds3_df_ogr$V2, mds3_df_ogr$V3), 
     labels = mds3_df_ogr$Name$...1, 
     pos = 3,               
     cex = 1.2)  


#samoon
y_start1 <- as.matrix(cmdscale(macierz_odleglosci, k = 1))
sam1<-sammon(macierz_odleglosci, y = y_start1,1)
rekonstrukcja4 <- dist(sam1$points)
rekonstrukcja4 <- as.matrix(rekonstrukcja4)

y_start2 <- as.matrix(cmdscale(macierz_odleglosci, k = 2))
sam2<-sammon(macierz_odleglosci, y = y_start2,2)
sam2
rekonstrukcja5 <- dist(sam2$points)
rekonstrukcja5 <- as.matrix(rekonstrukcja5)

y_start3 <- as.matrix(cmdscale(macierz_odleglosci, k = 3))
sam3<-sammon(macierz_odleglosci, y = y_start3,3)
sam3
rekonstrukcja6 <- dist(sam3$points)
rekonstrukcja6 <- as.matrix(rekonstrukcja6)

sam_do_wykresu <- sam3$points
sam_do_wykresu <- as.data.frame(sam_do_wykresu)
sam_do_wykresu$Name <- standaryzowane[,1]

sam_do_wykresu_ogr <- sam_do_wykresu[297:314,]

s3d2<-scatterplot3d(
  x = sam_do_wykresu_ogr$V1,
  y = sam_do_wykresu_ogr$V2,
  z = sam_do_wykresu_ogr$V3,
  type = "h",     
  pch = 16,         
  color = "blue",   
  xlab = "Wymiar 1",
  ylab = "Wymiar 2",
  zlab = "Wymiar 3"
)

text(s3d2$xyz.convert(sam_do_wykresu_ogr$V1, sam_do_wykresu_ogr$V2, sam_do_wykresu_ogr$V3), 
     labels = mds3_df_ogr$Name$...1,
     pos = 3,               
     cex = 1.2)  
