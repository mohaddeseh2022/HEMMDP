function [pos,newbuffer]=P3Samp_ver3(p1,p11,p2,p22,p3,p33,p4,p44,newbuffer,pos)

global ADD SUB MUL DIV Var Rand FSET_START FSET_END RAND_START Var_START RAND_END

newbuffer(pos)=RAND_START; %dummy assignment,, 6 is equavalent to a real number, this assignment is for finding the parent and brother
% the real newbuffer(pos) will be assigned later
[par1  broth]=NodeParent_ver3(newbuffer,pos);
if broth==0
newbuffer(pos+1)=RAND_START; %dummy assignment
end
[par2 uncle1]=NodeParent_ver3(newbuffer,par1);
if (broth~=0 && uncle1==0)
newbuffer(pos+1)=RAND_START; %dummy assignment
elseif (broth==0 && uncle1==0)
newbuffer(pos+2)=RAND_START; %dummy 
end  
[par3 uncle2]=NodeParent_ver3(newbuffer,par2);

if broth==0
 for k=1:FSET_END
     for u=1:FSET_END
         for v=1:FSET_END
      if (newbuffer(par3)==v && newbuffer(par2)==u && newbuffer(par1)==k)
           p2a=p3(:,k,u,v);
           [p2prime,ind]=sort(p2a);
           r=rand;
           if r<=p2prime(1)
              indx=ind(1);       
           else
               p2start=p2a(ind(1));
              for j=1:size(p2a,1)-1
                 if (r>p2start && r<=p2start+p2a(ind(j+1)))
                    indx=ind(j+1);
                    break;
                 end
                 p2start=p2start+p2a(ind(j+1));
              end
           end
      end
     end
    end
 end
 
newbuffer(pos)=indx;
pos=pos+1; 

end



if broth~=0
 for k=1:FSET_END
     for u=1:FSET_END
       for v=1:FSET_END
         for b=1:RAND_END
      if (newbuffer(par3)==v && newbuffer(par2)==u && newbuffer(par1)==k && newbuffer(broth)==b)
           p2b=p33(:,k,u,v,b);
           [p2prime,ind]=sort(p2b);
           r=rand;
           if r<=p2prime(1)
              indx=ind(1);       
           else
               p2start=p2b(ind(1));
              for j=1:size(p2b,1)-1
                 if (r>p2start && r<=p2start+p2b(ind(j+1)))
                    indx=ind(j+1);
                    break;
                 end
                 p2start=p2start+p2b(ind(j+1));
              end
           end
      end
     end
     end
     end
 end
 
newbuffer(pos)=indx;
pos=pos+1; 
 
end


if (0<indx && indx<FSET_END+1)
    [pos,newbuffer]=P4Samp_ver3(p1,p11,p2,p22,p3,p33,p4,p44,newbuffer,pos);  
else
    if broth==0
   [pos,newbuffer]=P3Samp_ver3(p1,p11,p2,p22,p3,p33,p4,p44,newbuffer,pos);%noncomplete tree: [pos,newbuffer]=P3bSamp_ver3(p1,p11,p2,p22,p3,p33,p4,p44,newbuffer,pos);
    
    elseif uncle1==0
    [pos,newbuffer]=P2Samp_ver3(p1,p11,p2,p22,p3,p33,p4,p44,newbuffer,pos);  
    
    elseif (uncle1~=0 && uncle2==0)
    [pos,newbuffer]=P1Samp_ver3(p1,p11,p2,p22,p3,p33,p4,p44,newbuffer,pos);  
    
    elseif (uncle1~=0 && uncle2~=0)
        return
    
    end
end    
 


                     
           
       