* #### investigating relationship between Corruption and GDP per Capita #######
* Resetting Everything Each time Since Potentially Different Missing Vars
setroot
use "df_all_features.dta", clear

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

* #### investigating relationship between Composite and GDP Growth #######
setroot
use "df_all_features.dta", clear

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

* Loading Data also encoding for fixed effects later on
setroot
use "df_all_features.dta", clear

* No Control No Fixed Effects
regress GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec1
estadd local fixed "No", replace
estadd local Controls "No", replace

* With Control No Fixed Effects
regress GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, robust
est store spec2
estadd local fixed "No", replace
estadd local Controls "Yes", replace

* No Control Yes Fixed Effects
encode Country, gen(country_id)
xtset country_id Year
xtreg GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, fe cluster(country_id)
est store spec3
estadd local fixed "Yes", replace
estadd local Controls "No", replace

* Yes Control Yes Fixed Effects
xtreg GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, fe cluster(country_id)
est store spec4
estadd local fixed "Yes", replace
estadd local Controls "Yes", replace
		
esttab spec1 spec2 spec3 spec4 ///
		using gdp_capita_table.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed Controls r2 rss N, label("Fixed Effects" "Controls" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects"  "Controls: Population, CAXGS, Budget_Balance, Current Account, Debt Service, Exchange Rate, Foreign Debt, Inflation, international Liquidity") ///
		keep(Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality)
		
//
// With Log of GDP Per Capita
//
generate log_gdp_capita = ln(GDP_Per_Capita)

* No Control No Fixed Effects
regress log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec5
estadd local fixed "No", replace
estadd local Controls "No", replace

* Yes Control No Fixed Effects
regress log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, robust
est store spec6
estadd local fixed "No", replace
estadd local Controls "Yes", replace

* No Control Yes Fixed Effects
xtreg log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, fe cluster(country_id)
est store spec7
estadd local fixed "Yes", replace
estadd local Controls "No", replace

* Yes Control Yes Fixed Effects
xtreg log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, fe cluster(country_id)
est store spec8
estadd local fixed "Yes", replace
estadd local Controls "Yes", replace

esttab spec5 spec6 spec7 spec8 ///
		using log_gdp_capita_table.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed Controls r2 rss N, label("Fixed Effects" "Controls" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects"  "Controls: Population, CAXGS, Budget_Balance, Current Account, Debt Service, Exchange Rate, Foreign Debt, Inflation, international Liquidity") ///
		keep(Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality)

* Loading Data also encoding for fixed effects later on
setroot
use "df_all_features.dta", clear

* No Control No Fixed Effects
regress GDP_Growth Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec1
estadd local fixed "No", replace
estadd local Controls "No", replace

* With Control No Fixed Effects
regress GDP_Growth Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, robust
est store spec2
estadd local fixed "No", replace
estadd local Controls "Yes", replace

* No Control Yes Fixed Effects
encode Country, gen(country_id)
xtset country_id Year
xtreg GDP_Growth Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, fe cluster(country_id)
est store spec3
estadd local fixed "Yes", replace
estadd local Controls "No", replace

* Yes Control Yes Fixed Effects
xtreg GDP_Growth Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, fe cluster(country_id)
est store spec4
estadd local fixed "Yes", replace
estadd local Controls "Yes", replace
		
esttab spec1 spec2 spec3 spec4 ///
		using gdp_growth_table.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed Controls r2 rss N, label("Fixed Effects" "Controls" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects"  "Controls: Population, CAXGS, Budget_Balance, Current Account, Debt Service, Exchange Rate, Foreign Debt, Inflation, international Liquidity") ///
		keep(Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality)