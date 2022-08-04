function [MIbest,MIone,MIp,Trpop,pop,FinalRing,pervMIMax,pervMIMax2,t,tt,MI]=MutualInf_Final(buffer,rnd,popSize,varnumber,validD,trainD,fitss,BlockValue,BSPlusJ,Coeff,k,pervMIMax,pervMIMax2,Block_result)

S=load('temp_global_parallel');
RAND_START=S.RAND_START;
RAND_END=S.RAND_END;

Y = trainD(:,varnumber+1);
Yp=validD(:,varnumber+1);
 for j=1:popSize   
      buffer1{k}{j}=buffer{j};
     [buffer1,dummyn]=CalccoefficientFinal(BlockValue,k,j,buffer1);
     [result, pos]=run_verComb(buffer1{k}{j},1,trainD,rnd{j},RAND_END);
  
if j==1
Re=result;
end
if j>1
Re=horzcat(Re,result);
end
   
 end
MI=abs(corr(Re,Y));
MI(isnan(MI))=0;
[MIone,MIind]=sort(MI,'descend');
 %%%%%%%%%%%%%%%%%% 
 
 i=0;
 while (i<popSize)
       i=i+1;
     buffer1{k}{MIind(i)}=buffer{MIind(i)};
     [buffer1,dummyn]=CalccoefficientFinal(BlockValue,k,MIind(i),buffer1);
     [resultp, pos]=run_verComb(buffer1{k}{MIind(i)},1,validD,rnd{MIind(i)},RAND_END);
     lambdap=abs(corr(resultp,Yp));
     MIp(i)=lambdap;
     if isnan (MIp(i))
        MIp(i)=0;
     end
 end
 
  count=0; %we need 10 best buffers
  i=0;
  t=0;
  tt=0;
   while (i<popSize && count<10)
       i=i+1;
    
     if (MIp(i)>=pervMIMax && MIone(i)>=pervMIMax2)
         t=t+1
         vMI(t)=MIp(i); 
         pop.indiv(t).value=buffer{MIind(i)}; %buffer1{k}{MIind(i)};
         pop.indiv(t).rand=rnd{MIind(i)};
         %pop.indiv(t).fit=fitss{MIind(i)};
         
         buffer2{k}{t}=buffer{MIind(i)};
         
         MIbest(t)=MIone(i);
         count=count+1; 
     end   
     
   end  
if t==0   
disp('t==============================================================0')
pop.indiv(1).value=RAND_START; 
pop.indiv(1).rand=0.5;
pop.indiv(1).expr=0.5;
t=1;
end
  for i=1:popSize
  % if (MIone(i)>=pervMIMax2)
         tt=tt+1
         Trpop.indiv(tt).value=buffer{MIind(i)}; 
         Trpop.indiv(tt).rand=rnd{MIind(i)};
         %Trpop.indiv(tt).fit=fitss{MIind(i)};
        
     % end
   end
  
%%%%%%%%%%%%%%%%%%%%%%%%   
    FinalRing=0; %Stop program execution
   if (count==0)
       FinalRing=1;
       MIbest=0;
   else
   pervMIMax=vMI(1); 
   pervMIMax2=MIbest(1);
   end
   
     for u=1:RAND_END-RAND_START+1
      randomnumbers(u)=0.5;
      end     
     
end
  



