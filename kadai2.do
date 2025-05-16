use "*.dta"

*** 1
sum income_pop if D2013==0
sum income_pop if D2013==1

sum income_pop if r_komei <= r_jimin
sum income_pop if r_komei > r_jimin
scatter r_jimin income_pop || scatter r_komei income_pop || lfit r_jimin income_pop || lfit r_komei income_pop
scatter r_jimin income_pop if r_komei <= r_jimin || scatter r_komei income_pop if r_komei > r_jimin

*** 2
reg r_jimin income_pop r_pop20bellow r_pop65above r_unemployment D2013
reg r_komei income_pop r_pop20bellow r_pop65above r_unemployment D2013

*** 3
// variable adjustments
gen pop_household = pop / household
gen marriage_pop = marriage / pop
gen r_popin = popin / pop
gen r_popout = popout / pop
count if D2013==0
scalar N_before=r(N)
count if D2013==1
scalar N_after=r(N)

// simple insight
reg r_tohyo devmar marriage_pop pop_household pop r_popin r_popout r_jimin r_keijo r_komei r_minshu r_nihonk r_shamin r_nuc r_own r_pop20bellow r_pop65above r_popdaynight r_unemployment r_work_at r_work_in r_work_out seirei_ku
estat hettest
vif
// some variables for similarity:
// (r_work_at r_work_in r_work_out)
// (r_popdaynight r_pop20bellow r_pop65above)
// found p<0.05: devmar pop_household r_popout r_jimin r_komei r_minshu r_nihonk r_shamin r_nuc r_pop20below r_pop65above r_work_at r_work_out seirei_ku

// chow test
local Xs devmar pop_household r_popout r_jimin r_komei r_minshu r_nihonk r_shamin r_nuc r_pop20bellow r_pop65above r_work_at r_work_out seirei_ku
scalar k=14

qui reg r_tohyo `Xs'
scalar rss_pooled = e(rss)
qui reg r_tohyo `Xs' if D2013==0
scalar rss_b2013 = e(rss)
qui reg r_tohyo `Xs' if D2013==1
scalar rss_a2013 = e(rss)

scalar F = (rss_pooled - (rss_b2013 + rss_a2013)) / k / ((rss_b2013 + rss_a2013) / (N_before + N_after - 2 * k))
display "F = " F ", p-value = " Ftail(k, N_before + N_after - 2*k, F)

*** 4
*** DIDの例
