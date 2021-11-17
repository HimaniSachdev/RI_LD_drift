set output  "freq_distributions.tex"
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

se yrange [0.00005:0.5]
se xrange [0.0:1.0]
se xtics (0.0,0.2,0.4,0.6,0.8,1.0)
#se yrange [0.0:1.0]
se ytics (0.00005,0.0005,0.005,0.05,0.5)
se logsc y
#se logsc x
se key at 0.9,0.002

se xlabel "frequency $p$ of locally favoured alleles"
se ylabel "fraction of loci at frequency $p$"
se label "$s=0.02 \\quad L=20 \\quad \\mu/s = 0.05$"  at 0.2,0.6
set style function lines

pl "binneddist_K100.txt" u ((20-$1)*0.05+0.025):2 ps 1.5 pt 4 lw 3 lc rgb "red" ti "$Ns=2 \\quad Nm=0.300$",\
"binneddist_K200.txt" u ((20-$1)*0.05+0.025):2 ps 1.5 pt 6 lw 3 lc rgb "blue" ti "$Ns=4 \\quad Nm=1.424$",\
"binneddist_K400.txt" u ((20-$1)*0.05+0.025):2 ps 1.5 pt 8 lw 3 lc rgb "black" ti "$Ns=8 \\quad Nm=4.356$",\
"freqdist_Ks2Kmu0.01Km0.3.txt" u ((20-$1)*0.05+0.025):($2/0.980613) w lines lw 3 lc rgb "red"  noti,\
"freqdist_Ks4Kmu0.02Km1.424.txt" u ((20-$1)*0.05+0.025):($2/0.99944) w lines lw 3 lc rgb "blue"  noti,\
"freqdist_Ks8Kmu0.04Km4.356.txt" u ((20-$1)*0.05+0.025):($2/0.9999997) w lines lw 3 lc rgb "black" noti




#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
