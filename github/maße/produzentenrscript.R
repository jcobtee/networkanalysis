library(readr)
library(igraph)
spalte <- read.csv("movie_meta_data.csv")[, 10]

getrennte_produzenten <- strsplit(spalte, ", ")

alle_produzenten <- unlist(getrennte_produzenten)

produzenten_counts <- table(alle_produzenten)

nodeslist <- unique(alle_produzenten)


# Funktion zur Erstellung der Edgelist
erstelle_edgelist <- function(liste) {
  if (length(liste) < 2) return(NULL)  # Falls nur 1 Produzent -> Keine Kante
  t(combn(liste, 2))  # Alle möglichen 2er-Kombinationen
}

# Wende die Funktion auf alle Filme an und kombiniere die Ergebnisse
edgelist <- do.call(rbind, lapply(getrennte_produzenten, erstelle_edgelist))

# Umwandlung in DataFrame für bessere Lesbarkeit
edgelist_df <- as.data.frame(edgelist, stringsAsFactors = FALSE)
colnames(edgelist_df) <- c("Produzent_A", "Produzent_B")


G = graph_from_data_frame(edgelist_df, directed = F,vertices = nodeslist)

density <- edge_density(G)
degree.G <- degree(G)
head(degree.G)
sort(degree.G,decreasing = T)[1:20]

eigen_centrality.G <- eigen_centrality(G)
betweenness_centrality.G <- betweenness(G,normalized = T)
G <- set_vertex_attr(G, "eigen_centrality",
                     index = V(G), eigen_centrality.G$vector)
G <- set_vertex_attr(G, "betweenness_centrality",
                     index = V(G), betweenness_centrality.G)

G <- set_vertex_attr(G, "degree", index = V(G), degree.G)

eigen <- sort(eigen_centrality.G$vector,decreasing = T)[1:20]

between <- sort(betweenness_centrality.G,decreasing = T)[1:20]

degree <- sort(degree.G,decreasing = T)[1:20]




