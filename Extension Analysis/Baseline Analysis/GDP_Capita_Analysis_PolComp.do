* #### investigating relationship between Corruption and GDP per Capita #######
* Resetting Everything Each time Since Potentially Different Missing Vars
setroot
use "DATA/concatenated/df_all_features.dta", clear

// keep if !missing(Corruption)
keep if !missing(Composite)
keep if !missing(GDP_Per_Capita)

* relationship of GDP and Composite
// scatter GDP_Per_Capita Composite, title("GDP Per Capita and Political Risk")
regress GDP_Per_Capita Composite, robust
est store Pol_Risk_GDP_Capita_1
estadd local fixed "No", replace

* with fixed time effects
encode Country, gen(country_id)
xtset country_id Year

* with controls for entity and time effects
xtreg GDP_Per_Capita Composite, fe cluster(country_id)
est store Pol_Risk_GDP_Capita_2
estadd local fixed "Yes", replace

esttab Pol_Risk_GDP_Capita_1 Pol_Risk_GDP_Capita_2 ///
		using composite_gdp_capita_baseline.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed r2 rss N, label("Fixed Effects" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects")

* ---------------------------------------------------------------------------- *

* With Log GDP Per Capita
generate log_gdp_per_capita = ln(GDP_Per_Capita)
// scatter log_gdp_per_capita Composite, title("Log GDP Per Capita and Composite")

regress log_gdp_per_capita Composite, robust
est store Pol_Risk_Ln_GDP_Capita_1
estadd local fixed "No", replace

* with controls for entity and time effects
xtreg log_gdp_per_capita Composite, fe cluster(country_id)
est store Pol_Risk_Ln_GDP_Capita_2
estadd local fixed "Yes", replace

* table for regressions involving GDP Per Capita and Corruption
esttab Pol_Risk_Ln_GDP_Capita_1 Pol_Risk_Ln_GDP_Capita_2 ///
		using composite_ln_gdp_capita_baseline.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed r2 rss N, label("Fixed Effects" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects")
