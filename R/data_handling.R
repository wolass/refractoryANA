######## Load the data ########
d <- read.csv("../data/raw_data/refractoryAnaphylaxis.csv")

######## prepearing the data frame ######
mean(d$age,na.rm = T)
d$Elicitor_gr <- rep(NA,length(d$Elicitor))
d$Elicitor_gr[c(grepl("cont",d$Elicitor),24)] <- "contrast"
d$Elicitor_gr[c(4,7,13,19,20,21,38,39)] <- "unknown"
d$Elicitor_gr[c(2,6,11,12,13,14,16,17,18,23,27,28,29,30,31,32,33,34,35,36,40,41)] <- "drug"
d$Elicitor_gr[c(1,3,5,15,25,37,42)] <- "other"

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
) %>% data.frame(Elicitor=rownames(.),.)

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

d$Therapy

d$t_steroids <- c(T,T,T,T,T,F,T,T,T,T,
                  T,T,T,F,F,F,F,F,T,T,
                  T,F,T,T,T,T,T,T,F,T,
                  T,T,T,F,T,F,F,F,T)

d$t_antihistamines <- c(T,T,T,F,T,F,F,F,F,T,
                        T,T,T,F,F,F,F,F,T,F,
                        F,F,T,F,F,F,F,F,F,T,
                        T,F,F,T,F,F,F,F,T)

# d$t_volume <- c()

###### Fatalities table ######

fat <- data.frame(d[which(d$Death=="yes"),c(4,6,7,8,31,32)],
           "Epinephrine [mg]"= c(25,20.2,NA,0.6),
           "Fluids [L]" = c(1.5,2.5,0,2),
           "vasopressors" = c(T,T,F,T))

