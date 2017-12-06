######## Load the data ########
# d <- read.csv("../data/raw_data/refractoryAnaphylaxis.csv")
d <- read.csv("~/Documents/refractoryANA/analysis/data/raw_data/refractoryAnaphylaxis.csv")
 d[,c(1,2,3)]
d[,3] <- as.character(d[,3])

# Clean the authors references ####
d[c(1,8,9,10,11,12,16,17,20:43),3] <- c("[@DaSilva2017]",rep("[@Oliveira2003]",3),
                            rep("[@DelDuca2009]",2),
                            rep("[@Baumann2009]",2),
                            "[@Higgins1999]",
                            "[@Allen2000]",
                            "[@Zaloga1986]",
                            "[@Zweizig1994]",
                            "[@Laxenaire1984]",
                            "[@Bickell1984]",
                            "[@Javeed1996]",
                            "[@Stocche2004]",
                            "[@Liu2005]",
                            "[@Goddet2006]",
                            rep("[@Schummer2008]",6),
                            "[@Schummer2004]",
                            "[@Liang2008]",
                            "[@AliciaWeissgerber2007]",
                            "[@Hussain2008]",
                            "[@Lango2009]",
                            "[@Raft2012]",
                            "[@Wang2016]",
                            "[@Gibbs2003]")
d$Source<- gsub(d$Source,pattern = "\\[",replacement = "")
d$Source<- gsub(d$Source,pattern = "\\]",replacement = "")

######## prepearing the data frame ######
mean(d$age,na.rm = T)
d$Elicitor_gr <- rep(NA,length(d$Elicitor))
d$Elicitor_gr[c(which(grepl("cont",d$Elicitor)==T),24)] <- "contrast"
d$Elicitor_gr[c(4,7,13,19,20,38,39)] <- "unknown"
d$Elicitor_gr[c(2,6,11,12,13,14,16,17,18,21,23,27,28,29,30,31,32,33,34,35,36,40,41,43)] <- "drug"
d$Elicitor_gr[c(1,3,5,15,25,37,42)] <- "other"

# d$Elicitor[21] <- "platinum"
#d$Elicitor[22] <- "contrast"

d$Time.after.exposure
d$Time <- c(5,5,10,NA,5,NA,5,NA,NA,NA,NA,NA,NA,NA,15,NA,NA,5,5,NA,NA,5,5,0.2,5,5,0.5,NA,5,20,5,5,10,5,5,5,15,NA,NA,0.5,0.5,5,NA)

d$Situation_gr <- c("OP",
                    "OP",
                    "OP",
                    "ambulatory",
                    "not hospital",
                    "chemo",
                    "OP",
                    "unknown",
                    "unknown",
                    "unknown",
                    "OP",
                    "OP",
                    "OP","unknown",
                    "not hospital",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "unknown",
                    "unknown",
                    "CT",
                    "chemo",
                    "OP",
                    "ambulatory",
                    "OP",
                    "OP",
                    "ambulatory",
                    "not hospital",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "OP")

# One case needs removal due to non-refractory character: LAMB
d <- d[-4,]
d <- d[-13,]
d <- d[-27,]
d <- d[-34,]


########### # The demographics table  ######

demogr.tab <- data.frame(Age=d$age %>% split(d$Elicitor_gr) %>%
               lapply(mean,na.rm=T) %>%
               unlist,
           "Male_fraction"=
             d$sex %>% split(d$Elicitor_gr) %>%
             lapply(function(x){
               which(x=="man")  %>% length()/length(x)*100
             }) %>% unlist,
           "Operative_fraction"=
             d$Situation_gr %>% split(d$Elicitor_gr) %>%
             lapply(function(x){
               which(x=="OP")  %>% length()/length(x)*100
             }) %>% unlist
) %>% data.frame(Elicitor=rownames(.),
                 n=d$Elicitor_gr %>% factor %>% summary() %>% unlist,.)

rownames(demogr.tab) <- NULL


#load("~/Documents/anaphylaxis/data3.R")
#data3[which(data3$q_143_fatal_adre_v5=="yes"),]

################## The effective therapies variable ##################
d$What.helped_gr <- c("methylene blue",
                      "vasopressors",
                      "ECLS", # Extracorporeal life support
                      "drainage",
                      "methylene blue",
                      "ECLS",
                      "methylene blue",
                      "methylene blue",
                      "methylene blue",
                      "methylene blue",
                      "methylene blue",
                      "methylene blue",
                      "methylene blue",
                      NA,
                      NA,
                      "vasopressors",
                      "vasopressors",
                      "vasopressors",
                      "ECLS",
                      "glucagon",
                      NA,
                      NA,
                      "vasopressors",
                      "glucagon",
                      "methylene blue",
                      "epi infusion",
                      "vasopressors",
                      "vasopressors",
                      "vasopressors",
                      "vasopressors",
                      "vasopressors",
                      "vasopressors",
                      "vasopressors",
                      "methylene blue",
                      "vasopressors",
                      "hemofiltration",
                      "sugammadex",
                      "ECLS",
                      "ALS"
                      )

##### Therapy dissection ####

# d$Therapy

d$t_steroids <- c(T,T,T,T,T,F,T,T,T,T,
                  T,T,T,F,F,F,F,F,T,T,
                  T,F,T,T,T,T,T,T,F,T,
                  T,T,T,F,T,F,F,F,T)

d$t_antihistamines <- c(T,T,T,F,T,F,F,F,F,T,
                        T,T,T,F,F,F,F,F,T,F,
                        F,F,T,F,F,F,F,F,F,T,
                        T,F,F,T,F,F,F,F,T)

d$t_vasopressin <- rep(F,length(d$Therapy))
d$t_vasopressin[c(3,10,11,27,28,29,30,31,32,33,35)] <- T
terlipressin <- c(14,15)
d$t_vasopressin[terlipressin] <- T
d$t_vasopression <-  d$t_vasopressin
metaraminol <-c(1, 6,16,17)
isoprenaline.dobutamine <- c(22 ,36)
norepi <- c(27,28,30,31,32,33,35,36,1,2,3,5,10)
d$t_vasopression[c(metaraminol,isoprenaline.dobutamine,norepi)] <- T


cardiac_bypass <- c(10,11,15,3,6,19)

ALS <- c(17,18,19,21,25,30,39,6)

b2 <- c(12,2,3,4)

glucagon <- c(20,24)


###### Fatalities table ######

fat <- data.frame(d[which(d$Death=="yes"),c(4,6,7,29,31,32)],
           "Epinephrine [mg]"= c(25,20.2,NA,0.6),
           "Fluids [L]" = c(1.5,2.5,0,2),
           "Vasopressors" = c("+","+","-","+"))

source("R/pmf.R")
fat$t_steroids %<>% pmf()
fat$t_antihistamines %<>%  pmf()

#### Vasopresors analysis ####
temp.v <- d$What.helped_gr == "vasopressors"
d[temp.v,]

#### The whole sources table #####

whole.tab <- data.frame(Author =paste0(d$Author," [",d$Source,"]"),
           Elicitor = d$Elicitor_gr,
           Age = d$age,
           Sex =d$sex,
           Setting = d$Situation_gr,
           `What helped` =d$What.helped_gr,
           Vasopressors= d$t_vasopression)
