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
local vl_scd_mtd scd_mtd1 scd_mtd2 scd_mtd3 scd_mtd4 scd_mtd5 scd_mtd6 scd_mtd7
local vl_scd_time scd_time0002 scd_time0204 scd_time0406 scd_time0608 scd_time0810 scd_time1012 scd_time1214 scd_time1416 scd_time1618 scd_time1820 scd_time2022 scd_time2224

tabstat `vl_r_methods', statistics(mean sd p50 p75 p90 p95 p99 max) columns(statistics) format(%9.3f)
tabstat `vl_r_time' r_timeukw, statistics(mean sd p50 p75 p90 p95 p99 max) columns(statistics) format(%9.3f)
hist r_scd if r_scd < 200, bins(30) xtitle("")
graph hbar (mean) `vl_r_methods', stack over(year) legend( label(1 "首吊り") label(2 "服毒") label(3 "練炭等") label(4　"飛降り") label(5 "飛込み") label(6 "その他") label(7 "不詳"))
graph pie `vl_scd_mtd', sort descending angle0(0) plabel(1 percent, color(white)) plabel(2 percent, color(white)) plabel(3 percent, color(white)) plabel(4 percent, color(white)) plabel(5 percent, color(white)) plabel(6 percent, color(white))
graph hbar (sum)`vl_scd_time', bargap(10) legend(label(1 "00:00 ~ 02:00") label(2 "02:00 ~ 04:00") label(3 "04:00 ~ 06:00") label(4 "06:00 ~ 08:00") label(5 "08:00 ~ 10:00") label(6 "10:00 ~ 12:00") label(7 "12:00 ~ 14:00") label(8 "14:00 ~ 16:00") label(9 "16:00 ~ 18:00") label(10 "18:00 ~ 20:00") label(11 "20:00 ~ 22:00") label(12 "22:00 ~ 24:00"))