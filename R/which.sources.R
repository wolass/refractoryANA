which.sources <- function(sources,pattern,variables){
  su <- NULL
  if(class(variables)=="list"){
    su <- lapply(variables,function(x){
      sources[grep(x = x, pattern=pattern)]
    }) %>% unlist %>% unique()
  } else {
    s <- sources[grep(x = variables, pattern = pattern)]
    su <- unique(s)
  }

  paste(su,collapse="; ")
}

