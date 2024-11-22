// 
//PURPOSE OF THIS FILE
// This File is mean to look at the individual components of the polrisk composite
// and find how that relates to GDP and log GDP, see GDP_Analysis_PolComp
// for relation of just PolComp and GDP/LogGDP
//

* Loading Data also encoding for fixed effects later on
setroot
use "DATA/concatenated/df_all_features.dta", clear

* No Control No Fixed Effects
regress GDP Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec1
estadd local fixed "No", replace
estadd local Controls "No", replace

* With Control No Fixed Effects
regress GDP Government_Stability Socioeconomic_Conditions Investment_Profile ///
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
xtreg GDP Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, fe cluster(country_id)
est store spec3
estadd local fixed "Yes", replace
estadd local Controls "No", replace

* Yes Control Yes Fixed Effects
xtreg GDP Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, fe cluster(country_id)
est store spec4
estadd local fixed "Yes", replace
estadd local Controls "Yes", replace
		
esttab spec1 spec2 spec3 spec4 ///
		using gdp_table.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed Controls r2 rss N, label("Fixed Effects" "Controls" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects"  "Controls: Population, CAXGS, Budget_Balance, Current Account, Debt Service, Exchange Rate, Foreign Debt, Inflation, international Liquidity") ///
		keep(Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality)
		
//
// With Log of GDP
//
generate log_gdp = ln(GDP)

* No Control No Fixed Effects
regress log_gdp Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec5
estadd local fixed "No", replace
estadd local Controls "No", replace

* Yes Control No Fixed Effects
regress log_gdp Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, robust
est store spec6
estadd local fixed "No", replace
estadd local Controls "Yes", replace

* No Control Yes Fixed Effects
xtreg log_gdp Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, fe cluster(country_id)
est store spec7
estadd local fixed "Yes", replace
estadd local Controls "No", replace

* Yes Control Yes Fixed Effects
xtreg log_gdp Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, fe cluster(country_id)
est store spec8
estadd local fixed "Yes", replace
estadd local Controls "Yes", replace

esttab spec5 spec6 spec7 spec8 ///
		using log_gdp_table.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
		s(fixed Controls r2 rss N, label("Fixed Effects" "Controls" <i>R<i><sup>2</sup> <i>rss<i> ///
		<i>N<i>)) ///
		addnotes("Fixed Effects include time and entity effects"  "Controls: Population, CAXGS, Budget_Balance, Current Account, Debt Service, Exchange Rate, Foreign Debt, Inflation, international Liquidity") ///
		keep(Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality)
