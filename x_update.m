% r_update
function x_new=x_update(v)
global omega_4 omega_5 omega_1 Qk Hc eta Nt Nq Nh dQ d t;
x_new = zeros(Nt,Nq,Nh);
%temp=zeros(Nt,Nq,Nh);
% dim=size(r_new);
% disp(dim);
    for n = 1:Nt
        for q = 2:Nq-1
            for l = 1:Nh
%                 x_new(n,q,l)=(omega_4+eta*Qk/(Hc)+Qk*omega_1*(v(n,q,l)-v(n,q-1,l))/(dQ));
                x_new(n,q,l)=-1.25*(omega_4/(2*omega_5)+eta*Qk/(2*Hc*omega_5)+Qk*omega_1*(v(n,q,l)-v(n,q-1,l))/(4*omega_5*dQ));
                if x_new(n,q,l)<0
                    x_new(n,q,l)=0;
                elseif x_new(n,q,l)>1
                    x_new(n,q,l)=1;
                end
                
            end
        end
    end
%     x_new(:,1,:)=x_new(:,2,:);
%     x_new(:,Nq-1,:)=x_new(:,Nq-2,:);
    x_new(:,Nq,:)=x_new(:,Nq-1,:);
%     figure;
%     colormap("hsv");
% n = 64; % 颜色映射长度
% colors = hsv(n);
% colors(:, 2:3) = colors(:, 2:3) * 0.5; % 减少饱和度和值
% colormap(colors);       


%     [X, Y] = meshgrid(1e-6*d(2:41), t);
%     surf(X,Y,x_new(:,2:41,2));
%     xlim([0, 100]);
%         colorbar;
%     grid on;
%     grid minor;
% 
%     box on;
%     ax = gca;
%     ax.BoxStyle = 'full';
%     ylabel("Time");
%     xlabel("Cache");
%     % 减小坐标轴刻度线长度
% tick_length = 0.01; % 设置刻度线长度为 2% 的图形大小
% set(ax, 'TickLength', [tick_length, tick_length])
% %     brighten(-200); % 调整亮度因子为负值，调暗颜色
%     title("PDF")
%     disp(temp);
end

