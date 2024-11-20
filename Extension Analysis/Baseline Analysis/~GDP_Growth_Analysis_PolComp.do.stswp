* #### investigating relationship between Composite and GDP Growth #######
setroot
use "DATA/concatenated/df_all_features.dta", clear

// keep if !missing(Corruption)
keep if !missing(Composite)
keep if !missing(GDP_Growth)

* relationship of GDP Growth and Composite
// scatter GDP_Growth Composite, title("GDP Growth and Political Risk")
regress GDP_Growth Composite, robust
est store Pol_Risk_GDP_Growth_1
estadd local fixed "No", replace

* with fixed time effects
encode Country, gen(country_id)
xtset country_id Year

* with controls for entity and time effects
xtreg GDP_Growth Composite, fe
est store Pol_Risk_GDP_Growth_2
estadd local fixed "Yes", replace

esttab Pol_Risk_GDP_Growth_1 Pol_Risk_GDP_Growth_2 ///
		using composite_gdp_growth_baseline.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed r2 rss N, label("Fixed Effects" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects")
		

* ---------------------------------------------------------------------------- *

* With Log GDP Growth
generate log_gdp_growth = ln(GDP_Growth)
// scatter log_gdp_growth Composite, title("Log GDP Growth and Composite")

regress log_gdp_growth Composite, robust
est store Pol_Risk_Ln_GDP_Growth_1
estadd local fixed "No", replace

* with controls for entity and time effects
xtreg log_gdp_growth Composite, fe
est store Pol_Risk_Ln_GDP_Growth_2
estadd local fixed "Yes", replace

* table for regressions involving GDP Per Capita and Corruption
esttab Pol_Risk_Ln_GDP_Growth_1 Pol_Risk_Ln_GDP_Growth_2 ///
		using composite_log_gdp_growth_baseline.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed r2 rss N, label("Fixed Effects" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects")
