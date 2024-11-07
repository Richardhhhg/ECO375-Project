* importing data
use "df_all_features.dta", clear

* removing missing values
keep if !missing(Corruption)
keep if !missing(GDP)

* scatter of gdp and corruption
scatter GDP Corruption, title("Real GDP and Corruption Index")

* variable for log of GDP
generate log_gdp = ln(GDP)
scatter log_gdp Corruption, title("Log Real GDP and Corruption Index")

regress log_gdp Corruption
est store Corruption_GDP_1

* table for regressions involving Log GDP and Corruption
estimates table Corruption_GDP_1, b(%9.3f) se stats(r2)

* investigating relationship between Corruption and GDP per Capita
* Resetting Everything Each time Since Potentially Different Missing Vars
use "df_all_features.dta", clear

keep if !missing(Corruption)
keep if !missing(GDP_Per_Capita)

scatter GDP_Per_Capita Corruption, title("GDP per Capita and Corruption")

regress GDP_Per_Capita Corruption
est store Corruption_GDP_per_capita_1

generate log_gdp_per_capita = ln(GDP_Per_Capita)
scatter log_gdp_per_capita Corruption, title("Log GDP perCapita and Corruption")

regress log_gdp_per_capita Corruption
est store Corruption_log_GDP_per_capita_1

* table for regressions involving GDP Per Capita and Corruption
estimates table Corruption_GDP_per_capita_1, b(%9.3f) se stats(r2)
estimates table Corruption_log_GDP_per_capita_1, b(%9.3f) se stats(r2)

* investigating relationship between Corruption and GDP Growth
use "df_all_features.dta", clear

keep if !missing(Corruption)
keep if !missing(GDP_Growth)

scatter GDP_Growth Corruption, title("GDP per Capita and Corruption")

regress GDP_Growth Corruption
est store Corruption_GDP_Growth_1

* table for regressions involving GDP Growth and Corruption
estimates table Corruption_GDP_Growth_1, b(%9.3f) se stats(r2)
