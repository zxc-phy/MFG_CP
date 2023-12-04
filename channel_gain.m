% 定义参数
clear;
theta = 0.5;   % 回复力强度
mu = 1e-6;       % 均衡点
sigma = 0.1;  % 扰动项标准差
T = 10;       % 时间长度
dt = 0.1;    % 时间步长

% 初始化变量
t = 0:dt:T;                     % 时间向量
N = length(t);                  % 时间步数
X = zeros(1, N);                % 用于存储信道增益的变化
X(1) = mu*0.5;                      % 初始值

% 模拟 Ornstein-Uhlenbeck 过程
for i = 2:N
    dW = sqrt(dt) * randn/10^7;       % 随机扰动项
    dX = theta * (mu * 0.3 - X(i-1)) * dt + sigma * dW;  % 迭代公式
    X(i) = X(i-1) + dX;          % 更新信道增益的值
end


% % 绘制图形
% plot(t, X,'-.*');
% xlabel('时间');
% ylabel('信道增益');
% hold on;
% % sigma=0.3;
% for i = 2:N
%     dW = sqrt(dt) * randn/10^7;       % 随机扰动项
%     dX = theta * (mu*0.4 - X(i-1)) * dt + sigma * dW;  % 迭代公式
%     X(i) = X(i-1) + dX;          % 更新信道增益的值
% end
% plot(t, X,':s');
% % sigma=0.5;
% for i = 2:N
%     dW = sqrt(dt) * randn/10^7;       % 随机扰动项
%     dX = theta * (mu*0.5 - X(i-1)) * dt + sigma * dW;  % 迭代公式
%     X(i) = X(i-1) + dX;          % 更新信道增益的值
% end
% plot(t, X,'-.>');
% title('Ornstein-Uhlenbeck 过程');
X = X';