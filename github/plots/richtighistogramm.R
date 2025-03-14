library(readr)

# Daten einlesen
spalte <- read.csv("movie_meta_data.csv")[, 4]

# Jahreszahlen in numerische Werte umwandeln
jahre <- as.numeric(as.character(spalte))

# Jahreszahlen kleiner als 1900 herausfiltern
jahre_gefiltert <- jahre[jahre >= 1900 & !is.na(jahre)]

# Histogramm der gefilterten Jahreszahlen erstellen
hist(jahre_gefiltert, 
     main = "Verteilung der Jahreszahlen", 
     xlab = "Jahr", 
     ylab = "Anzahl Filme", 
     col = "lightblue", 
     border = "black")