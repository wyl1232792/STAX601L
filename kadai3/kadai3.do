gen r_mtd1 = scd_mtd1 / pop * 100000
gen r_mtd2 = scd_mtd2 / pop * 100000
gen r_mtd3 = scd_mtd3 / pop * 100000
gen r_mtd4 = scd_mtd4 / pop * 100000
gen r_mtd5 = scd_mtd5 / pop * 100000
gen r_mtd6 = scd_mtd6 / pop * 100000
gen r_mtd7 = scd_mtd7 / pop * 100000
gen r_time0002 = scd_time0002 / pop * 100000
gen r_time0204 = scd_time0204 / pop * 100000
gen r_time0406 = scd_time0406 / pop * 100000
gen r_time0608 = scd_time0608 / pop * 100000
gen r_time0810 = scd_time0810 / pop * 100000
gen r_time1012 = scd_time1012 / pop * 100000
gen r_time1214 = scd_time1214 / pop * 100000
gen r_time1416 = scd_time1416 / pop * 100000
gen r_time1618 = scd_time1618 / pop * 100000
gen r_time1820 = scd_time1820 / pop * 100000
gen r_time2022 = scd_time2022 / pop * 100000
gen r_time2224 = scd_time2224 / pop * 100000
gen r_timeukw = scd_timeukw / pop * 100000
gen r_scd = scd / pop * 100000
local vl_r_methods r_mtd1 r_mtd2 r_mtd3 r_mtd4 r_mtd5 r_mtd6 r_mtd7
local vl_r_time r_time0002 r_time0204 r_time0406 r_time0608 r_time0810 r_time1012 r_time1214 r_time1416 r_time1618 r_time1820 r_time2022 r_time2224

tabstat `vl_r_methods', statistics(mean sd p50 p75 p90 p95 p99 max) columns(statistics) format(%9.3f)
tabstat `vl_r_time' r_timeukw, statistics(mean sd p50 p75 p90 p95 p99 max) columns(statistics) format(%9.3f)
hist r_scd if r_scd < 200, bins(30) xtitle("")
graph hbar (mean) `vl_r_methods', stack over(year) legend( label(1 "首吊り") label(2 "服毒") label(3 "練炭等") label(4　"飛降り") label(5 "飛込み") label(6 "その他") label(7 "不詳"))



gen ln_income_pop = log(income_pop)
gen r_pop_in_out = popin / popout
gen r_pop_young = (pop00 + pop10) / pop
gen r_pop_middle = (pop20 + pop30 + pop40) / pop
gen r_pop_old = (pop50 + pop60) / pop
gen r_household_pop = household / pop
gen r_time_night = r_time0002 + r_time0204 + r_time0406
gen r_time_morning = r_time0608 + r_time0810 + r_time1012
gen r_time_afternoon = r_time1214 + r_time1416 + r_time1618
gen r_time_evening = r_time1820 + r_time2022 + r_time2224

xtset city_code year

local factor_vars seirei_ku devmar ln_income_pop r_household_pop r_keijo r_nuc r_popgrad r_pop_in_out r_pop_middle r_pop_old r_pop_young r_work_in r_work_out
** remove work_at
** mtd1 ~ 7
poisson r_mtd1 r_scd `factor_vars'
poisson r_mtd2 r_scd `factor_vars'
poisson r_mtd3 r_scd `factor_vars'
poisson r_mtd4 r_scd `factor_vars'
poisson r_mtd5 r_scd `factor_vars'
poisson r_mtd6 r_scd `factor_vars'

reg r_mtd1 r_scd `factor_vars'
reg r_mtd2 r_scd `factor_vars'
reg r_mtd3 r_scd `factor_vars'
reg r_mtd4 r_scd `factor_vars'
reg r_mtd5 r_scd `factor_vars'
reg r_mtd6 r_scd `factor_vars'

xtreg r_mtd1 r_scd `factor_vars', re
estimates store remtd1
xttest0
xtreg r_mtd2 r_scd `factor_vars', re
estimates store remtd2
xttest0
xtreg r_mtd3 r_scd `factor_vars', re
estimates store remtd3
xttest0
xtreg r_mtd4 r_scd `factor_vars', re
estimates store remtd4
xttest0
xtreg r_mtd5 r_scd `factor_vars', re
estimates store remtd5
xttest0
xtreg r_mtd6 r_scd `factor_vars', re
estimates store remtd6
xttest0

xtreg r_mtd1 r_scd `factor_vars', fe
estimates store femtd1
xtreg r_mtd2 r_scd `factor_vars', fe
estimates store femtd2
xtreg r_mtd3 r_scd `factor_vars', fe
estimates store femtd3
xtreg r_mtd4 r_scd `factor_vars', fe
estimates store femtd4
xtreg r_mtd5 r_scd `factor_vars', fe
estimates store femtd5
xtreg r_mtd6 r_scd `factor_vars', fe
estimates store femtd6


** r_time night, morning, afternoon, evening
poisson r_time_night r_scd `factor_vars'
poisson r_time_morning r_scd `factor_vars'
poisson r_time_afternoon r_scd `factor_vars'
poisson r_time_evening r_scd `factor_vars'
reg r_time_night r_scd `factor_vars'
reg r_time_morning r_scd `factor_vars'
reg r_time_afternoon r_scd `factor_vars'
reg r_time_evening r_scd `factor_vars'
xtreg r_time_night r_scd `factor_vars', re
estimates store renight
xtreg r_time_morning r_scd `factor_vars', re
estimates store remorning
xtreg r_time_afternoon r_scd `factor_vars', re
estimates store reafternoon
xtreg r_time_evening r_scd `factor_vars', re
estimates store reeveing
xtreg r_time_night r_scd `factor_vars', fe
estimates store fenight
xtreg r_time_morning r_scd `factor_vars', fe
estimates store femorning
xtreg r_time_afternoon r_scd `factor_vars', fe
estimates store feafternoon
xtreg r_time_evening r_scd `factor_vars', fe
estimates store feevening

hausman femtd1 remtd1

reghdfe r_mtd1 r_scd `factor_vars' i.treatment_earthquake##i., absorb(city_code year) fe vce(cluster city_code)

gen treatment_earthquake = cond(d_geedeath + d_geeflood + d_geezenkai > 0, 1, 0)


