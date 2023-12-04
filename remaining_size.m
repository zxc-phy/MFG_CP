clear;
t=linspace(1,10,10);
x=rand(1,10);
r=zeros(10,1);

r(1)=3;
dt=1;
for i = 2:10
    dW = sqrt(dt) * randn;       % 随机扰动项    
    dX=10*(1-x(i)+0.04)*dt;  % 迭代公式
    r(i) = r(i-1) + dX;          % 更新信道增益的值
end
plot(t,r);