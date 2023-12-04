% FPK equation
function m = FPK(m_0,x)
global h d t Nq Nh Nt dQ dt dh zeta varrho_q varrho_h omega_1 omega_2 omega_3 xi pik Lk Qk mean_h;
m=zeros(Nt,Nq,Nh);
m(1,:,:)=m_0;

for n=1:Nt-1
    for q=2:Nq-1
        for l=2:Nh-1
%             if q==Nq-1 && l==2
%                 disp(x(n,q,l));
%                 disp(m(n,q+1,l)-m(n,q,l));
%                 disp(Qk*(omega_1*(1-x(n,q,l))-omega_2*pik(n)+omega_3*xi^Lk(n))*(m(n,q+1,l)-m(n,q,l))/(2*dQ));
% %                 disp(0.5*varrho_q^2*(m(n,q+1,l)-2*m(n,q,l)+m(n,q-1,l))/dQ^2);
%                 disp(n+1)
%             end
            m(n+1,q,l)=m(n,q,l)-...
                dt*zeta/2*(mean_h-h(l))*(m(n,q,l+1)-m(n,q,l))/dh-...
                dt*Qk*(omega_1*(-x(n,q,l))-omega_2*pik(n)+omega_3*xi^Lk(n))*(m(n,q+1,l)-m(n,q,l))/(1*dQ)+...
                 dt*0.5*varrho_h^2*(m(n,q,l+1)-2*m(n,q,l)+m(n,q,l-1))/dh^2;%+...
                 dt*0.5*varrho_q^2*(m(n,q+1,l)-2*m(n,q,l)+m(n,q-1,l))/dQ^2;
%             m(n+1,q,l)=1/4*(m(n,q+1,l)+m(n,q-1,l)+m(n,q,l+1)+m(n,q,l-1))-...
%                 dt*zeta/4*(mean_h-h(l))*(m(n,q,l+1)-m(n,q,l-1))/dh-...
%                 dt*Qk*(omega_1*(1-x(n,q,l))-omega_2*pik(n)+omega_3*xi^Lk(n))*(m(n,q+1,l)-m(n,q-1,l))/(2*dQ)+...
%                  dt*0.5*varrho_h^2*(m(n,q,l+1)-2*m(n,q,l)+m(n,q,l-1))/dh^2+...
%                  dt*0.5*varrho_q^2*(m(n,q+1,l)-2*m(n,q,l)+m(n,q-1,l))/dQ^2;
            if m(n+1,q,l)<0 
                m(n+1,q,l)=0;
           end
         end
    end
%     m(n+1,Nq,:)=(m(n,Nq,:)+m(n+1,Nq-1,:))/2;
end
figure;
cmap = hsv(128);
% 调整颜色的饱和度，将颜色映射中的饱和度分量降低一半
s = cmap(:, 2); % 提取饱和度分量
s = s * 0.5; % 降低饱和度
cmap(:, 2) = s; % 更新饱和度分量
% 第一个子图
% subplot(3, 1, 1);
% 创建索引数组 
cmap_index = [1:128]; 

% 从jet映射采样颜色
% cmap = jet(128); 
cmap= cmap(cmap_index,:);
% 
% % 设置新的颜色映射  
colormap(cmap)
% colormap("hsv");
% n = 64; % 颜色映射长度
% colors = winter(n);
% colors(:, 2:3) = colors(:, 2:3) * 0.5; % 减少饱和度和值
% colormap("jet");       
    [X, Y] = meshgrid(d*10^-6, t);
    surf(X,Y,m(:,:,2)*10^7);
    colorbar;
    % 设置俯视图的仰角为 90 度
%     view(0, 90);

% %     grid on;
% %     grid minor;
% %     mesh(X, Y, m(:,:,2), 'FaceColor', [0.5, 0.5, 0.5]);
%     box on;
%     ax = gca;
%     ax.BoxStyle = 'full';
%     % 减小坐标轴刻度线长度
% tick_length = 0.01; % 设置刻度线长度为 2% 的图形大小
% set(ax, 'TickLength', [tick_length, tick_length])
%     brighten(-200); % 调整亮度因子为负值，调暗颜色
%     title("PDF")
% end