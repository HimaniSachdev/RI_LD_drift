set output  "ratioMeff_vs_Nm_rho1by10.tex"
set terminal epslatex color dl 3.0 blacktext 12 'ptm,b' standalone
set border linewidth 2
set style line 1 lt 3 lc rgb "black"  pt 3 lw 5
set style line 2 lt 3 lc rgb "black"  pt 3  lw 5
set style line 3 lt 3 lc rgb "black"  pt 3  lw 5
set style line 4 lt 3 lc rgb "red"  pt 3 ps 0.8 lw 3
set style line 5 lt 3 lc rgb "blue"  pt 5 ps 0.8 lw 3
set style line 6 lt 3 lc rgb "green"  pt 1 ps 0.8 lw 3
set style line 7 lt 3 lc rgb "red"  pt 3 lw 4
set style line 8 lt 3 lc rgb "blue"  pt 5  lw 4
set style line 9 lt 3 lc rgb "black"  pt 1  lw 4
set style line 10 lt 3 lc rgb "red"  pt 3 lw 4
set style line 11 lt 3 lc rgb "blue"  pt 5  lw 4
set style line 12 lt 3 lc rgb "black"  pt 1  lw 4

#set format y '\large %g'  
#set format x '\large %g'  

#se size  ratio 0.8

se yrange [0.0:1.02]
se xrange [0.0:5.0]
se xtics (0,1,2,3,4,5)
#se yrange [0.0:1.0]
#se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
#se logsc y
#se logsc x
se key at 5,0.39

se xlabel "average number of migrants $N m$"
se ylabel "ratio of effective immigration rates $\\beta$" offset 0,-1
se label "$s=0.02 \\quad  \\rho=0.1$"  at 1.5,1.04
set style function lines
se arrow from -0.15,0.766511 to 0.15,0.766511 nohead lc rgb "red" lw 3 
se arrow from -0.15,0.727966 to 0.15,0.727966 nohead lc rgb "blue" lw 3 
se arrow from -0.15,0.363886 to 0.15,0.363886 nohead lc rgb "orange" lw 3 
se arrow from -0.15,0.307075 to 0.15,0.307075 nohead lc rgb "black" lw 3 


pl "L10_KS2_rho0.1_sims.txt"  u 1:(((1/$6)-1)/((1/$4)-1)):((((1/$6)-1)/((1/$4)-1))*(((($5/2250)/($4*(1-$4)))**2+(($7/250)/($6*(1-$6)))**2)**0.5)) w yerrorbars ps 1.5 pt 4 lw 3 lc rgb "red" ti "$L=10 \\quad Ns=2$",\
"L40_KS2_rho0.1_sims.txt"  u 1:(((1/$6)-1)/((1/$4)-1)):((((1/$6)-1)/((1/$4)-1))*(((($5/2250)/($4*(1-$4)))**2+(($7/250)/($6*(1-$6)))**2)**0.5)) w yerrorbars ps 1.5 pt 6 lw 3 lc rgb "orange" ti "$L=40 \\quad Ns=2$",\
"L10_KS4_rho0.1_sims.txt"  u 1:(((1/$6)-1)/((1/$4)-1)):((((1/$6)-1)/((1/$4)-1))*(((($5/2250)/($4*(1-$4)))**2+(($7/250)/($6*(1-$6)))**2)**0.5)) w yerrorbars ps 1.5 pt 8 lw 3 lc rgb "blue" ti "$L=10 \\quad Ns=4$",\
"L40_KS4_rho0.1_sims.txt"  u 1:(((1/$6)-1)/((1/$4)-1)):((((1/$6)-1)/((1/$4)-1))*(((($5/2250)/($4*(1-$4)))**2+(($7/250)/($6*(1-$6)))**2)**0.5)) w yerrorbars ps 1.5 pt 10 lw 3 lc rgb "black" ti "$L=40 \\quad Ns=4$",\
"Ks2_L10_Ls0.2_rho0.1.txt" u 1:(((1/$5)-1)/((1/$4)-1)) w lines lw 3 lc rgb "red" noti,\
"Ks2_L40_Ls0.8_rho0.1.txt" u 1:(((1/$5)-1)/((1/$4)-1)) w lines lw 3 lc rgb "orange" noti,\
"Ks4_L10_Ls0.2_rho0.1.txt" u 1:(((1/$5)-1)/((1/$4)-1)) w lines lw 3 lc rgb "blue" noti,\
"Ks4_L40_Ls0.8_rho0.1.txt" u 1:(((1/$5)-1)/((1/$4)-1)) w lines lw 3 lc rgb "black" noti,\
(1.0/9.0) w lines lw 3 lt 3 dt (1,1) lc rgb "black" noti

#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
