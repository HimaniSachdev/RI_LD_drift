set output  "NmcritVsL_rho1by10.tex"
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
se xrange [0.0:1.6]
se xtics (0.0,0.4,0.8,1.2,1.6)
se yrange [-0.2:22.0]
#se ytics (0.0,0.2,0.4,0.6,0.8,1.0)
#se logsc y
#se logsc x
se key at 0.5,21

se xlabel "selective disadvantage of least fit migrants $Ls$"
se ylabel "critical migration threshold $Nm_{c}$"
se label "$s=0.02 \\quad \\mathbf{\\rho=0.1}$"  at 0.6,22.5
set style function lines

pl "Nmcrit_vs_L_rho0.1.txt"  u ($1*0.02):3 w lines lw 3 lc rgb "black" ti "$Ns=1$",\
"Nmcrit_vs_L_rho0.1.txt"  u ($1*0.02):4 w lines lw 3 dt (0.25,0.25)lc rgb "red" ti "$Ns=2$",\
"Nmcrit_vs_L_rho0.1.txt"  u ($1*0.02):5 w lines lw 3 dt (1,1) lc rgb "blue" ti "$Ns=4$",\
"Nmcrit_vs_L_rho0.1.txt"  u ($1*0.02):6 w lines lw 3 dt (3,3)  lc rgb "green" ti "$Ns=8$"

#set terminal po col
#set output # closes file
#pause -1 "Hit any key to continue"

#system('epstopdf abc_MM-inc.eps && pdflatex abc_MM.tex')
#system('latex abc_MM.tex && dvips abc_MM.dvi && ps2pdf abc_MM.ps')
