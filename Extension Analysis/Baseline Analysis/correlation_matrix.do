setroot
use "DATA/concatenated/df_all_features.dta", clear

gen log_gdp = ln(GDP)
gen log_gdp_capita = ln(GDP_Per_Capita)

estpost correlate Composite Government_Stability Socioeconomic_Conditions Investment_Profile Internal_Conflict External_Conflict Corruption Military_Politic Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability Bureaucracy_Quality GDP GDP_Per_Capita GDP_Growth log_gdp log_gdp_capita, matrix listwise
esttab, unstack not noobs compress ///
// 	html using correlation_matrix.html
