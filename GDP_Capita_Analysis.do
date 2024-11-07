* #### investigating relationship between Corruption and GDP per Capita #######
* Resetting Everything Each time Since Potentially Different Missing Vars
use "df_all_features.dta", clear

// keep if !missing(Corruption)
keep if !missing(Composite)
keep if !missing(GDP_Per_Capita)

* relationship of GDP and Composite
scatter GDP_Per_Capita Composite, title("GDP Per Capita and Political Risk")
regress GDP_Per_Capita Composite
est store Pol_Risk_GDP_Capita_1

* with fixed time effects
encode Country, gen(country_id)
xtset country_id Year

* with controls for entity and time effects
xtreg GDP_Per_Capita Composite
est store Pol_Risk_GDP_Capita_2

* ---------------------------------------------------------------------------- *

* With Log GDP Per Capita
generate log_gdp_per_capita = ln(GDP_Per_Capita)
scatter log_gdp_per_capita Composite, title("Log GDP Per Capita and Composite")

regress log_gdp_per_capita Corruption
est store Pol_Risk_Ln_GDP_Capita_1

* with controls for entity and time effects
xtreg log_gdp_per_capita Composite
est store Pol_Risk_Ln_GDP_Capita_2

* table for regressions involving GDP Per Capita and Corruption
estimates table Corruption_GDP_per_capita_1, b(%9.3f) se stats(r2)
estimates table AMONGUS, b(%9.3f) se stats(r2)
