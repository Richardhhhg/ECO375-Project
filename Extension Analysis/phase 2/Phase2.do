* Setting Working Directory
setroot

* Erase existing yaml files
capture erase "${root}/results/phase2.yaml"

* load data
use "${root}/data/raw/data_2019_2020_2022.dta", clear

* Relation between GDP and Corruption
scatter GDP Corruption, ytitle("Log GDP") xtitle("Corruption Risk")
graph export "${root}/results/scatter.pdf"

* regression of gdp and corruption
reg GDP Corruption, robust
reg GDP Corruption, robust coeflegend
display _N
display _b[Corruption]
display _se[Corruption]

* Saving Variables to YAML
yamlout using "${root}/results/phase2.yaml", key(ols_num_obs) value(`=_N') replace
yamlout using "${root}/results/phase2.yaml", key(ols_slope) value(`=_b[Corruption]')
yamlout using "${root}/results/phase2.yaml", key(ols_slope_se) value(`=_se[Corruption]')

