! simulates a single island subject to migration from a monomorphic mainland.
      program wright_fisher
      integer(KIND=8) L,K,k6,histories,i,j,j1
      integer(KIND=8) k5,tsteps,mig,nnew,c3,j3,j6,c1
      real(KIND=8) sel,m,alpha,x,y,pini,mut
      real(KIND=8) temp,temp1,temp2,theta,temp3,loglimit
      real(KIND=8) temp4,temp5,temp6,t2a,t3a,t4a,t1a,x2
      integer(KIND=8),allocatable, dimension(:,:)::n1_seq,n2_seq
      real(KIND=8), allocatable, dimension(:)::fit_indivs,freq
      real(KIND=8), allocatable, dimension(:)::freq_isle,gdiv_isle
      real(KIND=8), allocatable, dimension(:)::freqdist


      K=100  ! number of individuals on the island  
      L=40   ! number of selected loci
      
      mut=0.0001d+0 ! rate of mutation per locus per individual per generation 
      sel=0.02D+0  ! strength of selection per locally deleterious allele
      m=0.5/K  ! rate of migration per individual per generation
      
      loglimit=-log(tiny(double))

      histories=1000  ! number of simulation replicates
      tsteps=30000    !number of generations for which each replicate is evolved
      theta=1.0D+0/histories

       
      allocate(n1_seq(L,K),n2_seq(L,2*K))
      allocate(fit_indivs(K),freq(L),freqdist(K+1))
      allocate(freq_isle(tsteps),gdiv_isle(tsteps))

      do i=1,tsteps
      freq_isle(i)=0.0d+0
      gdiv_isle(i)=0.0d+0
      enddo

      do i=1,K+1
      freqdist(i)=0.0d+0
      enddo


       call init_random_seed
       
       do k6=1,histories
       print*, k6

!      start each replicate simulation by initialising allele frequencies in the population (island initially perfectly adapted)

       do i=1,K
       do j=1,L
       n1_seq(j,i)=0
       enddo
       enddo

       

        do k5=1,tsteps
        ! start time evolution 
!        migration
    
         mig=0
         temp1=1.0D+0

         temp2=exp(-m*K)
  1      call random_number(y)
         temp1=temp1*y
         if  (temp1>temp2)then
         mig=mig+1
         go to 1
         endif                   !       Choose mig-> the number of emigrants from Poisson distribution with mean K*m
         do j=1,mig
         call random_number(x2)  ! replace mig randomly chosen individuals with mainland individuals (carrying the locally delet. `1' allele at each locus)
         j3=ceiling(K*x2)
         do j2=1,L
         n1_seq(j2,j3)=1
         enddo
         enddo


       

!       selection

        ! calculate number of locally deleterious alleles carried by each individual.

         do j=1,K
         fit_indivs(j)=0.0d+0
         do j3=1,L    
         fit_indivs(j)=fit_indivs(j)+n1_seq(j3,j)
         enddo
         enddo

         ! calculate relative fitness of each individual         
         temp=0.0d+0
         do j=1,K  
         temp1=sel*fit_indivs(j)
         if (temp1<loglimit)then
         fit_indivs(j)=exp(-temp1)
         else
         fit_indivs(j)=0.0d+0
         endif
         if (temp<fit_indivs(j))then
         temp=fit_indivs(j)
         endif
         enddo

         do j=1,K         
         fit_indivs(j)=fit_indivs(j)/temp
         enddo 
         
         
!  create the next generation of offspring by sampling 2N pairs of parents with sampling weights proportional to fitness and then free recombination between each parental pair

         do j=1,K
! sampling of a single pair of parents
 5       call random_number(y)
         j3=ceiling(K*y)
         call random_number(x)
         if (x>fit_indivs(j3))then
         go to 5
         endif
 6       call random_number(y)
         j4=ceiling(K*y)
         call random_number(x)
         if (x>fit_indivs(j4))then
         go to 6
         endif

! free recombination between a parental pair to create one offspring
         do j6=1,L
         call random_number(y)
         if (y<0.5D+0)then
         n2_seq(j6,j)=n1_seq(j6,j3)   
         call random_number(y)
         if (y<mut)then 
         n2_seq(j6,j)=mod(n2_seq(j6,j)+1,2)
         endif
      
         else
         n2_seq(j6,j)=n1_seq(j6,j4)        
         call random_number(y)
         if (y<mut)then 
         n2_seq(j6,j)=mod(n2_seq(j6,j)+1,2)
         endif

         endif

         enddo
         enddo


         do j=1,K
         do j6=1,L
         n1_seq(j6,j)=n2_seq(j6,j)         
         enddo
         enddo
      
! determine expected deleterious allele frequency and heterozygosity in the island population at generation 40,80,120... .


          if (mod(k5,40)==0)then
          do i=1,L
          freq(i)=0.0d+0
          enddo

          do j6=1,L
          temp4=0.0D+0 
          do j=1,K
          temp4=temp4+n1_seq(j6,j)
          enddo
          freq(j6)=(temp4*1.0d+0)/K   ! determine allele freq at each locus
          enddo
       
          temp3=0.0d+0
          temp4=0.0d+0
          do j6=1,L
          temp3=temp3+freq(j6)  ! determine average allele freq by averaging across all equal-effect loci
          temp4=temp4+freq(j6)*(1.0d+0-freq(j6))  ! determine average diversity E[pq] by averaging across all equal-effect loci
          enddo
         
          freq_isle(k5/40)=freq_isle(k5/40)+(temp3/L)*theta  ! average allele freq and diversity across all simulation replicates.
          gdiv_isle(k5/40)=gdiv_isle(k5/40)+(temp4/L)*theta
          endif
          enddo

!         measure allele frequency distributions at the end of each simulation
          do j6=1,L
          j3=0
          do j=1,K
          j3=j3+n1_seq(j6,j)
          enddo
          freqdist(j3+1)=freqdist(j3+1)+theta/L
          enddo


          enddo



! The output file will consist of the following information: 
! col 1 -> generation number n in multiples of 40 (where 1,2,.. correspond to 40,80,.. generations)
! col 2 -> expected frequency of the locally deleterious allele on the island at generation n (averaged over all selected loci and all simulation replicates).
! col 3 -> expected diversity E[pq] WITHIN the island at generation n (averaged over all selected loci and all simulation replicates)       
      open(41,file='islandK100_Ks2L40Kmu0.01Km0.31967_1000repsB.txt')
      do i=1,tsteps/40
      write(41,9) i,freq_isle(i),gdiv_isle(i)
 9    Format(I8,1X,F15.9,1X,F15.9)
      enddo
      close(41)

! The output file will print the site frequency spectrum for selected loci 
! col 1 -> i+1, where i-> number of allele copies ranges from 0 to K.
! col 2 -> probability that i copies of the locally deleterious allele segregate at the selected locus in the population (determined by averaging over all selected loci and all simulation replicates at the end of each simulation)

      open(41,file='freqdistK100_Ks2L40Kmu0.01Km0.31967_1000repsB.txt')
      do i=1,K+1
      write(41,8) i,freqdist(i)
 8    Format(I8,1X,F15.9)
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

