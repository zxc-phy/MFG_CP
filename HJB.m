%HJB方程
%dh没有用到
function v = HJB(x_old, U)
    global zeta varrho_q varrho_h omega_1 omega_2 omega_3 xi pik Lk Qk v_final...
        mean_h d h t Nq Nh Nt dQ dt dh;
    v= zeros(Nt,Nq,Nh);
    v(Nt,:,:)=v_final; %还未对其
    for n = Nt-1:-1:1
%         disp(n);
        for q = 2:Nq-1
            for l = 2:Nh-1
%                 if q==Nq
%                    v(n,q,l) = v(n+1,q,l)+...
%                     dt*(U(n,q,l)+Qk*(omega_1*(-x_old(n,q,l))-omega_2*pik(n)+omega_3*xi^Lk(n))*(v(n+1,q,l)-v(n+1,q-1,l))/dQ+...
%                     zeta/2*(mean_h-h(l))*(v(n+1,q,l+1)-v(n+1,q,l))/dh +...
%                     0.5*varrho_h^2*(v(n+1,q,l+1)-2*v(n+1,q,l)+v(n+1,q,l-1))/dh^2);
% %                     0.5*varrho_q^2*(v(n+1,q+1,l)-2*v(n+1,q,l)+v(n+1,q-1,l))/dQ^2)
%                 else
                 v(n,q,l) = v(n+1,q,l)+...
                    dt*(U(n,q,l)+Qk*(omega_1*(-x_old(n,q,l))-omega_2*pik(n)+omega_3*xi^Lk(n))*(v(n+1,q+1,l)-v(n+1,q,l))/(dQ)+...
                    zeta/2*(mean_h-h(l))*(v(n+1,q,l+1)-v(n+1,q,l))/dh +...
                    0.5*varrho_h^2*(v(n+1,q,l+1)-2*v(n+1,q,l)+v(n+1,q,l-1))/dh^2+...
                    0.5*varrho_q^2*(v(n+1,q+1,l)-2*v(n+1,q,l)+v(n+1,q-1,l))/dQ^2);
%                 end
            end
        end
        v(n,Nq,:)=v(n+1,Nq,:)-2/3*(v(n+1,Nq-1,:)-v(n,Nq-1,:));
          v(n,1,:)=v(n,2,:);
    end
%     v(:,Nq,:)=v(:,Nq-1,:); %平滑处理
%     v(:,1,:)=v(:,2,:);
    
    %v(Nt,:)=[];
    %plot3(t,d,v(:,:,2));
%     figure;
%     [X, Y] = meshgrid(d, t);
%     surf(X,Y,v(:,:,2));
%     disp(size(Y));
%     disp(size(v(:,:,2)));
end
% function v = HJB(r_old, C,v_old)
%     global sigma_b alpha d h t Nq Nh Nt dQ dt dh v_final m_0;
%     v= zeros(Nt+1,Nq,Nh+1);
%     v(Nt+1,:)=v_final; %还未对qi
%     for n = Nt:1
%         for q = 2:Nq
%             for l = 2:Nh
%             v(n,q,l)=(v(n+1,q,l)+r(n,q,l)*dt/dQ*v_old(n,q-1,l)+sigma_b^2*dt/(2*dh^2)*v_old(n,q,l-1)...
%                 dt*(alpha(n)/dh+sigma_b^2/(2*dh^2))*v_old(n,q,l+1)+dt*C(n,q,l));
%             end
%         end
%     end
% end