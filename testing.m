N = 100;
h = 0.001;
M = 0:h:N;
x = zeros(length(M), 2);
u = zeros(length(M), 1);
 
x(1,1) = input('Введите численность жертв: ');
x(1,2) = input('Введите численность хищников: ');
T = input('Введите T: ');
p = input('Введите пропорциональность: ');
alpha2 = input('Введите коэффициент альфа2: ');
beta1 = input('Введите коэффициент бета1: ');
beta2 = input('Введите коэффициент бета2: ');
k=0;
eps=0.1;
 
for n=1:(length(M) - 1)
    u(n) = (h*beta1*x(n,1)*x(n,2) + p*(x(n,2) + h*(-alpha2*x(n,2) + beta2*x(n,1)*x(n,2))) - T*(x(n,1) - p*x(n,2)) - x(n,1)) / (h*x(n,1));
    x(n+1,1) = x(n,1) + h*(u(n)*x(n,1) - beta1*x(n,1)*x(n,2));
    x(n+1,2) = x(n,2) + h*(-alpha2*x(n,2) + beta2*x(n,1)*x(n,2));
    
    diff = abs(x(n,1)-p*x(n,2));
    
    if diff < eps && x(n,2) < x(1,2)*1000
        k=k+1;
    end
end
 
if k/(N/h+1)>0.98
    fprintf('Система устойчива\n');
else
    fprintf('Система не устойчива\n');
end

plot(M,x);
legend('Жертва', 'Хищник');
title('Модель хищник-жертва');
