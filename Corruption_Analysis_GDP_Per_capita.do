* importing data
use "df_all_features.dta", clear

* removing missing values
keep !missing("corruption")
keep !missing("gdp")

* scatter of gdp and corruption
scatter gdp corruption
