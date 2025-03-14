library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)

# Daten einlesen
spalte <- read.csv("movie_meta_data.csv")[, 18]

# Falls mehrere Länder in einer Zeile stehen, sie aufsplitten und in ein langes Format umwandeln
laender <- strsplit(as.character(spalte), ", ")
laender <- unlist(laender)  # In einen Vektor umwandeln

# Die fünf häufigsten Länder ermitteln
top_5 <- as.data.frame(table(laender)) %>%
  arrange(desc(Freq)) %>%
  head(5)

# Barplot mit ggplot2 (alle Säulen in hellblau)
ggplot(top_5, aes(x = reorder(laender, -Freq), y = Freq)) +
  geom_bar(stat = "identity", fill = "lightblue") +  # Einheitliche Farbe für alle Säulen
  labs(title = "Top 5 Herkunftsländer der Filme",
       x = "Land",
       y = "Anzahl der Filme") +
  theme_minimal()

