# metrics
 
RCDI<-function(groups,pop,sample){
  # requires data input to be a list of a # of students for each race
  # TODO: Rewrite as a tidy version. 
  pcttot<-pop / sum(pop)
  pctgift <-sample / sum(sample)
  z <- pop-sample
  pctnon<-z / sum(z)
  rcdi <- ((pctgift - pctnon ) / (pctnon)) * 100
  rcdi <- round(rcdi, digits =2)
  mat <- as.data.frame(cbind(groups, rcdi))
  return(mat)
}

EI<-function(groups,pop,sample){
  # requires data input to be a list of a # of students for each race
  # TODO: Rewrite as a tidy version to allow for piping over data frame restructuring
  pcttot<-pop / sum(pop)
  target<-pcttot*0.80
  part2 <- target*sum(sample)
  Number_Needed<-round(part2, digits = 0)
  mat <- as.data.frame(cbind(groups, Number_Needed))
  return(mat)
}
