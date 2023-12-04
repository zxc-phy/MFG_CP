clear;
% hold off;

% 参数设置
global zeta varrho_q varrho_h omega_1 omega_2 omega_3 xi mean_h;
zeta=0; varrho_h=0;
varrho_q=0;omega_1=1;omega_2=1/10;omega_3=10;xi=0.1;
global d h t Nq Nh Nt dQ dt dh v_final m_0 Qk pik Lk Ik M;
global omega_5 omega_4 eta Hc;
omega_4=2.5*10^3;omega_5=0.65*10^8;eta=2.2*10^6;Hc=1.2*10^7; %按x=0.1计算
M=100;

% state和time网格
D = 10^8;Qk=10^8; % remaining storage =0.1G
hmin = 5* 10 ^ -7; hmax = 15* 10 ^ -7;mean_h=10*10^-7; %信道增益，* 10 ^ -3
T = 1; % 时间范围，
dQ = 2.5*10^6; % 剩余数据步长, 
dt = 0.05; % 时间步长，
dh = 1e-7; % 信道增益步长，* 10^-3
d = 0:dQ:D; % Q网格
h = hmin:dh:hmax; %信道增益网格
t = 0:dt:T; % 时间网格
Nq = length(d); % 空间网格点数
Nh = length(h); % 信道增益网格点数
Nt = length(t); % 时间网格点数
kmax=1;epsilon=0.001;

global p eta1 rate softmax;
p=0.75;eta1=0.1;
sigma2=1e-13;B=0.7*10^7;
gain=zeros(Nt,1);
mu=1e-6;gain(1)=mu;
% 模拟 Ornstein-Uhlenbeck 过程
for i = 2:Nt
    dW = sqrt(dt) * randn/10^6;       % 随机扰动项
    dX = zeta/2 * (mu - gain(i-1)) * dt + varrho_h * dW;  % 迭代公式
    gain(i) = gain(i-1) + dX;          % 更新信道增益的值
end
rate=B.*log2(1+(gain.^2)./(1e-13+gain.^2));
% plot(t,rate);


%initialize
v_final = zeros(Nq,Nh);
v=zeros(Nt,Nq,Nh);
v_old=zeros(Nt,Nq,Nh);
x_old=zeros(Nt,Nq,Nh);
x_new=zeros(Nt,Nq,Nh);
U1=zeros(Nt,Nq,Nh);
U=zeros(Nt,Nq,Nh); %初始时刻也设为0
m=zeros(Nt,Nq,Nh);
m_0=zeros(Nq,Nh);
softmax=10*10^-8;
vector_1 = 1e7./(1+exp(-softmax*(Qk-d)));
vector_2 = normpdf(d,0.7*10^8,0.1*10^8); %N(\mu,\sigma)
for l = 1 : Nh
    v_final(:,l)=vector_1;
    m_0(:,l) = vector_2;
end
pik=zeros(Nt,1);
pik(:)=3/10;
% pik=linspace(0.8,0.9,Nt);
Lk=zeros(Nt,1);
Lk(:)=2;
Ik=zeros(Nt,1);
Ik(:)=3;
% for n=1:Nt
%     m(n,:,:)=m_0;   
% end
m(1,:,:)=m_0;
for l=1:Nh
    x_old(1,:,l)=linspace(0,0.6,Nq);
end;
trading=zeros(Nt,Nq,Nh);
delay=zeros(Nt,Nq,Nh);
[~,~,U1]=phi_update(m,x_old);
%     figure;
%     [X, Y] = meshgrid(d, t);
%     surf(X,Y,U(:,:,2));
    v_final=U1(1,:,:);
for l=1:Nh
    x_old(1,:,l)=zeros(1,Nq);
end

for k=1:kmax
   v=HJB(x_old,U);
%    x_new=x_update(v);
    x_new=0.7*ones(Nt,Nq,Nh);
   if norm(x_new(:,:,2)-x_old(:,:,2),2) <epsilon %自行实现2阶范数
       break;
   end
%     [X, Y] = meshgrid(d, t);
%     surf(X,Y,x_new(:,:,2));
%     zlabel(x_new);
   disp(norm(x_new(:,:,2)-x_old(:,:,2),2) );
   m=FPK(m_0,x_new);
   [trading,delay,U]=phi_update(m,x_new);
   x_old=x_new;
end
utility(U,x_new,trading,delay);
% density=0
% for q=1:Nq
%     density =density+m(4,q,2)*dQ;
% end
% disp(density);
% figure;
%     [X, Y] = meshgrid(d, t);
%     surf(X,Y,U(:,:,2));
%     title("PDF")