* Loading Data also encoding for fixed effects later on
setroot
use "DATA/concatenated/df_all_features.dta", clear
// egen missing_count = rowmiss(Population CAXGS Budget_Balanace CACC DebtServ ///
// 						  Exchange_Rate Foreign_Debt Inflation ///
// 						  International_Liquidity)
// gen controls = missing_count == 0

* No Control No Fixed Effects
regress GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec1

* With Control No Fixed Effects
regress GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, robust
est store spec2

* No Control Yes Fixed Effects
encode Country, gen(country_id)
xtset country_id Year
xtreg GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, fe cluster(country_id)
est store spec3

* Yes Control Yes Fixed Effects
xtreg GDP_Per_Capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, fe cluster(country_id)
est store spec4
		
esttab spec1 spec2 spec3 spec4 ///
		using gdp_capita_table.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels ///
// 		indicate("Controls: Population, CAXGS, Budget_Balance, Current Account, Debt Service, Exchange Rate, Foreign Debt, Inflation, international Liquidity")
		
//
// With Log of GDP
//
generate log_gdp_capita = ln(GDP_Per_Capita)

* No Control No Fixed Effects
regress log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec5

* Yes Control No Fixed Effects
regress log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, robust
est store spec6

* No Control Yes Fixed Effects
xtreg log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, fe cluster(country_id)
est store spec7

* Yes Control Yes Fixed Effects
xtreg log_gdp_capita Government_Stability Socioeconomic_Conditions Investment_Profile ///
		Internal_Conflict External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality Population CAXGS Budget_Balanace CACC DebtServ ///
		Exchange_Rate Foreign_Debt Inflation International_Liquidity, fe cluster(country_id)
est store spec8

esttab spec5 spec6 spec7 spec8 ///
		using log_gdp_capita_table.html, replace ///
		wrap se r2 scalar(rss) obslast nobaselevels