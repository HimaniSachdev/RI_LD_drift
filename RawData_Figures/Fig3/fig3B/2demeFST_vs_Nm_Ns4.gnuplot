set output  "2demeFST_vs_Nm_Ns4.tex"
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

se yrange [0.0:1.0]
#se xrange [0.0:0.6]
#se xtics (0.0,0.1,0.2,0.3,0.4,0.5,0.6)
#se yrange [0.0:1.0]
se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
#se logsc y
#se logsc x
se key top right

se xlabel "average number of migrants $N m$"
se ylabel "two-deme $F_{ST}$"
se label "$s=0.02 \\quad L=40 \\quad  Ns=4 \\quad  \\rho=0.1$"  at 0.5,1.02
set style function lines

pl "Ks4_L40_Ls0.8_rho0.1.txt" u 1:7 w lines lw 3 lt 4 dt (0.3,0.3) lc rgb "red" ti "rare/rare",\
"Ks4_L40_Ls0.8_rho0.1.txt" u 1:8 w lines lw 3 lt 4 dt (1.5,1.5) lc rgb "black" ti "common/rare",\
"Ks4_L40_Ls0.8_rho0.1.txt" u 1:6 w lines lw 3 lc rgb "blue" ti "common/common",\
"L40_KS4_rho0.1_sims.txt"  u 1:8  ps 1.5 pt 7 lw 3 lc rgb "blue" noti,\
"L40_KS4_rho0.1_sims.txt"  u 1:9  ps 1.5 pt 9 lw 3 lc rgb "red" noti,\
"L40_KS4_rho0.1_sims.txt"  u 1:10  ps 1.5 pt 11 lw 3 lc rgb "black" noti


#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
