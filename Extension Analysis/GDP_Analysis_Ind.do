// 
//PURPOSE OF THIS FILE
// This File is mean to look at the individual components of the polrisk composite
// and find how that relates to GDP and log GDP, see GDP_Analysis_PolComp
// for relation of just PolComp and GDP/LogGDP
//

* Loading Data also encoding for fixed effects later on
use "df_all_features.dta", clear
encode Country, gen(country_id)


//
// WITH JUST GDP
//

* Polrisk Composite and GDP
regress GDP Composite, robust
est store spec1

* External Conflict and GDP
regress GDP Composite External_Conflict, robust
est store spec2

* Corruption and GDP
regress GDP Composite External_Conflict Corruption, robust
est store spec3

* Military in Politics and GDP
regress GDP Composite External_Conflict Corruption Military_Politic, robust
est store spec4

* Religion in Politics and GDP
regress GDP Composite External_Conflict Corruption Military_Politic ///
		Religious_Tension, robust
est store spec5

* Law and Order and GDP
regress GDP Composite External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order, robust
est store spec6

* Ethnic Tensions and GDP
regress GDP Composite External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension, robust
est store spec7

* Democratic Accountability and GDP
regress GDP Composite External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability, ///
		robust
est store spec8


* Bureaucracy Quality and GDP
regress GDP Composite External_Conflict Corruption Military_Politic ///
		Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability ///
		Bureaucracy_Quality, robust
est store spec9

esttab spec1 spec2 spec3 spec4 spec5 spec6 spec7 spec8 spec9 using gdp_table_1.html, ///
		wrap se r2 scalar(rss) obslast nobaselevels