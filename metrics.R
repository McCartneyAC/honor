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

median_ttr<-function(df, starts, ends, group_var = NULL) {
  # this is on the right track for a tidyeval version of median ttr,
  # but it needs to be tested and I *don't* think that the pipe structure
  # will actually create a ttr variable that can be operated upon by median
  # later in the function. 
  # TODO: read more about tidy eval; test this function
  require(lubridate)
  require(dplyr)
  if (group_var == NULL){
    df %>% 
      summarize(ttr = as.duration(ymd(.data$ends)-ymd(.data$starts)))
  } else {
    group_var<-enquo(group_var)
    df %>% 
      filter(.data$group = !!group_var) %>% 
      summarize(ttr = as.duration(ymd(.data$ends)-ymd(.data$starts)))
  }
  med_ttr<-median(ttr)
  return(med_ttr)
}
