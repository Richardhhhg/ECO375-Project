* making correlation matrix
setroot
use "DATA/concatenated/df_all_features.dta", clear
keep Composite Government_Stability Socioeconomic_Conditions Investment_Profile Internal_Conflict External_Conflict Corruption Military_Politic Religious_Tension Law_Order Ethnic_Tension Democratic_Accountability Bureaucracy_Quality GDP_Per_Capita GDP_Growth
// keep list
asdoc cor, replace
