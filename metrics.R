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
  grps <- groups
  mat <- as.data.frame(cbind(grps, rcdi))
  return(mat)
}

EI<-function(groups,pop,sample){
  # requires data input to be a list of a # of students for each race
  # TODO: Rewrite as a tidy version to allow for piping over data frame restructuring
  pcttot<-pop / sum(pop)
  pctgift <-sample / sum(sample)
  z <- pop-sample
  pctnon<-(z / sum(z))*100
  part1<- pctnon*0.20
  part2<- pctnon-part1
  Number_Needed<-round(part2, digits = 0)
  grps <- groups
  mat <- as.data.frame(cbind(grps, Number_Needed))
  return(mat)
}