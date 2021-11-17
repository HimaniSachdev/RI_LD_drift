set output  "allelefreq_vs_mbys.tex"
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
se xrange [0.0:1.2]
se xtics (0.0,0.2,0.4,0.6,0.8,1.0,1.2)
se yrange [0.0:1.1]
se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
#se logsc y
#se logsc x
se key at 1.18,1.09

se xlabel "migration rate relative to selection per locus $m/s$"
se ylabel "expected frequency of locally favoured allele"
se label "$s=0.02 \\quad Ls=0.8 \\quad \\mu/s = 0.005$"  at 0.2,1.12
set style function lines

pl "KS1Ku0.005_sims.txt" u 1:(1-$2):((($2*(1-$2)-$3)/4000)**0.5) w yerrorbars ps 1.5 pt 4 lw 3 lc rgb "brown" ti "$Ns=1$",\
"KS2Ku0.01_sims.txt" u ($1/2):(1-$8):((($8*(1-$8)-$9)/4000)**0.5) w yerrorbars ps 1.5 pt 4 lw 3 lc rgb "orange" ti "$Ns=2$",\
"KS4Ku0.02_sims.txt" u ($1/4):(1-$4):((($4*(1-$4)-$5)/800)**0.5) w yerrorbars ps 1.5 pt 5 lw 3 lc rgb "red" ti "$Ns=4$",\
"KS8Ku0.04_sims.txt" u ($1/8):(1-$2):((($2*(1-$2)-$3)/800)**0.5) w yerrorbars ps 1.5 pt 5 lw 3 lc rgb "purple" ti "$Ns=8$",\
"KS16Ku0.08_sims.txt" u ($1/16):(1-$2):((($2*(1-$2)-$3)/400)**0.5) w yerrorbars ps 1.5 pt 5 lw 3 lc rgb "blue" ti "$Ns=16$",\
"Ks1Ku0.005_numerics.txt" u ($1):(1-$3) w lines lw 3 lt 3 lc rgb "brown" noti,\
"Ks2Ku0.01_numerics.txt" u ($1/2):(1-$5) w lines lw 3 lc rgb "orange" noti,\
"Ks4Ku0.02_numerics.txt" u ($1/4):(1-$5) w lines lw 3 lt 3 lc rgb "red" noti,\
"Ks8Ku0.04_numerics.txt" u ($1/8):(1-$3) w lines lw 3 lt 3  lc rgb "purple" noti,\
"Ks16Ku0.08_numerics.txt" u ($1/16):(1-$3) w lines lw 3 lt 3  lc rgb "blue" noti,\
"Ks1Ku0.005_numerics.txt" u ($1):(1-$2) w lines lw 3 lt 3 dt (1,1) lc rgb "brown" noti,\
"Ks2Ku0.01_numerics.txt" u ($1/2):(1-$2) w lines lw 3 dt (1,1) lc rgb "orange" noti,\
"Ks4Ku0.02_numerics.txt" u ($1/4):(1-$2) w lines lw 3 lt 3 dt (1,1) lc rgb "red" noti,\
"Ks8Ku0.04_numerics.txt" u ($1/8):(1-$2) w lines lw 3 lt 3 dt (1,1)  lc rgb "purple" noti,\
"Ks16Ku0.08_numerics.txt" u ($1/16):(1-$2) w lines lw 3 lt 3 dt (1,1)  lc rgb "blue" noti,\
"Deterministic_Ls0.8.txt" u 1:2 w lines lw 3 lt 3 dt (0.2,0.2)  lc rgb "black" noti


#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
