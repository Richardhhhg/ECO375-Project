use "df_all_features.dta", clear
estpost summarize
esttab summary_statistics using summary_stats.html, replace