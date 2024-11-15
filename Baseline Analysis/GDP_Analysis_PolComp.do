* importing data
use "df_all_features.dta", clear

* removing missing values
keep if !missing(Composite)
keep if !missing(GDP)

* relationship of GDP and Composite
scatter GDP Composite, title("Real GDP and Political Risk")
regress GDP Composite
est store Pol_Risk_GDP_1

* with fixed time effects
encode Country, gen(country_id)
xtset country_id Year

xtreg GDP Composite
est store Pol_Risk_GDP_2

* Controlling for things for future study
// scatter GDP Corruption, title("Real GDP and Corruption Index")
// regress GDP Corruption
// est store Corruption_GDP_1

* controlling for corruption
// regress GDP Composite Corruption
// est store Pol_Risk_GDP_3

estimates table Pol_Risk_GDP_1 Pol_Risk_GDP_2, b(%9.3f) se stats(r2)

* ---------------------------------------------------------------------------- *

* With Log of GDP
generate log_gdp = ln(GDP)
scatter log_gdp Composite, title("Log GDP and Political Risk")

regress log_gdp Composite
est store Pol_Risk_Ln_GDP_1

* with control for entity and time effects
xtreg log_gdp Composite
est store Pol_Risk_Ln_GDP_2

// regress log_gdp Corruption
// est store Corruption_Ln_GDP_1

* table for regressions involving Log GDP and Corruption
estimates table Pol_Risk_Ln_GDP_1 Pol_Risk_Ln_GDP_2, b(%9.3f) se stats(r2)