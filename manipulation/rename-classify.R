#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load_sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.

# ---- load_packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) #Pipes

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2", quietly=TRUE)
requireNamespace("dplyr", quietly=TRUE) #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit", quietly=TRUE)
# requireNamespace("plyr", quietly=TRUE)

# ---- declare_globals ---------------------------------------------------------
# path_input  <- "./data-phi-free/raw/results-physical-cognitive.csv"
path_input  <- "https://raw.githubusercontent.com/IALSA/IALSA-2015-Portland/master/data/shared/results-physical-cognitive.csv"
path_output <- "./data-phi-free/derived/results.rds"
figure_path <- 'manipulation/stitched-output/rename-classify/'


# ---- load_data ---------------------------------------------------------------
ds0 <- read.csv(path_input, stringsAsFactors=FALSE)

# ---- tweak_data --------------------------------------------------------------
colnames(ds0)

ds <- ds0 %>% dplyr::arrange_("cognitive_measure")
 

# ---- spell_model_number ------------------------------------------------------
t <- table(ds$model_number, ds$study_name);t[t==0]<-".";t


# ---- spell_subgroup ---------------------------------------------------------
t <- table(ds$subgroup, ds$study_name);t[t==0]<-".";t



# ---- spell_model_type
t <- table(ds$model_type, ds$study_name);t[t==0]<-".";t


# ---- correct_model_type ------------------------------------------------------

# Read in the conversion table, and drop the `notes` variable.
ds_model_type_key <- read.csv("./manipulation/model-type-entry-table.csv", stringsAsFactors = F) %>%
  dplyr::select(-notes)

# Join the model data frame to the conversion data frame.
ds <- ds %>% 
  dplyr::left_join(ds_model_type_key, by=c("model_type"="entry"))

t <- table(ds$category_short, ds$study_name);t[t==0]<-".";t
t <- table(ds$model_type, ds$category_short);t[t==0]<-".";t # raw rows, new columns

# Remove the old variable, and rename the cleaned/condensed variable.
ds <- ds %>% 
  dplyr::select(-model_type) %>% 
  dplyr::rename_("model_type"="category_short")


# ---- spell_physical_measure -------------------------------------------------
t <- table(ds$physical_measure, ds$study_name); t[t==0]<-"."; t

# ---- correct_physical_measure ------------------------------------------------
# Read in the conversion table, and drop the `notes` variable.
ds_physical_measure_key <- read.csv("./manipulation/physical-measure-entry-table.csv", stringsAsFactors = F) %>%
  dplyr::select(-notes)

# Join the model data frame to the conversion data frame.
ds <- ds %>% 
  dplyr::left_join(ds_physical_measure_key, by=c("physical_measure"="entry"))

t <- table(ds$category_short, ds[ ,"study_name"]);t[t==0]<-".";t
t <- table(ds[ ,"physical_measure"], ds$category_short);t[t==0]<-".";t # raw rows, new columns

# Remove the old variable, and rename the cleaned/condensed variable.
ds <- ds %>% 
  dplyr::select(-physical_measure) %>% 
  dplyr::rename_("physical_measure"="category_short")

t <- table(ds$physical_measure, ds$study_name); t[t==0]<-"."; t





## @knitr spell_cognitive_measure
t <- table(ds$cognitive_measure, ds$study_name);t[t==0]<-".";t
d <- ds %>% dplyr::group_by_("cognitive_measure","study_name") %>% dplyr::summarize(count=n())
d <- d %>% dplyr::ungroup() %>% dplyr::arrange_("study_name")
knitr::kable(d)
 
# ---- correct_cognitive_measure ------------------------------------------------
# Read in the conversion table, and drop the `notes` variable.
ds_cognitive_measure_key <- read.csv("./manipulation/cognitive-measure-entry-table.csv", stringsAsFactors = F) %>%
  dplyr::select(-notes, -mplus_name, -study_name)

# Join the model data frame to the conversion data frame.
# ds <- ds %>% 
ds <- ds0 %>% 
  dplyr::left_join(ds_cognitive_measure_key, by=c("cognitive_measure"="entry"))

t <- table(ds[ ,"cell_label"], ds[,"study_name"]);t[t==0]<-".";t
t <- table(ds[ ,"row_label"],  ds[,"study_name"]);t[t==0]<-".";t
t <- table(ds[ ,"domain"],     ds[,"study_name"]);t[t==0]<-".";t
# the table below may be impractical
t <- table(ds[,"cognitive_measure"], ds[,"cell_label"]);t[t==0]<-".";t # raw rows, new columns


# Remove the old variable, and rename the cleaned/condensed variable.
ds <- ds %>%  
  dplyr::select(-cognitive_construct) %>% 
  dplyr::rename_("cognitive_measure_0"="cognitive_measure") %>% # store original values
  dplyr::rename_("cognitive_construct"="domain") %>%
  dplyr::rename_("cognitive_measure_row"="row_label")%>%
  dplyr::rename_("cognitive_measure"="cell_label") 

# t <- table(ds[ ,"cognitive_measure_0"], ds[ ,"study_name"]); t[t==0]<-"."; t 
# t <- table(ds[ ,"cognitive_measure"], ds[ ,"study_name"]); t[t==0]<-"."; t  
# t <- table(ds[ ,"cognitive_measure_row"], ds[ ,"study_name"]); t[t==0]<-"."; 


d <- ds %>% dplyr::filter(is.na(cognitive_measure)) # remove unidentified measures
# show unidentified measures only
t <- table(d[ ,"cognitive_measure_0"], d[ ,"study_name"]); t[t==0]<-"."; t 

# ---- test_cog_measures ---------------------------------------
t <- table(ds$cognitive_measure, ds$study_name);t[t==0]<-".";t
d <- ds %>% dplyr::group_by_("cognitive_measure","study_name") %>% dplyr::summarize(count=n())
d <- d %>% dplyr::ungroup() %>% dplyr::arrange_("study_name")
knitr::kable(d)





