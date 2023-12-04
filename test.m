%test
clear;
% x=-5:0.1:5;
% y=1./(1+exp(-2*x));
% %plot(x,y);
% %a=1; b=2;
% a=[1,2,3];
% b=[2,4,6];
% c=a/b
% 创建数据点
% t = linspace(0, 2*pi, 100);
% x = sin(t);
% y = cos(t);
% z = t;
% 
% % 绘制三维曲线图
% plot3(x, y, z, 'LineWidth', 2);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Three-dimensional Curve');


%------------
% 创建坐标网格
% x = linspace(-5, 5, 100);
% y = linspace(-5, 5, 100);
% [X, Y] = meshgrid(x, y);
% % disp(size(Y))
% % 计算Z值
% Z = sin(sqrt(X.^2 + Y.^2)) ./ (sqrt(X.^2 + Y.^2));
% disp(size(Z))
% % 绘制三维曲面图
% surf(X, Y, Z);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Three-dimensional Surface');

%---------------------
a=[1,2,4,8];
b=log2(a);
c=1*a;
e=[1,2,3,4]/a
d=9e7
f=c+a;
% %%%%%%%%%%%%%%%%%%%
% line=zeros(5);
%line(:)=1;


% d=linspace(0,1,26);
% Qk=1;
% vector_1 = 1./(1+exp(-50*(Qk-d)));
% % plot(d,vector_1)
% 
% a=3-...
%     5-...
%     4;

% 
% [X, Y] = meshgrid(-2:0.1:2, -2:0.1:2);
% Z = X.^2 + Y.^2;
% 
% 绘制 mesh 图，使用不同的 FaceColor 参数值
% figure;
% colormap("hsv");
% colorbar('southoutside');%水平色图
% colorbar;%垂直色图
% colormap(map); %用MAP矩阵映射当前图形的色图。
% colormap('default');  %默认的设置是jet。
% map=colormap; %获得当前色图矩阵。
% colormap(ax,...); %应用色图到ax坐标对应的图形，而非当前图形
% 
% subplot(2, 2, 1);
% mesh(X, Y, Z, 'FaceColor', 'flat');
% title('Flat FaceColor');
% 
% subplot(2, 2, 2);
% mesh(X, Y, Z, 'FaceColor', [0.5, 0.2, 0.2]);
% title('Interpolated FaceColor');
% 
% subplot(2, 2, 3);
% surf(X, Y, Z);
% title('RGB Color');
% colorbar;
% subplot(2, 2, 4);
% mesh(X, Y, Z, 'FaceColor',[0.5,0.2,0.1]);
% title('[0.9,0,0.1]');
% 
% title('Mesh Plot with Different FaceColor');

%--------------------------------------
% 示例数据
% x = randn(100, 1);
% y = randn(100, 1);
% 
% % 绘制散点图
% figure
% scatter(x, y);
% 
% % 添加正方形框架
% % axis equal;
% box on
% % 添加标签和标题
% xlabel('X Axis');
% ylabel('Y Axis');
% title('Scatter Plot with Square Frame');
%-------------------------------------------------------
% % 示例数据
% x = linspace(-10, 10, 100);
% y = x.^2;
% 
% % 自定义颜色映射，减少饱和度和值来弱化颜色渐变
% n = 64; % 颜色映射长度
% colors = hsv(n);
% colors(:, 2:3) = colors(:, 2:3) * 0.5; % 减少饱和度和值
% 
% % 绘制折线图，并设置自定义颜色映射
% colormap(colors);
% plot(x, y);
% 
% % 添加颜色条
% colorbar;
% 
% % 添加标签和标题
% xlabel('X Axis');
% ylabel('Y Axis');
% title('Line Plot with Weakened HSV Colormap');

% 示例数据
[X, Y] = meshgrid(-2:0.1:2, -2:0.1:2);
Z = X.^2 + Y.^2;

% 绘制折线图，使用不同的颜色映射
% 示例数据
[X, Y] = meshgrid(-2:0.1:2);

% 函数1：Z = X^2 + Y^2
Z1 = X.^2 + Y.^2;

% 函数2：Z = sin(X) + cos(Y)
Z2 = sin(X) + cos(Y);

% 函数3：Z = X*Y
Z3 = X .* Y;

% 创建一个图形窗口，并设置子图排列为 3 行 1 列
figure;
cmap = hsv;
% 调整颜色的饱和度，将颜色映射中的饱和度分量降低一半
s = cmap(:, 2); % 提取饱和度分量
s = s * 0.75; % 降低饱和度
cmap(:, 2) = s; % 更新饱和度分量
% 第一个子图
% subplot(3, 1, 1);
surf(X, Y, Z1);
colormap(cmap); % 设置颜色映射为 'hot'
title('Subplot 1: Z = X^2 + Y^2');
colorbar;
% 
% % 第二个子图
% subplot(3, 1, 2);
% surf(X, Y, Z2);
% colormap('cool'); % 设置颜色映射为 'cool'
% title('Subplot 2: Z = sin(X) + cos(Y)');
% 
% % 第三个子图
% subplot(3, 1, 3);
% surf(X, Y, Z3);
% colormap('parula'); % 设置颜色映射为 'parula'
% title('Subplot 3: Z = X * Y');

% 添加整体标题
sgtitle('Surface Plots with Different Colormaps');


% a=rand(3,4);