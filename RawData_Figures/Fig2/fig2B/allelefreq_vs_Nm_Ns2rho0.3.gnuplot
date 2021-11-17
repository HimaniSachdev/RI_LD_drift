set output  "allelefreq_vs_Nm_Ns2_rho3by10.tex"
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

#se yrange [0.8:12.8]
se xrange [0.0:4.0]
se xtics (0.0,1.0,2.0,3.0,4.0)
se yrange [0.0:1.0]
se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
#se logsc y
#se logsc x
se key top right

se xlabel "average number of migrants $N m$"
se ylabel "expected allele frequency in rare habitat"
se label "$s=0.02 \\quad \\mathbf{{\\color{red} Ns=2}} \\quad \\mathbf{{\\color{blue} \\rho=0.3}}$"  at 1.0,1.02
set style function lines

pl "L10_KS2_rho0.3_sims.txt"  u 1:2:((($2*(1-$2)-$3)/7500)**0.5) w yerrorbars ps 1.5 pt 4 lw 3 lc rgb "black" ti "$L=10$",\
"L40_KS2_rho0.3_sims.txt"  u 1:2:((($2*(1-$2)-$3)/30000)**0.5) w yerrorbars ps 1.5 pt 7 lw 3 lc rgb "black" ti "$L=40$",\
"Ks2_L10_Ls0.2_rho0.3.txt" u 1:2 w lines lw 3 lc rgb "black" noti,\
"Ks2_L40_Ls0.8_rho0.3.txt" u 1:2 w lines lw 3 lc rgb "black" noti,\
"KS2_LE_rho0.3.txt" u 1:2 w lines lw 3 lt 3 dt (1,1) lc rgb "black" ti "LE"


#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
