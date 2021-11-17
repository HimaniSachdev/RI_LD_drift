set output  "LA_vs_Nm.tex"
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
se xrange [0.0:2.0]
se xtics (0.0,0.4,0.8,1.2,1.6,2.0)
se yrange [0.0:1.0]
se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
#se logsc y
#se logsc x
se key bottom left

se xlabel "average number of migrants $Nm$"
se ylabel "Expected frequency of locally adaptive allele"
se label "$Ns=2 \\quad N\\mu=0.01$" at 0.6,1.02
set style function lines

pl "LA_vs_Nm.txt" u 1:(1-$2) w lines lw 3 lt 1 lc rgb "red" ti "$L=20$",\
"LA_vs_Nm.txt" u 1:(1-$3) w lines lw 3 lt 1 lc rgb "blue" ti "$L=40$",\
"LA_vs_Nm.txt" u 1:(1-$4) w lines lw 3 lt 1 lc rgb "brown" ti "$L=80$",\
"LA_vs_Nm.txt" u 1:(1-$5) w lines lw 3 lt 1 lc rgb "black" ti "$L\\rightarrow \\infty$",\
"LA_vs_Nm.txt" u 1:(1-$6) w lines lw 3 lt 1 dt (1,1) lc rgb "red" noti,\
"LA_vs_Nm.txt" u 1:(1-$7) w lines lw 3 lt 1 dt (1,1) lc rgb "blue" noti,\
"LA_vs_Nm.txt" u 1:(1-$8) w lines lw 3 lt 1 dt (1,1) lc rgb "brown" noti,\
"LA_vs_Nm.txt" u 1:(1-$9) w lines lw 3 lt 1 dt (1,1) lc rgb "black" noti,\
"LA_vs_Nm.txt" u 1:(1-$10) w lines lw 3 lt 1 dt (0.3,0.3) lc rgb "red" noti,\
"LA_vs_Nm.txt" u 1:(1-$11) w lines lw 3 lt 1 dt (0.3,0.3) lc rgb "blue" noti,\
"LA_vs_Nm.txt" u 1:(1-$12) w lines lw 3 lt 1 dt (0.3,0.3) lc rgb "brown" noti,\
"LA_vs_Nm.txt" u 1:(1-$13) w lines lw 3 lt 1 dt (0.3,0.3) lc rgb "black" noti


#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
