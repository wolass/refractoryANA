# The search was performed on 16.11.2017
require(RISmed)
require(magrittr)
res <- EUtilsSummary("refractory anaphylaxis",
type="esearch",
db="pubmed",
datetype='pdat',
mindate=1950,
maxdate="2017/11/16",
retmax=500)
QueryCount(res)
t<-ArticleTitle(EUtilsGet(res))
tdf <-data.frame(No=1:length(t),t)
first <- tdf[c(1,3,9,14,26,30,36,39,43,44,49,52,54,67,68,69,71,72,73,74,75,76,87,88,89,
    90,91,92,93,97,98,100,106,108,114,120,122,123,124,125,131,132,134,141,149),]
second <- tdf[c(3,9,14,26,30,44,54,67,69,71,72,73,74,75,76,87,
              90,91,92,93,97,108,114,132,134),]
fulltext_missing <- c(68,120,122,123,124,125) %>% length
japanese <- 88 %>% length()
no_adrenaline <-98%>% length()
not_refractory <- c(106, 97)%>% length()
guineapigs<- c(141,149) %>% length()
no_case_rep <- 131 %>% length()

# Include information from the anaphylaxis registry
load("~/Documents/anaphylaxis/data3.R")
## See multiple adrenalin cases
require(magrittr)
data3$d_560_adren2_v5 %>% summary
#data3[data3$d_560_adren2_v5=="yes",15:51] %>% summary
#data3$q_142_fatal_treatment_v5%>% summary



### Here are some results from free treatment field of our registry - these indicate refractory anahpylaxis.
# insgesamt 3 Adrenalin-injektionen durch Hausarzt

# Ephedrin 50mg, Infusionen,Adrenalin als wiederholter Bolus (100 mikrogramm)ok, dann Adrenalinperfusor, Noradrenalinperfusor, Trendelenburglagerung

# Ephedrin 40mg, Magnesium 2 Ampullen, Defibrillation 3x 200Joule, Amiodaron 1 Ampulle

# Atropin mehrfach 0,5 mg
# Atropin Boli, 2 minütige mechanische und medikamentöse Reanimation
# Reanimation, weitere Medi unbekannt

# We had two glucagon treated anaphylaxises here !!!
data3$q_522_glucagon_v5 %>% summary()
data3[which(data3$q_522_glucagon_v5=="yes"),200:300]


# Our registry lists cases with dopamine:
dop <- (data3$q_522_dopamine == "yes") %>% which()
dopam.anareg <- data3[dop,c(11,12,66,74,366,
                            241,57)]

knitr::kable(dopam.anareg[,c(-3,-5)])

