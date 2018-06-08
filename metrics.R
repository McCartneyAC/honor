# metrics
 
RCDI<-function(groups,pop,sample){
  # requires data input to be a list of a # of students for each race
  # TODO: Rewrite as a tidy version. 
  pctgift<-pop / sum(pop)
  pcttot <-sample / sum(sample)
  z <- sample-pop
  pctnon<-z / sum(z)
  rcdi <- ((pctgift - pctnon ) / (pctnon)) * 100
  rcdi <- round(rcdi, digits =2)
  grps <- groups
  mat <- as.data.frame(cbind(grps, rcdi))
  return(mat)
}

EI<-function(x,y){
  pctgift<-x / sum(x)
  pcttot <-y / sum(y)
  z <- y-x
  pctnon<-(z / sum(z))*100
  part1<- pctnon*0.20
  part2<- pctnon-part1
  return(part2)
}