cd /DATA
use polriskv3.dta, clear

//2022 data
// sum PolComp2022, detail
// reg Growth2022 PolComp2022
// scatter Growth2022 PolComp2022 || lfit Growth2022 PolComp2022
//
// reg Growth2022 PolComp2022 if (OECD2022 == 1)
// scatter Growth2022 PolComp2022 if (OECD2022 == 1) || lfit Growth2022 PolComp2022 if (OECD2022 == 1)
//
// reg Growth2022 PolComp2022 if (OECD2022 == 0)
// scatter Growth2022 PolComp2022 if (OECD2022 == 0) || lfit Growth2022 PolComp2022 if (OECD2022 == 0)

//Avg data
sum PolCompAvg, detail
reg GrowthAvg PolCompAvg
scatter GrowthAvg PolCompAvg || lfit GrowthAvg PolCompAvg

reg GrowthAvg PolCompAvg if (OECD2022 == 1)
scatter GrowthAvg PolCompAvg if (OECD2022 == 1), mlabel(Country) || lfit GrowthAvg PolCompAvg if (OECD2022 == 1)

reg GrowthAvg PolCompAvg if (OECD2022 == 0)
scatter GrowthAvg PolCompAvg if (OECD2022 == 0), mlabel(Country) || lfit GrowthAvg PolCompAvg if (OECD2022 == 0)


//Avg data by income

egen z_growth = std(GrowthAvg)
list GrowthAvg PolCompAvg if abs(z_growth) > 3
generate byte outlier = abs(z_growth) > 3
tabulate outlier

reg GrowthAvg PolCompAvg if (outlier == 0)
scatter GrowthAvg PolCompAvg if (outlier == 0) || lfit GrowthAvg PolCompAvg if (outlier == 0)


egen z_growth1 = std(GrowthAvg) if (WorldBankIncomeClassification == "Low-income countries")
list GrowthAvg PolCompAvg if abs(z_growth1) > 3 & WorldBankIncomeClassification == "Low-income countries"
generate byte outlier1 = abs(z_growth1) > 3
tabulate outlier1

reg GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Low-income countries" & outlier1 == 0)
scatter GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Low-income countries" & outlier1 == 0), mlabel(Country) || lfit GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Low-income countries" & outlier1 == 0)

reg GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Low-income countries")
scatter GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Low-income countries"), mlabel(Country) || lfit GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Low-income countries")



reg GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Lower-middle-income countries")
scatter GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Lower-middle-income countries"), mlabel(Country) || lfit GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Lower-middle-income countries")

reg GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Upper-middle-income countries")
scatter GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Upper-middle-income countries"), mlabel(Country) || lfit GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "Upper-middle-income countries")


egen z_growth4 = std(GrowthAvg) if (WorldBankIncomeClassification == "High-income countries")
list GrowthAvg PolCompAvg if abs(z_growth4) > 2 & WorldBankIncomeClassification == "High-income countries"
generate byte outlier4 = abs(z_growth4) > 2
tabulate outlier4

reg GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "High-income countries" & outlier4 == 0)
scatter GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "High-income countries" & outlier4 == 0), mlabel(Country) || lfit GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "High-income countries" & outlier4 == 0)

reg GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "High-income countries")
scatter GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "High-income countries"), mlabel(Country) || lfit GrowthAvg PolCompAvg if (WorldBankIncomeClassification == "High-income countries")

















