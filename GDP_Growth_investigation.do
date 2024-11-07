* #### investigating relationship between Composite and GDP Growth #######
use "df_all_features.dta", clear

// keep if !missing(Corruption)
keep if !missing(Composite)
keep if !missing(GDP_Growth)

* relationship of GDP Growth and Composite
scatter GDP_Growth Composite, title("GDP Growth and Political Risk")
regress GDP_Growth Composite
est store Pol_Risk_GDP_Growth_1

* with fixed time effects
encode Country, gen(country_id)
xtset country_id Year

* with controls for entity and time effects
xtreg GDP_Growth Composite
est store Pol_Risk_GDP_Growth_2

estimates table Pol_Risk_GDP_Growth_1 Pol_Risk_GDP_Growth_2, b(%9.3f) se stats(r2)

* ---------------------------------------------------------------------------- *

* With Log GDP Growth
generate log_gdp_growth = ln(GDP_Growth)
scatter log_gdp_growth Composite, title("Log GDP Growth and Composite")

regress log_gdp_growth Composite
est store Pol_Risk_Ln_GDP_Growth_1

* with controls for entity and time effects
xtreg log_gdp_growth Composite
est store Pol_Risk_Ln_GDP_Growth_2

* table for regressions involving GDP Per Capita and Corruption
estimates table Pol_Risk_Ln_GDP_Growth_1 Pol_Risk_Ln_GDP_Growth_2, b(%9.3f) se stats(r2)
