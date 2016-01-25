`./manipulation/` Directory
=========

Files in this directory manipulate/groom/munge project data.  The resulting "derived" datasets produce less friction when analyzing.  By centralizing most (and ideally all) of the manipulation code in one place, it's easier to determine how the data was changed before analyzing.  It also reduces duplication of manipulation code, so analyses in different files are more consistent and understandable.


- `rename-classify.R` starts with the raw data file `results-physical-cognitive.csv`  that aggregates extracted model estimation results for the physical-cognitive track of the Portland project. To see the origin of the file, please refer to the [`./data/shared/README`](https://github.com/IALSA/IALSA-2015-Portland/tree/master/data/shared) of the [IALSA-2015-Portland](https://github.com/IALSA/IALSA-2015-Portland) repository. 

- a model is uniquely defined by its study and its 4-key ID:  `sex-covariateSet-physicalMeasure-cognitiveMeasure`. ![ model ID](https://github.com/IALSA/IALSA-2015-Portland/blob/master/libs/images/model_naming_convention.png). We used to ask to provide the constructs as well, but we do it ourselves now, so we dropped the `physicalConstruct` and `cogntiveConstruct`. However, we kept `b1` type of indicator,  because it was proven to be useful in file sorting and management, as well as quick recall in reports. 

`rename-classify.R`  does two things:

1. corrects misspellings and human erros in the file names that participants sumbitted
 - (a). sex 
 - (b). model type - [model-type-entry-table.csv](https://github.com/IALSA/Portland-physical-cognitive/blob/master/manipulation/model-type-entry-table.csv)
 - (c). physical Measure  - [physical-measure-entry-table.csv](https://github.com/IALSA/Portland-physical-cognitive/blob/master/manipulation/physical-measure-entry-table.csv)
 - (d). cognitive Measure  - [`cognitive-measure-entry-table.csv`](https://github.com/IALSA/Portland-physical-cognitive/blob/master/manipulation/cognitive-measure-entry-table.csv)

2. Assigns each Measures into one and only one Construct

These two things are accomplished by relational maps, captured by the  `.csv` tables next tot he ID keys above.

## Current domain map
The graph reflects the mapping in the `.csv` tables. To adjust the graph, one must adjust the `.csv` tables in the bullets above. 
![current domain map](https://raw.githubusercontent.com/IALSA/Portland-physical-cognitive/master/analysis/model_space/cog_domain_map/domain_map-1.png)

Read the full report that produced the graph at [Portland-physical-cognitive/analysis/model_space/Cog-Domain-Map.md](https://github.com/IALSA/Portland-physical-cognitive/blob/master/analysis/model_space/Cog-Domain-Map.md)

