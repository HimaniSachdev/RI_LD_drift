! simulates a metapopulation with nD islands, each belonging to one of two habitats under divergent selection.
      program wright_fisher
      integer(KIND=8) L,K,ndemes,ndemes_hab1,k6,histories,i,j,j1
      integer(KIND=8) k5,tsteps,mig,nnew,c3,j3,j6,c1,L2
      real(KIND=8) sel1,sel2,m,alpha,x,y,pini
      real(KIND=8) temp,temp1,temp2,theta,temp3,loglimit
      real(KIND=8) temp4,temp5,temp6,t2a,t3a,t4a,t1a,x2
      integer(KIND=8),allocatable, dimension(:,:,:)::n1_seq,n2_seq
      real(KIND=8), allocatable, dimension(:,:)::fit_indivs,freq,FST
      real(KIND=8), allocatable, dimension(:)::freq_hab1,popfreq
      real(KIND=8), allocatable, dimension(:):: gdiv_hab1,gdiv_hab2
      real(KIND=8), allocatable, dimension(:):: psurv_hab1,psurv_hab2
      real(KIND=8), allocatable, dimension(:):: LDvar_hab1,LDvar_hab2
      real(KIND=8), allocatable, dimension(:)::freq_hab2


      K=200   ! number of individuals per island  
      L=40    ! number of selected loci
      L2=L+40 ! L2-L is the number of neutral markers simulated
      ndemes=500  ! number of islands
      
      sel1=0.02D+0    ! selection coefficient per deleterious allele in habitat 1
      sel2=0.02D+0    ! selection coefficient per deleterious allele in habitat 2
      m=0.019d+0  ! migration rate m: probability of migration per individual per generation
      pini=0.5d+0     ! initial allele frequency at each locus
      
      loglimit=-log(tiny(double))

      histories=5     ! number of simulation replicates
      tsteps=15000    ! number of generations simulated 
      theta=1.0D+0/histories 

       

      alpha=0.9d+0   ! fraction of islands in common habitat: corresponds to 1-rho in notation of the paper.
      
      ndemes_hab1=nint(ndemes*alpha)
      print*, ndemes_hab1

      allocate(n1_seq(L2,K,ndemes),n2_seq(L2,2*K,ndemes))
      allocate(fit_indivs(K,ndemes),freq(L2,ndemes))
      allocate(freq_hab1(tsteps),freq_hab2(tsteps))
      allocate(gdiv_hab1(tsteps),gdiv_hab2(tsteps),FST(tsteps,15))
      allocate(LDvar_hab1(tsteps),LDvar_hab2(tsteps))
      allocate(psurv_hab1(tsteps),psurv_hab2(tsteps),popfreq(L2-L))

      do i=1,tsteps
      freq_hab1(i)=0.0d+0
      freq_hab2(i)=0.0d+0
      gdiv_hab1(i)=0.0d+0
      gdiv_hab2(i)=0.0d+0
      do j=1,15
      FST(i,j)=0.0d+0
      enddo
      enddo

      do i=1,L2-L
      popfreq(i)=0.0d+0
      enddo

       call init_random_seed
       
       do k6=1,histories
 
       print*, k6
!      start each replicate simulation by initialising allele frequencies in the population.
       do j1=1,ndemes_hab1
       do i=1,K
       do j=1,L2
       call random_number(x)
       if (x<pini)then
       n1_seq(j,i,j1)=0
       else
       n1_seq(j,i,j1)=1
       endif
       enddo
       enddo
       enddo


       do j1=ndemes_hab1+1,ndemes
       do i=1,K
       do j=1,L2
       call random_number(x)
       if (x<pini)then
       n1_seq(j,i,j1)=0
       else
       n1_seq(j,i,j1)=1
       endif
       enddo
       enddo
       enddo

       
        ! start time evolution
        do k5=1,tsteps
 ! migration
         do i=1,ndemes
 !       For each deme, choose the number of emigrants from Poisson distribution with mean K*m
         mig=0
         temp1=1.0D+0

         temp2=exp(-K*m)
  1      call random_number(y)
         temp1=temp1*y
         if  (temp1>temp2)then
         mig=mig+1
         go to 1
         endif
         
 !    For each deme, replace each emigrant by a randomly chosen individual from any of the remaining nD-1 demes.
         do j=1,mig
         call random_number(x2)
         j3=ceiling(K*(ndemes-1)*x2)
         j4=(j3/K)+1
         if (j4>=i)then
         j4=j4+1
         endif
         j6=mod(j3,K)
         call random_number(x2)
         j3=ceiling(K*x2)
         do j2=1,L2
         n1_seq(j2,j3,i)=n1_seq(j2,j6,j4)
         enddo
         enddo
         enddo


       

!       selection

        ! calculate the number of `1' alleles carried by each individual in each deme.
        
         do i=1,ndemes

         do j=1,K
         fit_indivs(j,i)=0.0d+0
         do j3=1,L    ! L (and not L2) here.
         fit_indivs(j,i)=fit_indivs(j,i)+n1_seq(j3,j,i)
         enddo
         enddo

         enddo

         
         
         ! calculate relative fitness of each individual in each deme:
         ! for habitat 1 (where all `0' alleles are favoured)
         do i=1,ndemes_hab1

         temp=0.0d+0
         do j=1,K  

         temp1=sel1*fit_indivs(j,i)
         if (temp1<loglimit)then
         fit_indivs(j,i)=exp(-temp1)
         else
         fit_indivs(j,i)=0.0d+0
         endif

         if (temp<fit_indivs(j,i))then
         temp=fit_indivs(j,i)
         endif

         enddo

         do j=1,K         
         fit_indivs(j,i)=fit_indivs(j,i)/temp
         enddo 
         enddo
         
         ! for habitat 2 (where all `1' alleles are favoured)
         do i=ndemes_hab1+1,ndemes

         temp=0.0d+0
         do j=1,K  
         temp1=sel1*(L-fit_indivs(j,i))
         if (temp1<loglimit)then
         fit_indivs(j,i)=exp(-temp1)
         else
         fit_indivs(j,i)=0.0d+0
         endif

         if (temp<fit_indivs(j,i))then
         temp=fit_indivs(j,i)
         endif
         enddo

         do j=1,K         
         fit_indivs(j,i)=fit_indivs(j,i)/temp
         enddo 
         enddo
         
!  create the next generation of offspring in each deme

          do i=1,ndemes

! Within each deme, sample 2N pairs of parents with sampling weights proportional to fitness and create new offspring by free recombination between loci
         do j=1,K
! sampling of a single pair of parents
 5       call random_number(y)
         j3=ceiling(K*y)
         call random_number(x)
         if (x>fit_indivs(j3,i))then
         go to 5
         endif

 6       call random_number(y)
         j4=ceiling(K*y)
         call random_number(x)
         if (x>fit_indivs(j4,i))then
         go to 6
         endif

! free recombination between a parental pair to create one offspring
         do j6=1,L2
         call random_number(y)
         if (y<0.5D+0)then
         n2_seq(j6,j,i)=n1_seq(j6,j3,i)         
         else
         n2_seq(j6,j,i)=n1_seq(j6,j4,i)        
         endif
         enddo
         enddo


         enddo

         do i=1,ndemes
         do j=1,K
         do j6=1,L2
         n1_seq(j6,j,i)=n2_seq(j6,j,i)         
         enddo
         enddo
         enddo
      
 
! calculate statistics at generation 40,80,120... .

          if (mod(k5,40)==0)then
	      do i=1,L2
	      do j=1,ndemes
	      freq(i,j)=0.0d+0
      	      enddo
              enddo

         do i=1,ndemes
         do j6=1,L2
         temp4=0.0D+0 
         do j=1,K
         temp4=temp4+n1_seq(j6,j,i)
         enddo
         freq(j6,i)=(temp4*1.0d+0)/K    ! determine the average frequency of the `1' allele for each deme for each locus.
         enddo
         enddo
       
         temp3=0.0d+0
         temp4=0.0d+0
         do i=1,ndemes_hab1
         do j6=1,L
         temp3=temp3+freq(j6,i)         ! determine the average allele frequency in habitat 1 by averaging over all selected loci and all demes in habitat 1
         temp4=temp4+freq(j6,i)*(1.0d+0-freq(j6,i)) ! determine the diversity E[pq] in habitat 1 by averaging over all selected loci and all demes in habitat 1
         enddo
         enddo

         freq_hab1(k5/40)=freq_hab1(k5/40)+
     c   (temp3/(ndemes_hab1*L))*theta
         gdiv_hab1(k5/40)=gdiv_hab1(k5/40)+
     c   (temp4/(ndemes_hab1*L))*theta
       

         temp3=0.0d+0
         temp4=0.0d+0
         do i=ndemes_hab1+1,ndemes
         do j6=1,L
         temp3=temp3+freq(j6,i)        ! determine the average allele frequency in habitat 2 by averaging over all selected loci and all demes in habitat 2
         temp4=temp4+freq(j6,i)*(1.0d+0-freq(j6,i)) ! determine the genetic diversity E[pq] in habitat 2 by averaging over all selected loci and all demes in habitat 2
         enddo
         enddo

         freq_hab2(k5/40)=freq_hab2(k5/40)+
     c   (temp3/((ndemes-ndemes_hab1)*L))*theta   
         gdiv_hab2(k5/40)=gdiv_hab2(k5/40)+
     c   (temp4/((ndemes-ndemes_hab1)*L))*theta  ! average the expected allele frequencies and genetic diversity across simulation replicates.  

         temp3=0.0d+0
         do i=L+1,L2
         popfreq(i-L)=0.0d+0
         do j=1,ndemes
         popfreq(i-L)=popfreq(i-L)+freq(i,j)
         enddo
         popfreq(i-L)=popfreq(i-L)/ndemes
         temp3=temp3+popfreq(i-L)*(1.0d+0-popfreq(i-L))  ! determine pbar(1-pbar) at each neutral markers (where pbar is the allele frequency at that marker across the entire metapopulation)
                                                         ! then average pbar(1-pbar) across all L2-L neutral markers.
         enddo
         temp3=temp3/(L2-L)

         do i=1,ndemes_hab1
         temp4=0.0d+0
         do j=L+1,L2
         temp4=temp4+((freq(j,i)-popfreq(j-L))**2)    ! determine Variance[p] across all demes in habitat 1 at each neutral marker and then average across all neutral markers.
         enddo
         temp4=temp4/(L2-L)
         FST(k5/40,1)=FST(k5/40,1)+(theta/ndemes_hab1)* 
     c  (temp4/temp3) ! determine the expected FST in habitat 1 as Var[p]/[pbar(1-pbar)] (averaged across all simulation replicates) where both Var[p] and pbar(1-pbar) are obtained by averaging across all markers (in a given replicate).
         FST(k5/40,2)=FST(k5/40,2)+(theta/ndemes_hab1)*   
     c  (temp4/temp3)*(temp4/temp3) ! store ( Var[p]/[pbar(1-pbar)] )^2 averaged across replicates: this will be used to determine the uncertainity in simulations estimates of FST.
         enddo


         do i=ndemes_hab1+1,ndemes
         temp4=0.0d+0
         do j=L+1,L2
         temp4=temp4+((freq(j,i)-popfreq(j-L))**2)
         enddo
         temp4=temp4/(L2-L)
         FST(k5/40,3)=FST(k5/40,3)+(theta/(ndemes-ndemes_hab1))* 
     c  (temp4/temp3)
! determine the expected FST in habitat 2 as Var[p]/[pbar(1-pbar)] (averaged across all replicates) where both Var[p] and pbar(1-pbar) are obtained by averaging across all markers (in a given replicate).
         FST(k5/40,4)=FST(k5/40,4)+(theta/(ndemes-ndemes_hab1))*  
     c  (temp4/temp3)*(temp4/temp3)   ! store ( Var[p]/[pbar(1-pbar)] )^2 averaged across replicates: this will be used to determine the uncertainity in simulations estimates of FST.
         enddo

!        determine pairwise FST between pairs of demes

!        FST_{cc}
         do i=1,ndemes_hab1
         do j=i+1,ndemes_hab1
         temp3=0.0d+0
         temp4=0.0d+0
         do j6=L+1,L2
         temp3=temp3+(0.5d+0*(freq(j6,i)+freq(j6,j)))*
     c   (1.0d+0-0.5d+0*(freq(j6,i)+freq(j6,j)))
         temp4=temp4+0.5d+0*freq(j6,i)*(1.0d+0-freq(j6,i))
     c   +0.5d+0*freq(j6,j)*(1.0d+0-freq(j6,j))
         enddo
         temp3=temp3/(L2-L)
         temp4=temp4/(L2-L)
         FST(k5/40,5)=FST(k5/40,5)+(temp4/temp3)*2.0d+0*
     c   (theta/(ndemes_hab1*(ndemes_hab1-1)))
         enddo
         enddo                     
       

!        FST_{rr}
         do i=ndemes_hab1+1,ndemes
         do j=i+1,ndemes
         temp3=0.0d+0
         temp4=0.0d+0
         do j6=L+1,L2
         temp3=temp3+(0.5d+0*(freq(j6,i)+freq(j6,j)))*
     c   (1.0d+0-0.5d+0*(freq(j6,i)+freq(j6,j)))
         temp4=temp4+0.5d+0*freq(j6,i)*(1.0d+0-freq(j6,i))
     c   +0.5d+0*freq(j6,j)*(1.0d+0-freq(j6,j))
         enddo
         temp3=temp3/(L2-L)
         temp4=temp4/(L2-L)
         FST(k5/40,6)=FST(k5/40,6)+(temp4/temp3)*2.0d+0*
     c   (theta/((ndemes-ndemes_hab1)*(ndemes-ndemes_hab1-1)))
         enddo
         enddo                     

!        FST_{cr}
         do i=ndemes_hab1+1,ndemes
         do j=1,ndemes_hab1
         temp3=0.0d+0
         temp4=0.0d+0
         do j6=L+1,L2
         temp3=temp3+(0.5d+0*(freq(j6,i)+freq(j6,j)))*
     c   (1.0d+0-0.5d+0*(freq(j6,i)+freq(j6,j)))
         temp4=temp4+0.5d+0*freq(j6,i)*(1.0d+0-freq(j6,i))
     c   +0.5d+0*freq(j6,j)*(1.0d+0-freq(j6,j))
         enddo
         temp3=temp3/(L2-L)
         temp4=temp4/(L2-L)
         FST(k5/40,7)=FST(k5/40,7)+(temp4/temp3)*
     c   (theta/((ndemes-ndemes_hab1)*ndemes_hab1))
         enddo
         enddo                     

         endif
         enddo
         enddo

! The output file will consist of 12 columns with the following information: 
! col 1 -> generation number n in multiples of 40 (where 1,2,.. correspond to 40,80,.. generations)
! col 2 and 3 -> expected frequency of the `1' allele in habitats 1 and 2 respectively at generation n (averaged over all demes in that habitat and all selected loci and all simulation replicates)
! col 4 and 5 -> expected diversity E[pq] WITHIN demes in habitats 1 and 2 respectively at generation n (averaged over all demes in that habitat and all selected loci and all simulation replicates)
! col 6 and 8 -> E[FST] in the first and second habitats (caluclated as above)
! col 7 and 9 -> E[FST^2] in the first and second habitats (averaged over simulation replicates): can be used to calculate variance across replicates as E[FST^2]-E[FST]^2
! cols 10-12: pairwise FST_{cc}, FST_{rr}, FST_{rc}       
 19   open(41,file='L40_K200_rho_0.9_S0.02_M0.019_5rep_nd500.txt')
      do i=1,tsteps/40
      write(41,9) i,freq_hab1(i),freq_hab2(i),gdiv_hab1(i),gdiv_hab2(i)
     c ,FST(i,1),FST(i,2),FST(i,3),FST(i,4),FST(i,5),FST(i,6),FST(i,7)
 9    Format(I8,1X,F15.9,1X,F15.9,1X,F15.9,1X,F15.9,F15.9,1X,F15.9,1X,
     c F15.9,1X,F15.9,1X,F15.9,1X,F15.9,1X,F15.9,1X,F15.9)
      enddo
      close(41)


      end
       
       
       
      SUBROUTINE init_random_seed()
      INTEGER :: z, m, clock
      INTEGER, DIMENSION(:), ALLOCATABLE :: seed, seedold
      
      CALL RANDOM_SEED(size = m)
      ALLOCATE(seed(m), seedold(m))
      
      CALL SYSTEM_CLOCK(COUNT=clock)
      
      seed = clock + 37 * (/ (z - 1, z = 1, m) /)
      CALL RANDOM_SEED(PUT = seed)
      CALL RANDOM_SEED(GET = seedold)
      
      DEALLOCATE(seed)
      END SUBROUTINE init_random_seed

