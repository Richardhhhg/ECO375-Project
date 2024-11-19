cd /Users/tankenji/Desktop/ECO375STATA/InternationalCountryRiskGuide
use polriskv4.dta, clear

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


// Components of Political Risk


// A - Government Stability
reg growthavg agovstability bsocioeconconditions cinvestprofile dinternalconf eexternalconf fcorruption gmilitarypol hreltensions ilaworder jethnictensions kdemaccount lbureauqual
// reg growthavg agovstability
// B - Socioeconomic Conditions
reg growthavg bsocioeconconditions agovstability cinvestprofile dinternalconf eexternalconf fcorruption gmilitarypol hreltensions ilaworder jethnictensions kdemaccount lbureauqual

scatter growthavg bsocioeconconditions || lfit growthavg bsocioeconconditions

// reg growthavg bsocioeconconditions // Significant
// C - Investment Profile
reg growthavg cinvestprofile bsocioeconconditions agovstability dinternalconf eexternalconf fcorruption gmilitarypol hreltensions ilaworder jethnictensions kdemaccount lbureauqual
// reg growthavg cinvestprofile
// D - Internal Conflict
reg growthavg dinternalconf cinvestprofile bsocioeconconditions agovstability eexternalconf fcorruption gmilitarypol hreltensions ilaworder jethnictensions kdemaccount lbureauqual
// reg growthavg dinternalconf
// E - External Conflict
reg growthavg eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability fcorruption gmilitarypol hreltensions ilaworder jethnictensions kdemaccount lbureauqual
// reg growthavg eexternalconf
// F - Corruption
reg growthavg fcorruption eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability gmilitarypol hreltensions ilaworder jethnictensions kdemaccount lbureauqual

egen z_growth = std(growthavg)
list growthavg fcorruption if abs(z_growth) > 2
generate byte corrupt_outlier1 = abs(z_growth) > 2

scatter growthavg fcorruption if (corrupt_outlier1 == 0) || lfit growthavg fcorruption if (corrupt_outlier1 == 0)

reg growthavg fcorruption if (corrupt_outlier1 == 0)
// G - Military in Politics
reg growthavg gmilitarypol fcorruption eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability hreltensions ilaworder jethnictensions kdemaccount lbureauqual

scatter growthavg gmilitarypol || lfit growthavg gmilitarypol

// reg growthavg gmilitarypol // Significant
// H - Religion in Politics
reg growthavg hreltensions gmilitarypol fcorruption eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability ilaworder jethnictensions kdemaccount lbureauqual
// reg growthavg hreltensions
// I - Law and Order
reg growthavg ilaworder hreltensions gmilitarypol fcorruption eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability jethnictensions kdemaccount lbureauqual
// reg growthavg ilaworder
// J - Ethnic Tensions
reg growthavg jethnictensions ilaworder hreltensions gmilitarypol fcorruption eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability kdemaccount lbureauqual // Significant

scatter growthavg jethnictensions || lfit growthavg jethnictensions

// reg growthavg jethnictensions // Significant
// K - Democratic Accountability
reg growthavg kdemaccount jethnictensions ilaworder hreltensions gmilitarypol fcorruption eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability lbureauqual
// reg growthavg kdemaccount
// L - Bureaucracy Quality
reg growthavg lbureauqual kdemaccount jethnictensions ilaworder hreltensions gmilitarypol fcorruption eexternalconf dinternalconf cinvestprofile bsocioeconconditions agovstability
// reg growthavg lbureauqual










