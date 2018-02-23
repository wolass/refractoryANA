######## Load the data ########
# d <- read.csv("../data/raw_data/refractoryAnaphylaxis.csv")
d <- read.csv("~/Documents/refractoryANA/analysis/data/raw_data/refractoryAnaphylaxis.csv",colClasses = "character")
 d[,c(1,2,3)]
d[,3] <- as.character(d[,3])

d2<- read.csv("analysis/data/raw_data/REfractory anaphylaxis - Arkusz1.csv",colClasses = "character")


d <- rbind(d,d2[45:47,1:26])
# Clean the authors references ####
d[c(1,8,9,10,11,12,16,17,20:43,44:46),3] <- c("[@DaSilva2017]",rep("[@Oliveira2003]",3),
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
                            "[@Gibbs2003]",
                            rep("[@Gouel]",3))
d$Source<- gsub(d$Source,pattern = "\\[",replacement = "")
d$Source<- gsub(d$Source,pattern = "\\]",replacement = "")
d$Author <- gsub(d$Author,pattern = " et .*",replacement = "")
d$Author[c(18,19,21,22,28,29)] <- c(rep("Heytman",2),
                                    "Allen","Zaloga","Liu","Goddet")
#### Clear elicitors #####
d$Elicitor <- as.character(d$Elicitor)
d$Elicitor <- gsub(" .*","",d$Elicitor)
d$Elicitor[c(1,6,7,
             15,19,20,
             24,25,42,44:46)] <- c("latex","bendamustine","unknown",
                                 "menses","unknown","unknown",
                                 "contrast","SIT","chlorhexidine",
                                 "unknown","unknown","unknown"
                           )

######## prepearing the data frame ######
mean(d$age %>% as.numeric,na.rm = T)
d$Elicitor_gr <- rep(NA,length(d$Elicitor))
d$Elicitor_gr[c(which(grepl("cont",d$Elicitor)==T))] <- "contrast"
d$Elicitor_gr[c(4,7,13,19,20,38,39,44,45,46)] <- "unknown"
d$Elicitor_gr[c(2,6,11,12,13,14,16,17,18,21,23,27,28,29,30,31,32,33,34,35,36,40,41,43)] <- "drug"
d$Elicitor_gr[c(1,3,5,15,25,37,42)] <- "other"

# d$Elicitor[21] <- "platinum"
#d$Elicitor[22] <- "contrast"

d$Time.after.exposure
d$Time[1:43] <- c(5,5,10,NA,5,NA,5,NA,NA,NA,NA,NA,NA,NA,15,NA,NA,5,5,NA,NA,5,5,0.2,5,5,0.5,NA,5,20,5,5,10,5,5,5,15,NA,NA,0.5,0.5,5,NA)

d$Situation_gr <- c("OP",
                    "OP",
                    "OP",
                    "ambulatory",
                    "ambulatory",
                    "chemo",
                    "OP",
                    "CT",
                    "CT",
                    "CT",
                    "OP",
                    "OP",
                    "OP","unknown",
                    "ambulatory",
                    "OP",
                    "OP",
                    "OP",
                    "OP",
                    "unknown",
                    "OP",
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
                    "OP","OP","OP","OP")

# One case needs removal due to non-refractory character: LAMB
d <- d[-4,]
d <- d[-13,]
d <- d[-27,]
d <- d[-34,]


########### # The elicitor table  ######
d$age <- as.numeric(d$age)
demogr.tab <- data.frame(Age=d$age %>% split(d$Elicitor_gr) %>%
               lapply(function(x){
                   paste0((Publish::ci.mean(x)[1]) %>% unlist %>%  round(1),
                         " [",
                         Publish::ci.mean(x)[3] %>% unlist %>%  round(1),
                         " - ",
                         Publish::ci.mean(x)[4] %>% unlist %>%  round(1),
                         "]")
                 }) %>%
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
           ) %>%
             data.frame(Elicitor=rownames(.),
                 n=d$Elicitor_gr %>% factor %>% summary() %>% unlist,
                 .)

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
                      "ALS",NA,NA,NA
                      )

##### Therapy dissection ####

# d$Therapy

d$t_steroids <- c(T,T,T,T,T,F,T,T,T,T,
                  T,T,T,F,F,F,F,F,T,T,
                  T,F,T,T,T,T,T,T,F,T,
                  T,T,T,F,T,F,F,F,T,F,F,F)

d$t_antihistamines <- c(T,T,T,F,T,F,F,F,F,T,
                        T,T,T,F,F,F,F,F,T,F,
                        F,F,T,F,F,F,F,F,F,T,
                        T,F,F,T,F,F,F,F,T,F,F,F)

d$t_vasopressin <- rep(F,length(d$Therapy))
d$t_vasopressin[c(3,10,11,27,28,29,30,31,32,33,35)] <- T
terlipressin <- c(14,15)
d$t_vasopressin[terlipressin] <- T
d$t_vasopression <-  d$t_vasopressin

metaraminol <-c(1, 6,16,17)
isoprenaline.dobutamine <- c(22 ,36)
norepi <- c(27,28,30,31,32,33,35,36,1,2,3,5,10)
ephedrine <- c(40,41,42)
d$t_vasopression[c(metaraminol,isoprenaline.dobutamine,norepi)] <- T


cardiac_bypass <- c(10,11,15,3,6,19,41)

ALS <- c(17,18,19,21,25,30,39,6)

b2 <- c(12,2,3,4)

glucagon <- c(20,24)


###### Fatalities table ######

fat <- data.frame(d[which(d$Death=="yes"),c(4,6,7,29,31,32)],
           "Epinephrine [mg]"= c(25,20.2,NA,0.6,8,20,1.3),
           "Fluids [L]" = c(1.5,2.5,0,2,0,0,0.5),
           "Vasopressors" = c("+","+","-","+","-","+","+"))

source("R/pmf.R")
fat$t_steroids %<>% pmf()
fat$t_antihistamines %<>%  pmf()

#### Vasopresors analysis ####
temp.v <- d$What.helped_gr == "vasopressors"
d[temp.v,]

#### Conc Disease ####
d$Conc_ht <- c(F,T,F,F,F,F,F,F,F,T,T,F,F,T,T,F,F,F,T,T,F,T,F,T,F,F,F,F,T,F,F,F,T,T,F,T,T,T,T,F,F,F)
d$Conc_DM <- c(F,F,F,F,F,F,F,F,F,T,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,T,F,F,F,F,T,F,F,T,F,T,F,F,F)


#### The whole sources table #####
whole.tab <- data.frame(Author =paste0(d$Author," [",d$Source,"]"),
           Elicitor = d$Elicitor,
           Age = d$age,
           Sex =d$sex,
           Setting = d$Situation_gr,
           `What helped` =d$What.helped_gr,
           `Conc. diseases` = ifelse(d$Conc_ht==T,
                                    ifelse(d$Conc_DM == T, "HT, DM","HT"),
                                    ifelse(d$Conc_DM == T, "DM","")),
           Vasopressors= ifelse(d$t_vasopression==T,"yes","no"))
whole.tab$What.helped %<>% as.character()
whole.tab$What.helped[c(14,15,21,22,40:42)] <- "*"
d$sex %<>% as.character %>% lapply(function(x){
  ifelse(x=="male","man",x)
  }) %>%
  unlist %>%
  factor





#### table demo ####
agMF <- d$age %>% split(d$sex) %>% lapply(mean) %>% unlist %>% round(1)
n<- d$age %>% split(d$sex) %>% lapply(length) %>% unlist
d$Time %<>%  as.numeric()
T.postEx <- d$Time%>% split(d$sex) %>% lapply(median,na.rm=T) %>% unlist
HT_MF <- d$Conc_ht %>% split(d$sex) %>% lapply(function(x){
  sum(x)/length(x)*100
}) %>% unlist %>% round(1)
DM_MF <-d$Conc_DM %>% split(d$sex) %>% lapply(function(x){
  sum(x)/length(x)*100
}) %>% unlist() %>% round(1)
table_demo <- cbind(n,agMF,T.postEx,HT_MF,DM_MF)
