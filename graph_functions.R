# graph functions
source("global")

eq_mosaic<-function(data){
  # REQUIRES PRECISE VARIABLE NAMES
  # this will be a problem when we implement this later.
  data <- melt(data)
  require(ggplot2)
  require(ggmosaic)
  require(ggthemes)
  p<-ggplot(data=data) + geom_mosaic(aes(weight=data$value, x = product(data$variable), fill = data$group))+
    scale_fill_manual(values=uvapal)+
     labs(
       title="Demographic Percentages",
       x = "",
       y = "Percent by Demographic",
       color = "Demographic Groups"
     ) + 
     theme_bw()
  return(p)
}

eq_survival<-function(){
  
}

# Logistic Regression Added Variable Plot?
