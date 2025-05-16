```
. use "Kadai2.dta"

. 
. *** 1
. sum income_pop if D2013==0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
  income_pop |      1,734    276.3246    47.37195   192.5609   943.5259

. sum income_pop if D2013==1

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
  income_pop |      1,740    274.6232    47.58372   191.4445   901.7473

. 
. sum income_pop if r_komei <= r_jimin

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
  income_pop |      3,401    275.7485    47.65707   191.4445   943.5259

. sum income_pop if r_komei > r_jimin

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
  income_pop |         73    262.6132    36.24847   192.5609    383.252

. scatter r_jimin income_pop || scatter r_komei income_pop || lfit r_jimin income_pop || lfit r_komei income_pop

. graph export scatter_all.jpg
file /Users/wuyanlei/workspace/STAX601L/scatter_all.jpg saved as JPG format

. scatter r_jimin income_pop if r_komei <= r_jimin || scatter r_komei income_pop if r_komei > r_jimin

. graph export scatter_partial.jpg
file /Users/wuyanlei/workspace/STAX601L/scatter_partial.jpg saved as JPG format

. 
. *** 2
. reg r_jimin income_pop r_pop20bellow r_pop65above r_unemployment D2013

      Source |       SS           df       MS      Number of obs   =     3,426
-------------+----------------------------------   F(5, 3420)      =    653.97
       Model |  137106.715         5   27421.343   Prob > F        =    0.0000
    Residual |  143402.048     3,420  41.9304235   R-squared       =    0.4888
-------------+----------------------------------   Adj R-squared   =    0.4880
       Total |  280508.763     3,425  81.9003688   Root MSE        =    6.4754

--------------------------------------------------------------------------------
       r_jimin | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
---------------+----------------------------------------------------------------
    income_pop |  -.0290145   .0031787    -9.13   0.000    -.0352468   -.0227822
 r_pop20bellow |   .0705018   .0834375     0.84   0.398    -.0930906    .2340943
  r_pop65above |   .3294345   .0405647     8.12   0.000     .2499011     .408968
r_unemployment |  -.7762832   .0636865   -12.19   0.000    -.9011506   -.6514158
         D2013 |   8.261456   .2629067    31.42   0.000     7.745986    8.776926
         _cons |   29.63644   3.175195     9.33   0.000     23.41097    35.86191
--------------------------------------------------------------------------------

. reg r_komei income_pop r_pop20bellow r_pop65above r_unemployment D2013

      Source |       SS           df       MS      Number of obs   =     3,426
-------------+----------------------------------   F(5, 3420)      =    112.10
       Model |  8656.26947         5  1731.25389   Prob > F        =    0.0000
    Residual |  52820.1176     3,420  15.4444788   R-squared       =    0.1408
-------------+----------------------------------   Adj R-squared   =    0.1396
       Total |   61476.387     3,425  17.9493101   Root MSE        =    3.9299

--------------------------------------------------------------------------------
       r_komei | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
---------------+----------------------------------------------------------------
    income_pop |  -.0033738   .0019292    -1.75   0.080    -.0071563    .0004086
 r_pop20bellow |   .2056126   .0506388     4.06   0.000     .1063272    .3048979
  r_pop65above |   .0836155    .024619     3.40   0.001     .0353461    .1318849
r_unemployment |    .748439   .0386518    19.36   0.000     .6726561    .8242218
         D2013 |   3.124467   .1595598    19.58   0.000     2.811625    3.437309
         _cons |    2.80119   1.927047     1.45   0.146    -.9770902     6.57947
--------------------------------------------------------------------------------

. 
. *** 3
. // variable adjustments
. gen pop_household = pop / household

. gen marriage_pop = marriage / pop
(39 missing values generated)

. gen r_popin = popin / pop

. gen r_popout = popout / pop

. count if D2013==0
  1,901

. scalar N_before=r(N)

. count if D2013==1
  1,915

. scalar N_after=r(N)

. 
. // simple insight
. reg r_tohyo devmar marriage_pop pop_household pop r_popin r_popout r_jimin r_keijo r_komei r_minshu r_nihonk r_shamin r_nuc r_own r_pop20bellow r_pop65a
> bove r_popdaynight r_unemployment r_work_at r_work_in r_work_out seirei_ku

      Source |       SS           df       MS      Number of obs   =     2,163
-------------+----------------------------------   F(22, 2140)     =    102.70
       Model |   41537.131        22  1888.05141   Prob > F        =    0.0000
    Residual |  39342.1624     2,140   18.384188   R-squared       =    0.5136
-------------+----------------------------------   Adj R-squared   =    0.5086
       Total |  80879.2934     2,162  37.4094789   Root MSE        =    4.2877

--------------------------------------------------------------------------------
       r_tohyo | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
---------------+----------------------------------------------------------------
        devmar |    -.07449   .0138234    -5.39   0.000    -.1015987   -.0473814
  marriage_pop |  -299.9763   191.8424    -1.56   0.118    -676.1933    76.24075
 pop_household |   3.682046   .7573608     4.86   0.000     2.196806    5.167286
           pop |  -1.43e-06   1.28e-06    -1.12   0.263    -3.94e-06    1.08e-06
       r_popin |   22.39878   22.71914     0.99   0.324    -22.15513    66.95268
      r_popout |   113.3304   24.53841     4.62   0.000     65.20876     161.452
       r_jimin |  -.1642201    .021128    -7.77   0.000    -.2056536   -.1227867
       r_keijo |  -.0350522   .0198155    -1.77   0.077    -.0739117    .0038074
       r_komei |  -.3974497   .0337837   -11.76   0.000     -.463702   -.3311973
      r_minshu |   .2396496   .0200651    11.94   0.000     .2003004    .2789988
      r_nihonk |  -.2093738   .0455727    -4.59   0.000    -.2987452   -.1200024
      r_shamin |  -.1255742   .0389136    -3.23   0.001    -.2018866   -.0492618
         r_nuc |   .0820744   .0290304     2.83   0.005     .0251436    .1390052
         r_own |   .0096238   .0166858     0.58   0.564    -.0230983    .0423459
 r_pop20bellow |   .7997472   .0991112     8.07   0.000     .6053829    .9941115
  r_pop65above |   .9776049   .0586671    16.66   0.000     .8625544    1.092655
 r_popdaynight |  -.0134238   .0100916    -1.33   0.184    -.0332141    .0063665
r_unemployment |  -.0072244   .0770935    -0.09   0.925    -.1584104    .1439616
     r_work_at |  -.2344827   .0611283    -3.84   0.000    -.3543598   -.1146056
     r_work_in |    .003519   .0024392     1.44   0.149    -.0012645    .0083025
    r_work_out |  -.2553675   .0628463    -4.06   0.000    -.3786137   -.1321214
     seirei_ku |  -3.030455   .7039508    -4.30   0.000    -4.410953   -1.649956
         _cons |   37.24795   7.187056     5.18   0.000     23.15361    51.34229
--------------------------------------------------------------------------------

. estat hettest

Breusch–Pagan/Cook–Weisberg test for heteroskedasticity 
Assumption: Normal error terms
Variable: Fitted values of r_tohyo

H0: Constant variance

    chi2(1) =  38.28
Prob > chi2 = 0.0000

. vif

    Variable |       VIF       1/VIF  
-------------+----------------------
   r_work_at |    170.64    0.005860
  r_work_out |    161.70    0.006184
   r_work_in |     33.29    0.030040
r_popdayni~t |     29.49    0.033910
     r_popin |     13.14    0.076131
r_pop65above |     11.21    0.089173
    r_popout |      9.85    0.101475
pop_househ~d |      6.44    0.155303
r_pop20bel~w |      6.14    0.162874
marriage_pop |      6.04    0.165669
       r_own |      4.35    0.229734
    r_minshu |      4.17    0.239595
     r_jimin |      3.71    0.269478
       r_nuc |      3.64    0.274438
r_unemploy~t |      2.52    0.397388
         pop |      2.19    0.457211
    r_nihonk |      2.19    0.457437
     r_komei |      1.92    0.519489
      devmar |      1.89    0.529754
    r_shamin |      1.71    0.584658
     r_keijo |      1.27    0.790334
   seirei_ku |      1.06    0.944945
-------------+----------------------
    Mean VIF |     21.75

. // some variables for similarity:
. // (r_work_at r_work_in r_work_out)
. // (r_popdaynight r_pop20bellow r_pop65above)
. // found p<0.05: devmar pop_household r_popout r_jimin r_komei r_minshu r_nihonk r_shamin r_nuc r_pop20below r_pop65above r_work_at r_work_out seirei_ku
. 
. // chow test
. local Xs devmar pop_household r_popout r_jimin r_komei r_minshu r_nihonk r_shamin r_nuc r_pop20bellow r_pop65above r_work_at r_work_out seirei_ku

. scalar k=14

. 
. qui reg r_tohyo `Xs'

. scalar rss_pooled = e(rss)

. qui reg r_tohyo `Xs' if D2013==0

. scalar rss_b2013 = e(rss)

. qui reg r_tohyo `Xs' if D2013==1

. scalar rss_a2013 = e(rss)

. 
. scalar F = (rss_pooled - (rss_b2013 + rss_a2013)) / k / ((rss_b2013 + rss_a2013) / (N_before + N_after - 2 * k))

. display "F = " F ", p-value = " Ftail(k, N_before + N_after - 2*k, F)
F = 15.635775, p-value = 1.121e-37

. 
. *** 4
. *** DIDの例
. 
end of do-file

. 

```