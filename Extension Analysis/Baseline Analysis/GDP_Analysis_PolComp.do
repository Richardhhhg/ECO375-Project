* importing data
setroot
use "DATA/concatenated/df_all_features.dta", clear

* removing missing values
keep if !missing(Composite)
keep if !missing(GDP)

* relationship of GDP and Composite
// scatter GDP Composite, title("Real GDP and Political Risk")
regress GDP Composite, robust
est store Pol_Risk_GDP_1
estadd local fixed "No", replace

* with fixed time effects
encode Country, gen(country_id)
xtset country_id Year

xtreg GDP Composite, fe cluster(country_id)
est store Pol_Risk_GDP_2
estadd local fixed "Yes", replace

esttab Pol_Risk_GDP_1 Pol_Risk_GDP_2 ///
		using composite_gdp_baseline.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed r2 rss N, label("Fixed Effects" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects")

* ---------------------------------------------------------------------------- *

* With Log of GDP
generate log_gdp = ln(GDP)
// scatter log_gdp Composite, title("Log GDP and Political Risk")

regress log_gdp Composite, robust
est store Pol_Risk_Ln_GDP_1
estadd local fixed "No", replace

* with control for entity and time effects
xtreg log_gdp Composite, fe cluster(country_id)
est store Pol_Risk_Ln_GDP_2
estadd local fixed "Yes", replace

* table for regressions involving Log GDP
esttab Pol_Risk_Ln_GDP_1 Pol_Risk_Ln_GDP_2 ///
		using composite_log_gdp_baseline.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed r2 rss N, label("Fixed Effects" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects")

