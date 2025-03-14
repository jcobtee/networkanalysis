library(readr)

# Daten einlesen und Produzenten extrahieren
spalte <- read.csv("movie_meta_data.csv")[, 10]
getrennte_produzenten <- strsplit(spalte, ", ")
alle_produzenten <- unlist(getrennte_produzenten)

# Anzahl der Filme pro Produzent berechnen
produzenten_counts <- table(alle_produzenten)

# Top 20 Produzenten auswählen
top_produzenten <- sort(produzenten_counts, decreasing = TRUE)[1:20]

# Ergebnisse in einen DataFrame umwandeln
top_produzenten_df <- data.frame(
  Produzent = names(top_produzenten),
  Anzahl_Filme = as.numeric(top_produzenten)
)

# Ergebnisse in eine CSV-Datei schreiben
write.csv(top_produzenten_df, "top_20_produzenten_filme_counts.csv", row.names = FALSE)

cat("Die Top-20-Produzenten-Counts wurden in 'top_20_produzenten_filme_counts.csv' gespeichert.\n")