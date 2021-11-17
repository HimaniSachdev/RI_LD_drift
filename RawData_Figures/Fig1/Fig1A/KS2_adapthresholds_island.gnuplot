set output  "KS2_adapthres_island.tex"
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

se multiplot
se origin 0,0
se size 1,1

se xrange [0.0:1.5]
se xtics (0.0,0.3,0.6,0.9,1.2,1.5)
se yrange [0.0:1.0]
se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
#se logsc y
#se logsc x
se key at 0.45,0.26
se key spacing 0.8

se xlabel "average number of migrants per generation $Nm$"
se ylabel "expected frequency of locally favoured allele"
se label "$s=0.02 \\quad Ns=2 \\quad N\\mu=0.01$"  at 0.2,1.02
set style function lines

pl "KS2Ku0.01_sims.txt" u 1:(1-$2):((($2*(1-$2)-$3)/2000)**0.5) w yerrorbars ps 1.5 pt 4 lw 3 lc rgb "brown" ti "$L=1$",\
"KS2Ku0.01_sims.txt" u 1:(1-$4):((($4*(1-$4)-$5)/2000)**0.5) w yerrorbars ps 1.5 pt 6 lw 3 lc rgb "orange" ti "$L=10$",\
"KS2Ku0.01_sims.txt" u 1:(1-$6):((($6*(1-$6)-$7)/2000)**0.5) w yerrorbars ps 1.5 pt 8 lw 3 lc rgb "red" ti "$L=20$",\
"KS2Ku0.01_sims.txt" u 1:(1-$8):((($8*(1-$8)-$9)/2000)**0.5) w yerrorbars ps 1.5 pt 10 lw 3 lc rgb "purple" ti "$L=40$",\
"KS2Ku0.01_sims.txt" u 1:(1-$10):((($10*(1-$10)-$11)/4000)**0.5) w yerrorbars ps 1.5 pt 12 lw 3 lc rgb "blue" ti "$L=80$",\
"Ks2Ku0.01_numerics.txt" u 1:(1-$2) w  lines lw 3 lc rgb "brown"  noti,\
"Ks2Ku0.01_numerics.txt" u 1:(1-$3) w  lines lw 3 lc rgb "orange" noti,\
"Ks2Ku0.01_numerics.txt" u 1:(1-$4) w  lines lw 3  lc rgb "red" noti,\
"Ks2Ku0.01_numerics.txt" u 1:(1-$5) w  lines lw 3 lc rgb "purple" noti,\
"Ks2Ku0.01_numerics.txt" u 1:(1-$6) w  lines lw 3 lc rgb "blue" noti

se origin 0.55,0.45
se size 0.44,0.53
se xlabel "\\footnotesize{$Ls$}" offset 0,1
se ylabel "\\footnotesize{Load}" offset 3
se key  bmargin
se xrange [0.0:2.0]
se xtics ("\\footnotesize{$0$}" 0 , "\\footnotesize{$1$}" 1, "\\footnotesize{$2$}" 2) offset 0, 0.5
se yrange [0.0:1.2]
se ytics ("\\footnotesize{$0$}" 0 , "\\footnotesize{$0.4$}" 0.4, "\\footnotesize{$0.8$}" 0.8, "\\footnotesize{$1.2$}" 1.2) offset 0.5
unse label
pl "Load_vs_L_sims.txt" u ($1*0.02):(0.02*$1*$2):(0.02*$1*((($2*(1-$2)-$7)/$12)**0.5)) w yerrorbars ps 1.5 pt 4 lw 3 lc rgb "black" ti "\\footnotesize{$Nm=0.2$}",\
 "Load_vs_L_sims.txt" u ($1*0.02):(0.02*$1*$3):(0.02*$1*((($3*(1-$3)-$8)/$13)**0.5)) w yerrorbars ps 1.5 pt 6 lw 3 lc rgb "black" ti "\\footnotesize{$Nm=0.4$}",\
 "Load_vs_L_sims.txt" u ($1*0.02):(0.02*$1*$6):(0.02*$1*((($6*(1-$6)-$11)/$16)**0.5)) w yerrorbars ps 1.5 pt 8 lw 3 lc rgb "black" ti "\\footnotesize{$Nm=0.6$}",\
 "Load_vs_L_numerics.txt" u ($1*0.02):(0.02*$1*$2) w lines lw 3 lc rgb "black" noti,\
 "Load_vs_L_numerics.txt" u ($1*0.02):(0.02*$1*$3) w lines lw 3  lc rgb "black" noti,\
 "Load_vs_L_numerics.txt" u ($1*0.02):(0.02*$1*$8) w lines lw 3  lc rgb "black" noti,\
x w lines lw 3 dt (1,1) lc rgb "black" noti

#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
