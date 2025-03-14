library(readr)
library(igraph)

spalte <- read.csv("movie_meta_data.csv")[, 10]

getrennte_produzenten <- strsplit(spalte, ", ")

alle_produzenten <- unlist(getrennte_produzenten)

nodeslist <- unique(alle_produzenten)

nodeslist_alphabetisch <- sort(nodeslist)

###Filmanzahl###
###########################################

anzahlfilme <- table(alle_produzenten)

auswahl <- anzahlfilme >= 15

produzentenmindfilme <- nodeslist_alphabetisch[auswahl]


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

auswahl_a <- edgelist_df$Produzent_A %in% produzentenmindfilme
auswahl_b <- edgelist_df$Produzent_B %in% produzentenmindfilme
auswahl <- auswahl_a & auswahl_b

edgelist_df_gefiltert <- edgelist_df[auswahl, ]

G = graph_from_data_frame(edgelist_df_gefiltert, directed = F,vertices = produzentenmindzweifilme)

write_graph(G, "graphmehrals15.graphml", format = "graphml")




