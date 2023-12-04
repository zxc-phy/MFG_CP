% cost function
function C = cost(r,fieldPhi)
global B noise_power eta d h t Nq Nh Nt dQ dt dh lambda xi;
C_1=zeros(Nt,Nq,Nh);
C_2=zeros(Nt,Nq,Nh);
C=zeros(Nt,Nq,Nh);
 for n = 1:Nt
        for q = 1:Nq
            for l = 1:Nh
                C_1(n,q,l) = eta*(2^(r(n,q,l)/B)-1)*noise_power/h(l);
                C_2(n,q,l)=fieldPhi(n)*r(n,q,l);
                C(n,q,l)=C_1(n,q,l)+C_2(n,q,l);
            end
        end
 end

end