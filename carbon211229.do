*title: Covid-9 and carbon emission: Evidence from China
*author: pansitong
*version: stata 16.0
*----------------------------------------------------------
cd "C:\Users\17628\Desktop\Carbon"
use carbon1, clear
rename date_code code


*generate date distance
egen proid = group(state)
g x = code
replace x = code - 403 if proid ==1
replace x = code - 403 if proid ==1
replace x = code -537 if proid ==2
replace x = code -398 if proid ==3
replace x = code -389 if proid ==4
replace x = code -431 if proid ==5
replace x = code -397 if proid ==6
replace x = code -395 if proid ==7
replace x = code -407 if proid ==8
replace x = code -401 if proid ==9
replace x = code -404 if proid ==10
replace x = code -470 if proid ==11
replace x = code -400 if proid ==12
replace x = code -409 if proid ==13
replace x = code -394 if proid ==14
replace x = code -468 if proid ==15
replace x = code -396 if proid ==16
replace x = code -400 if proid ==17
replace x = code -401 if proid ==18
replace x = code -397 if proid ==19
replace x = code -402 if proid ==20
replace x = code -392 if proid ==21
replace x = code -396 if proid ==22
replace x = code -417 if proid ==23
replace x = code -468 if proid ==24
replace x = code -464 if proid ==25
replace x = code -396 if proid ==26
replace x = code -399 if proid ==27
replace x = code -395 if proid ==28
replace x = code -577 if proid ==29
replace x = code -393 if proid ==30
replace x = code -395 if proid ==31

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


*mean-y within bw
twoway (scatter my x if x<=0 & x>= -152, msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter my x if x>=0 & x<= 152, msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit my x if x<=0 & x>= -152, lcolor("41  100 106") msize(*0.5))  ///
	      (qfit my x if x>=0 & x<= 152, lcolor("238  118  102") msize(*0.5)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-152 0 152)       ///
	      ytitle("CO2 Emission  (Total)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save e2y.gph, replace

*mean-y1 within bw
twoway (scatter my1 x if x<=0 & x>= -193, msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter my1 x if x>=0 & x<= 193, msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit my1 x if x<=0 & x>= -193, lcolor("41  100 106") msize(*0.5))  ///
	      (qfit my1 x if x>=0 & x<= 193, lcolor("238  118  102") msize(*0.5)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-193 0 193)       ///
	      ytitle("CO2 Emission  (Power)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save e2y1.gph, replace


*mean-y2 within bw
twoway (scatter my2 x if x<=0 & x>= -145, msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter my2 x if x>=0 & x<= 145, msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit my2 x if x<=0 & x>= -145, lcolor("41  100 106") msize(*0.5))  ///
	      (qfit my2 x if x>=0 & x<= 145, lcolor("238  118  102") msize(*0.5)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-145 0 145)       ///
	      ytitle("CO2 Emission  (Domestic Aviation)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save e2y2.gph, replace


*mean-y3 within bw	  
twoway (scatter my3 x if x<=0 & x>= -118, msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter my3 x if x>=0 & x<= 118, msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit my3 x if x<=0 & x>= -118, lcolor("41  100 106") msize(*0.5))  ///
	      (qfit my3 x if x>=0 & x<= 118, lcolor("238  118  102") msize(*0.5)), ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-118 0 118)       ///
	      ytitle("CO2 Emission  (Ground Transport)")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))
graph save e2y3.gph, replace

graph combine e2y.gph e2y1.gph e2y2.gph e2y3.gph, col(2) xsize(10) ysize(10) scheme(s1color)
graph save rd.gph, replace


*Heterogeneity
forvalues i = 1/31{
twoway (scatter y x if x<=0 & x>= -152 , msymbol( circle ) msize(*0.1) mcolor("41  100 106%50")) ///
       (scatter y x if x>=0 & x<= 152 , msymbol( circle ) msize(*0.1) mcolor("238  118  102%50")) ///    
          (qfit y x if x<=0 & x>= -152,  lcolor("41  100 106") msize(*0.5))  ///
	      (qfit y x if x>=0 & x<= 152, lcolor("238  118  102") msize(*0.5)) if proid ==`i', ///
	      xline(0, lpattern(dash) lcolor(gray))       ///
	      legend(off) xlabel(-152 0 152)       ///
	      ytitle("Total Carbon Emission (`i')")    ///
		  xtitle("Date")   ///
		  ylabel(, nogrid)    ///
		  scheme(s1color)    ///
		  plotregion(lcolor(white) lpattern(blank))   
graph save hy`i'.gph, replace
}

graph combine hy1.gph hy2.gph hy3.gph hy4.gph hy5.gph hy6.gph hy7.gph hy8.gph hy9.gph hy10.gph hy11.gph hy12.gph hy13.gph hy14.gph hy15.gph hy16.gph  hy17.gph hy18.gph hy19.gph hy20.gph hy21.gph hy22.gph hy23.gph hy24.gph hy25.gph hy26.gph hy27.gph hy28.gph hy29.gph hy30.gph hy31.gph, col(6) xsize(9) ysize(10) scheme(s1color)

*MC test
DCdensity x if x >= -365 & x <=365, breakpoint(0) generate(Xj Yj r0 fhat se_fhat) b(1) h(12)  
graph save dcdensity.gph , replace 
 



		  


		  
		  
