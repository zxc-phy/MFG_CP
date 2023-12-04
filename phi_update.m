%mean field
function [U1,C2,fieldPhi] = phi_update(m,x)
global M Nt Nq Nh p eta1 d t dh dQ Qk Ik softmax omega_4 omega_5 rate eta Hc;
p_sharing=0.3;
p_k =zeros(Nt,1);
qbar=zeros(Nt,1);
deltaq=zeros(Nt,1);
fieldPhi=zeros(Nt,Nq,Nh);
U1=zeros(Nt,Nq,Nh);
U2=zeros(Nt,1);%先空起来
C1=zeros(Nt,Nq,Nh);
C2=zeros(Nt,Nq,Nh);
C3=zeros(Nt,Nq,Nh);
P_2=zeros(Nt,Nq);
P_3=zeros(Nt,Nq);
for n=1:Nt
    for q=1:Nq
            p_k(n)=p_k(n)+eta1*m(n,q,2)*x(n,q,2)*dQ;
            qbar(n)=qbar(n)+d(q)*m(n,q,2)*dQ;
            
            if d(q)<=0.2*Qk
                deltaq(n)=deltaq(n)-d(q)*m(n,q,2)*dQ;
            elseif d(q)>0.2*Qk
                deltaq(n)=deltaq(n)+d(q)*m(n,q,2)*dQ;
            end
    end
    p_k(n)=p-p_k(n);
end
N1=zeros(Nt,1);
N2=zeros(Nt,1);
N3=zeros(Nt,1);
P_1=1./(1+exp(-softmax*(0.2*Qk-d)));
for n=1:Nt
    for q=1:Nq
        P_2(n,q)=1/(1+exp(-softmax*(d(q)-0.2*Qk)))*1/(1+exp(-softmax*(0.2*Qk-qbar(n))));
        P_3(n,q)=1/(1+exp(-softmax*(d(q)-0.2*Qk)))*1/(1+exp(softmax*(0.2*Qk-qbar(n))));
        N1(n)=N1(n)+m(n,q,3)*dQ*M*P_1(q);
        N2(n)=N2(n)+m(n,q,3)*dQ*M*P_2(n,q);
        N3(n)=N3(n)+m(n,q,3)*dQ*M*P_3(n,q);
    end
end
% figure;
% plot(t,qbar);
for n=1:Nt
    for q=1:Nq
        for l=1:Nh
            U1(n,q,l)=Ik(n)*p_k(n)*(P_1(q)*(Qk-d(q))+P_2(n,q)*(Qk-qbar(n))+P_3(n,q)*Qk);
            U2(n)=p_sharing*qbar(n)*(N2(n)/N1(n));
            C1(n,q,l)=omega_4*x(n,q,l)+omega_5*x(n,q,l)^2;
            C2(n,q,l)=eta*(Qk*x(n,q,l)/Hc+Ik(n)*(P_1(q)*(Qk-d(q))/rate(n)+P_2(n,q)*(Qk-qbar(n))/rate(n)+...
                P_3(n,q)*(d(q)/Hc+Qk/rate(n))));
            if d(q)>qbar(n)
                C3(n,q,l)=P_2(n,q)*p_sharing*(d(q)-qbar(n));
            end
            fieldPhi(n,q,l)=U1(n,q,l)+U2(n)-C1(n,q,l)-C2(n,q,l)-C3(n,q,l);
        end
    end
end
% figure;
% plot(t,U2);
% plot(t,qbar)
%     figure;
%     [X, Y] = meshgrid(d, t);
%     surf(X,Y,fieldPhi(:,:,2));
% figure;
% plot(d,U1(1,:,2));
% hold on;
% plot(d,C1(1,:,2));
% plot(d,C2(1,:,2));
% plot(d,C3(1,:,2));
% plot(d,fieldPhi(1,:,2));
% legend('U1','C1','C2','C3','fieldPhi');