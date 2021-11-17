set output  "meffVsL.tex"
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
#se xrange [0.0:1.2]
se xtics (10,20,40,80,160)
#se yrange [0.0:1.0]
#se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
se logsc y
se logsc x
se key top right

se xlabel "number of loci $L$"
se ylabel "$(m_{e}/m\\, e^{-2sL}) -1$"
set style function lines

pl "meffVsL.txt" u 1:(($2/$4)-1) w lines lw 3 lt 1 lc rgb "red" ti "$Ls=0.5$",\
"meffVsL.txt" u 1:(($3/$4)-1) w lines lw 3 lt 1 dt (1,1) lc rgb "red" noti,\
"meffVsL.txt" u 1:(($5/$7)-1) w lines lw 3 lt 1 lc rgb "blue" ti "$Ls=1.0$",\
"meffVsL.txt" u 1:(($6/$7)-1) w lines lw 3 lt 1 dt (1,1) lc rgb "blue" noti,\
"meffVsL.txt" u 1:(($8/$10)-1) w lines lw 3 lt 1 lc rgb "black" ti "$Ls=2.0$",\
"meffVsL.txt" u 1:(($9/$10)-1) w lines lw 3 lt 1 dt (1,1) lc rgb "black" noti,\

#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
