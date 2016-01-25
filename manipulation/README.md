`./manipulation/` Directory
=========

Files in this directory manipulate/groom/munge project data.  The resulting "derived" datasets produce less friction when analyzing.  By centralizing most (and ideally all) of the manipulation code in one place, it's easier to determine how the data was changed before analyzing.  It also reduces duplication of manipulation code, so analyses in different files are more consistent and understandable.


- `rename-classify.R` starts with the raw data file `results-physical-cognitive.csv`  that aggregates extracted model estimation results for the physical-cognitive track of the Portland project. To see the origin of the file, please refer to the [`./data/shared/README`](https://github.com/IALSA/IALSA-2015-Portland/tree/master/data/shared) of the [IALSA-2015-Portland](https://github.com/IALSA/IALSA-2015-Portland) repository. 
- [`./manipulation/model-type-entry-table.csv`]() then provides a renaming schema, which was constructed manually. 

