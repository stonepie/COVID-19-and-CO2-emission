*title: Covid-9 outbreak and carbon emission: Evidence from China
*author: pansitong
*version: stata 16.0
*----------------------------------------------------------
cd "C:\Users\17628\Desktop\Carbon修改"
use carbon22, clear
rename date_code code

*generate date distance
egen proid = group(state)
g x = code
replace x = code -380 if proid ==1
replace x = code -378 if proid ==2
replace x = code -379 if proid ==3
replace x = code -380 if proid ==4
replace x = code -381 if proid ==5
replace x = code -377 if proid ==6
replace x = code -380 if proid ==7
replace x = code -380 if proid ==8
replace x = code -380 if proid ==9
replace x = code -381 if proid ==10
replace x = code -379 if proid ==11
replace x = code -389 if proid ==12
replace x = code -379 if proid ==13
replace x = code -381 if proid ==14
replace x = code -380 if proid ==15
replace x = code -379 if proid ==16
replace x = code -380 if proid ==17
replace x = code -380 if proid ==18
replace x = code -380 if proid ==19
replace x = code -380 if proid ==20
replace x = code -383 if proid ==21
replace x = code -380 if proid ==22
replace x = code -379 if proid ==23
replace x = code -378 if proid ==24
replace x = code -380 if proid ==25
replace x = code -379 if proid ==26
replace x = code -379 if proid ==27
replace x = code -387 if proid ==28
replace x = code -381 if proid ==29
replace x = code -379 if proid ==30
replace x = code -379 if proid ==31

g T =(x>=0)
g y = total
g y1 = power
g y2 = domestic_aviation
g y3 = ground_transport
g y4 = industry
g y5 = residential

bysort x: egen my = mean(y)
bysort x: egen my1 = mean(y1)
bysort x: egen my2 = mean(y2)
bysort x: egen my3 = mean(y3)
bysort x: egen my4 = mean(y4)
bysort x: egen my5 = mean(y5)


*description of distribution
hist my, bin(100) frequency  normal color("238  118  102%30") ///
	      legend(off)       ///
	      ytitle("Counts")    ///
		  xtitle("CO2 Emission  (Total)")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save my.gph, replace

hist my1, bin(100) frequency  normal color("41  100 106%30") ///
	      legend(off)       ///
	      ytitle("Counts")    ///
		  xtitle("CO2 Emission  (Power)")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))		  
graph save my1.gph, replace	

hist my2, bin(100) frequency  normal color("41  100 106%30") ///
	      legend(off)       ///
	      ytitle("Counts")    ///
		  xtitle("CO2 Emission  (Domestic Aviation)")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))		  
graph save my2.gph, replace	  

hist my3, bin(100) frequency  normal color("41  100 106%30") ///
	      legend(off)       ///
	      ytitle("Counts")    ///
		  xtitle("CO2 Emission  (Ground Transport)")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))		  
graph save my3.gph, replace	

hist my4, bin(100) frequency  normal color("41  100 106%30") ///
	      legend(off)       ///
	      ytitle("Counts")    ///
		  xtitle("CO2 Emission  (Industry)")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))		  
graph save my4.gph, replace	

hist my5, bin(100) frequency  normal color("41  100 106%30") ///
	      legend(off)       ///
	      ytitle("Counts")    ///
		  xtitle("CO2 Emission  (Residential)")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))		  
graph save my5.gph, replace	

graph combine my.gph my1.gph my2.gph my3.gph my4.gph my5.gph, col(3)  xsize(10) ysize(5) scheme(s1color)
graph save des.gph, replace


*mean-y
twoway (scatter my x if x<=0 & x>= -365, msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter my x if x>=0 & x<= 365, msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit my x if x<=0 & x>= -365, lcolor("41  100 106") msize(*0.5))  ///
	      (qfit my x if x>=0 & x<= 365, lcolor("238  118  102") msize(*0.5)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-365 0 365)       ///
	      ytitle("CO2 Emission  (Total)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save ty1.gph, replace

*rdrobust-p1-epanechnikov
rdrobust y x, p(1) kernel(epanechnikov) bwselect(mserd)
est sto e1y
local bw = round(e(h_l),0.001)
outreg2 using e1.doc,replace bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y1 x, p(1) kernel(epanechnikov) bwselect(mserd) 
est sto e1y1
local bw = round(e(h_l),0.001)
outreg2 using e1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y2 x, p(1) kernel(epanechnikov) bwselect(mserd) 
est sto e1y2
local bw = round(e(h_l),0.001)
outreg2 using e1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y3 x, p(1) kernel(epanechnikov) bwselect(mserd)
est sto e1y3
local bw = round(e(h_l),0.001)
outreg2 using e1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' ) 
rdrobust y4 x, p(1) kernel(epanechnikov) bwselect(mserd) 
est sto e1y4
local bw = round(e(h_l),0.001)
outreg2 using e1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y5 x, p(1) kernel(epanechnikov) bwselect(mserd)
est sto e1y5
local bw = round(e(h_l),0.001)
outreg2 using e1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )

*rdrobust-p1-triangular
rdrobust y x, p(1) kernel(triangular) bwselect(mserd)
est sto t1y
local bw = round(e(h_l),0.001)
outreg2 using t1.doc,replace bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y1 x, p(1) kernel(triangular) bwselect(mserd) 
est sto t1y1
local bw = round(e(h_l),0.001)
outreg2 using t1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y2 x, p(1) kernel(triangular) bwselect(mserd) 
est sto t1y2
local bw = round(e(h_l),0.001)
outreg2 using t1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y3 x, p(1) kernel(triangular) bwselect(mserd)
est sto t1y3
local bw = round(e(h_l),0.001)
outreg2 using t1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' ) 
rdrobust y4 x, p(1) kernel(triangular) bwselect(mserd) 
est sto t1y4
local bw = round(e(h_l),0.001)
outreg2 using t1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y5 x, p(1) kernel(triangular) bwselect(mserd)
est sto t1y5
local bw = round(e(h_l),0.001)
outreg2 using t1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )

*rdrobust-p1-uniform
rdrobust y x, p(1) kernel(uniform) bwselect(mserd) 
est sto u1y
local bw = round(e(h_l),0.001)
outreg2 using u1.doc,replace bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y1 x, p(1) kernel(uniform) bwselect(mserd)
est sto u1y1
local bw = round(e(h_l),0.001)
outreg2 using u1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y2 x, p(1) kernel(uniform) bwselect(mserd)
est sto u1y2
local bw = round(e(h_l),0.001)
outreg2 using u1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y3 x, p(1) kernel(uniform) bwselect(mserd)
est sto u1y3 
local bw = round(e(h_l),0.001)
outreg2 using u1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y4 x, p(1) kernel(uniform) bwselect(mserd) 
est sto u1y4
local bw = round(e(h_l),0.001)
outreg2 using u1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y5 x, p(1) kernel(uniform) bwselect(mserd)
est sto u1y5
local bw = round(e(h_l),0.001)
outreg2 using u1.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )

*rdrobust-p2-epanechnikov
rdrobust y x, p(2) kernel(epanechnikov) bwselect(mserd)
est sto e2y
local bw = round(e(h_l),0.001)
outreg2 using e2.doc,replace bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y1 x, p(2) kernel(epanechnikov) bwselect(mserd) 
est sto e2y1
local bw = round(e(h_l),0.001)
outreg2 using e2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y2 x, p(2) kernel(epanechnikov) bwselect(mserd) 
est sto e2y2
local bw = round(e(h_l),0.001)
outreg2 using e2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y3 x, p(2) kernel(epanechnikov) bwselect(mserd)
est sto e2y3
local bw = round(e(h_l),0.001)
outreg2 using e2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' ) 
rdrobust y4 x, p(2) kernel(epanechnikov) bwselect(mserd) 
est sto e2y4
local bw = round(e(h_l),0.001)
outreg2 using e2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y5 x, p(2) kernel(epanechnikov) bwselect(mserd)
est sto e2y5
local bw = round(e(h_l),0.001)
outreg2 using e2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
	 
*rdrobust-p2-triangular
rdrobust y x, p(2) kernel(triangular) bwselect(mserd)
est sto t2y
local bw = round(e(h_l),0.001)
outreg2 using t2.doc,replace bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y1 x, p(2) kernel(triangular) bwselect(mserd) 
est sto t2y1
local bw = round(e(h_l),0.001)
outreg2 using t2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y2 x, p(2) kernel(triangular) bwselect(mserd) 
est sto t2y2
local bw = round(e(h_l),0.001)
outreg2 using t2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y3 x, p(2) kernel(triangular) bwselect(mserd)
est sto t2y3
local bw = round(e(h_l),0.001)
outreg2 using t2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' ) 
rdrobust y4 x, p(2) kernel(triangular) bwselect(mserd) 
est sto t2y4
local bw = round(e(h_l),0.001)
outreg2 using t2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y5 x, p(2) kernel(triangular) bwselect(mserd)
est sto t2y5
local bw = round(e(h_l),0.001)
outreg2 using t2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )

	 
*rdrobust-p2-uniform
rdrobust y x, p(2) kernel(uniform) bwselect(mserd) 
est sto u2y
local bw = round(e(h_l),0.001)
outreg2 using u2.doc,replace bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y1 x, p(2) kernel(uniform) bwselect(mserd)
est sto u2y1
local bw = round(e(h_l),0.001)
outreg2 using u2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y2 x, p(2) kernel(uniform) bwselect(mserd)
est sto u2y2
local bw = round(e(h_l),0.001)
outreg2 using u2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y3 x, p(2) kernel(uniform) bwselect(mserd)
est sto u2y3 
local bw = round(e(h_l),0.001)
outreg2 using u2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y4 x, p(2) kernel(uniform) bwselect(mserd) 
est sto u2y4
local bw = round(e(h_l),0.001)
outreg2 using u2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )
rdrobust y5 x, p(2) kernel(uniform) bwselect(mserd)
est sto u2y5
local bw = round(e(h_l),0.001)
outreg2 using u2.doc,append bdec(3) tdec(2) addtext(bandwith,`bw' )

*mean-y within bw p1
twoway (scatter my x if x<=0 & x>= -76, msymbol( circle ) msize(*0.13) mcolor("41  100 106%50")) ///
       (scatter my x if x>=0 & x<= 76, msymbol( circle ) msize(*0.13) mcolor("238  118  102%50")) ///    
          (lfit my x if x<=0 & x>= -76, lcolor("41  100 106") msize(*0.1))  ///
	      (lfit my x if x>=0 & x<= 76, lcolor("238  118  102") msize(*0.1)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-76 0 76)       ///
	      ytitle("CO2 Emission  (Total)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save u1y.gph, replace

*mean-y1 within bw p1
twoway (scatter my1 x if x<=0 & x>= -52, msymbol( circle ) msize(*0.13) mcolor("41  100 106%50")) ///
       (scatter my1 x if x>=0 & x<= 52, msymbol( circle ) msize(*0.13) mcolor("238  118  102%50")) ///    
          (lfit my1 x if x<=0 & x>= -52, lcolor("41  100 106") msize(*0.1))  ///
	      (lfit my1 x if x>=0 & x<= 52, lcolor("238  118  102") msize(*0.1)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-52 0 52)       ///
	      ytitle("CO2 Emission  (Power)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save u1y1.gph, replace


*mean-y3 within bw p1 
twoway (scatter my3 x if x<=0 & x>= -88, msymbol( circle ) msize(*0.13) mcolor("41  100 106%50")) ///
       (scatter my3 x if x>=0 & x<= 88, msymbol( circle ) msize(*0.13) mcolor("238  118  102%50")) ///    
          (lfit my3 x if x<=0 & x>= -88, lcolor("41  100 106") msize(*0.1))  ///
	      (lfit my3 x if x>=0 & x<= 88, lcolor("238  118  102") msize(*0.1)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-88 0 88)       ///
	      ytitle("CO2 Emission  (Ground Transport)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save u1y3.gph, replace


*mean-y within bw p2
twoway (scatter my x if x<=0 & x>= -80, msymbol( circle ) msize(*0.13) mcolor("41  100 106%50")) ///
       (scatter my x if x>=0 & x<= 80, msymbol( circle ) msize(*0.13) mcolor("238  118  102%50")) ///    
          (qfit my x if x<=0 & x>= -80, lcolor("41  100 106") msize(*0.1))  ///
	      (qfit my x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.1)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("CO2 Emission  (Total)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save u2y.gph, replace

*mean-y1 within bw p2
twoway (scatter my1 x if x<=0 & x>= -101, msymbol( circle ) msize(*0.13) mcolor("41  100 106%50")) ///
       (scatter my1 x if x>=0 & x<= 101, msymbol( circle ) msize(*0.13) mcolor("238  118  102%50")) ///    
          (qfit my1 x if x<=0 & x>= -101, lcolor("41  100 106") msize(*0.1))  ///
	      (qfit my1 x if x>=0 & x<= 101, lcolor("238  118  102") msize(*0.1)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-101 0 101)       ///
	      ytitle("CO2 Emission  (Power)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save u2y1.gph, replace


*mean-y3 within bw p2 
twoway (scatter my3 x if x<=0 & x>= -127, msymbol( circle ) msize(*0.13) mcolor("41  100 106%50")) ///
       (scatter my3 x if x>=0 & x<= 127, msymbol( circle ) msize(*0.13) mcolor("238  118  102%50")) ///    
          (qfit my3 x if x<=0 & x>= -127, lcolor("41  100 106") msize(*0.1))  ///
	      (qfit my3 x if x>=0 & x<= 127, lcolor("238  118  102") msize(*0.1)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-127 0 127)       ///
	      ytitle("CO2 Emission  (Ground Transport)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save u2y3.gph, replace

graph combine u1y.gph u1y1.gph u1y3.gph u2y.gph u2y1.gph u2y3.gph, col(3) xsize(10) ysize(6) scheme(s1color)
graph save rd.gph, replace


*Heterogeneity
*Anhui
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==1, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Anhui)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy1.gph, replace

*Beijing
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==2, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Beijing)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy2.gph, replace

*Chongqing
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==3, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Chongqing)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy3.gph, replace

*Fujian
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==4, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Fujian)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy4.gph, replace

*Gansu
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==5, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Gansu)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy5.gph, replace

*Guangdong
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==6, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Guangdong)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy6.gph, replace

*Guangxi
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==7, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Guangxi)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy7.gph, replace

*Guizhou
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==8, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Guizhou)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy8.gph, replace

*Hainan
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==9, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Hainan)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy9.gph, replace

*Hebei
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==10, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Hebei)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy10.gph, replace

*Heilongjiang
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==11, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Heilongjiang)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy11.gph, replace

*Henan
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==12, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Henan)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy12.gph, replace

*Hubei
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==13, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Hubei)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy13.gph, replace

*Hunan
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==14, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Hunan)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy14.gph, replace

*Inner Mongolia
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==16, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Inner Mongolia)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy15.gph, replace

*Jiangsu
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==16, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Jiangsu)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy16.gph, replace

*Jiangxi
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==17, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Jiangxi)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy17.gph, replace

*Jilin
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==18, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Beijing)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy18.gph, replace

*Liaoning
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==19, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Liaoning)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy19.gph, replace

*Ningxia
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==20, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Ningxia)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy20.gph, replace

*Qinghai
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==21, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Qinghai)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy21.gph, replace

*Shaanxi
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==22, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Shaanxi)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy22.gph, replace

*Shandong
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==23, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Shandong)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy23.gph, replace

*Shanghai
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==24, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Shanghai)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy24.gph, replace

*Shanxi
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==25, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Shanxi)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy25.gph, replace

*Sichuan
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==26, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Sichuan)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy26.gph, replace

*Tianjin
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==27, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Tianjin)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy27.gph, replace

*Tibet
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==28, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Tibet)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy28.gph, replace

*Xinjiang
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==29, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Xinjiang)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy29.gph, replace

*Yunnan
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==30, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Yunnan)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy30.gph, replace

*Zhejiang
twoway (scatter y x if x<=0 & x>= -80 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 80 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -80,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 80, lcolor("238  118  102") msize(*0.5)) if proid ==31, ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-80 0 80)       ///
	      ytitle("Total CE (Zhejiang)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy31.gph, replace

graph combine hy1.gph hy2.gph hy3.gph hy4.gph hy5.gph hy6.gph hy7.gph hy8.gph hy9.gph hy10.gph hy11.gph hy12.gph hy13.gph hy14.gph hy15.gph hy16.gph  hy17.gph hy18.gph hy19.gph hy20.gph hy21.gph hy22.gph hy23.gph hy24.gph hy25.gph hy26.gph hy27.gph hy28.gph hy29.gph hy30.gph hy31.gph, col(7) xsize(10) ysize(8) scheme(s1color)

*MC test
DCdensity x if x >= -365 & x <=365, breakpoint(0) generate(Xj Yj r0 fhat se_fhat) b(1) h(12)  
graph save dcdensity.gph , replace 
 



		  


		  
		  
