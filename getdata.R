#GET DATA SCRIPT

library(osmdata)
library(tidyverse)

# create a bbbox
bbx <- getbb("x")

# change the names
colnames(bbx) <- c("min","max")
rownames(bbx) <- c("lon", "lat")

#bbx etc.
min_lon <- bbx["lon","min"]; max_lon <- bbx["lon","max"]
min_lat <- bbx["lat","min"]; max_lat <- bbx["lat","max"]

bbx <- rbind(x=c(min_lon,max_lon),y=c(min_lat,max_lat))
colnames(bbx) <- c("min","max")

#get the roads
highways <- bbx %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value=c("motorway", "trunk",
                          "primary","secondary", 
                          "tertiary","motorway_link",
                          "trunk_link","primary_link",
                          "secondary_link",
                          "tertiary_link")) %>%
  osmdata_sf()


streets <- bbx %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "service","unclassified",
                            "pedestrian", "footway",
                            "track","path")) %>%
  osmdata_sf()

write_rds(highways, file = here("x/data/x_highway.rds"))
write_rds(streets, file = here("x/data/x_street.rds"))