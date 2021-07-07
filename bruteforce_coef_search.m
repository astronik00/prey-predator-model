N = 30;
h = 0.01;
M = 0:h:N;
x = zeros(length(M), 2);
u = zeros(length(M), 1);

x(1,1) = input('Введите численность жертв: ');
x(1,2) = input('Введите численность хищников: ');

alpha2 = 0;
beta1 = 0;
beta2 = 0;
T = 0;
p = 0;
k = 0;

while alpha2 <= 1
    beta1 = 0;
    while beta1 <= 1
        beta2 = 0;
        while beta2 <= 1
            T = 0;
            while T <= 6
                p = 0;
                k = 0;
                while p <= 2
                    for n=1:(length(M) - 1)
                        u(n) = (h*beta1*x(n,1)*x(n,2) + p*(x(n,2) + h*(-alpha2*x(n,2) + beta2*x(n,1)*x(n,2))) - T*(x(n,1) - p*x(n,2)) - x(n,1)) / (h*x(n,1));
                        x(n+1,1) = x(n,1) + h*(u(n)*x(n,1) - beta1*x(n,1)*x(n,2));
                        x(n+1,2) = x(n,2) + h*(-alpha2*x(n,2) + beta2*x(n,1)*x(n,2));

                        if isnan(x(n,1)) || isnan(x(n,2)) 
                            break;
                        end
                        
                        if abs(x(n,1)-p*x(n,2)) < eps && x(n,2) < x(1,2)*1000
                            k=k+1;
                        end              
                    end
                    
                    if ~isnan(x(n,1)) && ~isnan(x(n,2))
                        diff = abs(x(n,1)-p*x(n,2));
                        if (k/(N/h+1) > 0.99 && diff  < eps && x(n,2) < x(1,2)*1000) && T > 0
                            fprintf('Система устойчива\n');
                            fprintf('alpha2 = %d\n', alpha2);
                            fprintf('beta1 = %d\n', beta1);
                            fprintf('beta2 = %d\n', beta2);
                            fprintf('T = %d\n', T);
                            fprintf('po = %d\n', p);
                            %plot(M,x);
                            %hold on
                            %title('Модель хищник-жертва');
                        else
                            %fprintf('Система не устойчива\n');
                        end
                    end
                                       
                    k = 0;
                    p = p + 0.1;
                end
                T = T + 0.1;
            end
            beta2 = beta2 + 0.1;
        end
        beta1 = beta1 + 0.1;
    end
    alpha2 = alpha2 + 0.1;
end
