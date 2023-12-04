function q_t=utility(U,x,U1,C2)
% clear;
% t=linspace(1,10,10);
% x=rand(1,10);
% r=zeros(10,1);
% 
% r(1)=3;
% dt=1;
% for i = 2:10
%     dW = sqrt(dt) * randn;       % 随机扰动项    
%     dX=10*(-x(i)+0.04)*dt;  % 迭代公式
%     r(i) = r(i-1) + dX;          % 更新信道增益的值
% end
% plot(t,r);

global eta1 Qk dQ Nt Nq Nh varrho_q t d h omega_1 omega_2 omega_3 xi pik Lk dt Ik;
q_t=zeros(Nt,1);index=zeros(Nt,1);utility=zeros(Nt,1);
delay=zeros(Nt,1);income=zeros(Nt,1);
q_t(1)=8e7;index(1)=floor(q_t(1)/dQ);utility(1)=U(1,index(1),3);
delay(1)=C2(1,index(1),3);income(1)=U1(1,index(1),3);
total1=utility(1);total2=delay(2);total3=income(1);
for n=2:Nt
    dW=sqrt(dt)*randn*1e6;
%     disp(index(n-1));
%     disp(-x(n,index(n-1),3));
    dq_t = 4*Qk*dt*(omega_1*(-x(n,index(n-1),3))-omega_2*pik(n)+omega_3*xi^Lk(n))+dW;
    q_t(n)=q_t(n-1)+dq_t;
    index(n)=floor(q_t(n)/dQ);
    if index(n)<=0
        index(n)=1;
    end
    utility(n)=U(n,index(n),3);
    delay(n)=C2(n,index(n),3);
    income(n)=U1(n,index(n),3);
    total1=total1+utility(n);
    total2=total2+delay(n);
    total3=total3+income(n);
end

% figure;
% plot(t,income);
% disp(total1);
% disp(total2)
% disp(total3);
% disp(pik(1));

end