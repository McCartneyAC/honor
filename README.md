# `honor`
A shiny dashboard app for processing Honor Case and Support Officer Statistics

## Overview
This application project seeks to establish an onling dashboard which will allow future members of the UVA Honor Committee to track data on (1) case processing statistics such as time-to-resolution and equity of outcomes by demographic groups and (2) support officer pool statistics to ensure equity of representation within the pool. 

Because all Honor data are deeply confidential [(see FERPA)](https://www2.ed.gov/policy/gen/guid/fpco/ferpa/index.html?), no student data of any kind will be included in this application. The functionality comes from allowing a user who has access to those data to input them into the application, run any metrics or analyses, and then leave the app. All user data should be scrubbed from `shinyapps.io` after the user finishes her analysis.  

## Case Data
The user should be able to import a microsoft `excel` or `csv` spreadsheet of case level statistics onto the navigation pane and to return with charts depicting analyses of interest. 

The two most likely needed analyses are: 
### Case Processing Time
I don't know if this requires any particularly advanced analysis other than describing time-to-resolution statistics. However, it might be interesting to attempt to do some kind of survival-analysis style graphical depictions of this, especially by demographic subgroups or student-choice subgroups (i.e. we know that CMD cases have the longest time-to-resolution. 

### Equity
Ideally, this section will incorporate programming from `tidystats` package to output the results of logistic regressions which will tell the user, at a glance and without requiring knowledge of statistical inference, whether certain subgroups are beating statistical chance in being accused or found guilty of Honor offenses.

It should also include some easy to use graphical representation of equity data, e.g. a mosaic plot or repeated bar charts, to give an at-a-glance representation of equity outcomes. 

#### Mosaic Plot Example 
![Gifted Identification in Albemarle County](https://github.com/McCartneyAC/honor/blob/master/test_data/mosaic.png?raw=true)

## Support Officer Data
Additionally, support officer pool data can be input as well. This feature should enable both current pool and incoming pool data tracking abilities. These should be graph-able in some way, as well, beyond just pie charts (or perhaps a pie chart within a donut chart? I'll think about it). 

### Metrics
To measure the representativeness of the Support Officer Pool, this application dashboard calculates the Relative Difference In composition Index (RDCI) and the Equity Index (EI) metrics. These are both derived from the literature on gifted student identification and, in the case of EI, are derived from the Department of Education's Office of Civil Rights. Special thanks for VMH for introducing us to RDCI and EI and allowing us to quote/paraphrase her capstone on gifted student identification in the descriptions that follow. 

RDCI is a measure of difference between the race of a population (all students) and the population of a subgroup (gifted students; Honor support officers) to determine if the subgroup is representatively drawn from the population. EI generates a figure which represents the minimum number of students that *should* be in the subgroup in order for the subgroup to be representative of the population, based on the principle that representativeness means two populations are within 80% agreement with each other on demographic breakdowns. 

Both of these metrics will require accurate data on the student body of UVA as a population in order to calculate. This is our second major data need (behind the original data files being held on Newcomb Fourth Floor). 

from VMH's capstone: 
#### RDCI
>The RDCI “for a racial or cultural group is the difference between their gifted education composition and general education composition, expressed as a percentage of their general education composition” (Ford, 2014, p. 144). ...  It is “not adequate for determining what is unacceptable or possibly illegal/discriminatory underrepresentation; nor is it specific enough to determine goals for improving representation” (Ford, 2014, p. 145). 

##### RDCI Example in R
```r
> RCDI<-function(groups,pop,sample){
+   # requires data input to be a list of a # of students for each race
+   # TODO: Rewrite as a tidy version. 
+   pcttot<-pop / sum(pop)
+   pctgift <-sample / sum(sample)
+   z <- pop-sample
+   pctnon<-z / sum(z)
+   rcdi <- ((pctgift - pctnon ) / (pctnon)) * 100
+   rcdi <- round(rcdi, digits =2)
+   grps <- groups
+   mat <- as.data.frame(cbind(grps, rcdi))
+   return(mat)
+ }
> albemarle
         race division gifted
1       asian      729    102
2       black     1482     32
3    hispanic     1824     40
4 two or more      841     80
5       white     9196   1114
> RCDI(albemarle$race, albemarle$division, albemarle$gifted)
         grps   rcdi
1       asian  51.07
2       black -79.51
3    hispanic -79.18
4 two or more  -2.38
5       white     28
> 
```
In this case, we would determine that Asian students and White students are overrepresented among gifted students in ACPS; whereas Black and Hispanic students are roughly equally under-represented in gifted education. Similar calculations can be done for racial groups to determine support officer representation, but more valuable is: 


#### EI 
>The EI should theoretically be the minimally accepted level of underrepresentation for each group because once the percentage of underrepresentation exceeds that designated threshold, it is beyond statistical chance, meaning policies and procedures may be discriminatory against CLD groups (Ford, 2014). 

##### EI Example
```r 
> EI<-function(groups,pop,sample){
+   # requires data input to be a list of a # of students for each race
+   # TODO: Rewrite as a tidy version to allow for piping over data frame restructuring
+   pcttot<-pop / sum(pop)
+   pctgift <-sample / sum(sample)
+   z <- pop-sample
+   pctnon<-(z / sum(z))*100
+   part1<- pctnon*0.20
+   part2<- pctnon-part1
+   Number_Needed<-round(part2, digits = 0)
+   grps <- groups
+   mat <- as.data.frame(cbind(grps, Number_Needed))
+   return(mat)
+ }
> albemarle
         race division gifted
1       asian      729    102
2       black     1482     32
3    hispanic     1824     40
4 two or more      841     80
5       white     9196   1114
> EI(albemarle$race, albemarle$division, albemarle$gifted)
         grps Number_Needed
1       asian             4
2       black             9
3    hispanic            11
4 two or more             5
5       white            51
> 
```
