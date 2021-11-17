set output  "Genotype_distributions.tex"
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

se yrange [0.000001:0.2]
#se xrange [0.0:1.0]
#se xtics (0.0,0.2,0.4,0.6,0.8,1.0)
#se yrange [0.0:1.0]
se ytics ("$10^{-6}$" 0.000001,"$10^{-5}$" 0.00001,"$10^{-4}$" 0.0001,"$10^{-3}$" 0.001,"$10^{-2}$" 0.01, "$10^{-1}$" 0.1, "$1$" 1.0)
se logsc y
#se logsc x
se key top right

se xlabel "number $y$ of deleterious alleles in genotype"
se ylabel "genotype frequency $P_y$"
se label "$s=0.02 \\quad L=40 \\quad Ns = 2.0 \\quad N\\mu=0.01$"  at 4.0,0.3
set style function lines

pl "genotypeD_K100_Ks2_L40_Kmu0.01Km0.2_10000reps.txt" u ($1-1):2 ps 1.5 pt 4 lw 3 lc rgb "red" ti "$Nm=0.2$",\
"genotypeD_K100_Ks2_L40_Kmu0.01Km0.4_10000reps.txt" u ($1-1):2 ps 1.5 pt 6 lw 3 lc rgb "blue" ti "$Nm=0.4$",\
"genotypeD_K100_Ks2_L40_Kmu0.01_Km0.2_theory.txt" u 1:2 w lines lw 3 lc rgb "red" noti,\
"genotypeD_K100_Ks2_L40_Kmu0.01_Km0.2_theory2.txt" u ($1+7):2 w lines lw 3 dt (1,1) lc rgb "red" noti,\
"genotypeD_K100_Ks2_L40_Kmu0.01_Km0.4_theory.txt" u 1:2 w lines lw 3 lc rgb "blue" noti,\
"genotypeD_K100_Ks2_L40_Kmu0.01_Km0.4_theory2.txt" u ($1+17):2 w lines lw 3 dt (1,1) lc rgb "blue" noti

#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
