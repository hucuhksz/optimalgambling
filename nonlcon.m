function [c,ceq] = nonlcon(x)   %Nonlinear constraints

global T;


for z = 1 : T
    cx(z) = x(z);
    cy(z) = x(z+T);
end

Umu(1) = T+1;
Umu(2) = T;
for z = 3 : 2*T+1
    if z < T+2
        Umu(z) = 2*sum(cy(T+2-z+1:T))+abs(z-T-2);
    elseif z == T+2
        Umu(z) = 2*sum(cy(1:T));
    elseif z > T+2
        Umu(z) = 2*sum(cx(z-T-2+1:T))+abs(z-T-2);
    end
end
Umu(2*T+2) = T;
Umu(2*T+3) = T+1;


for z = 1 : 2*T + 3
    U0(z) = abs(z-T-2);
end

U(1,1) = T+1;
for z = 2 : 2*T + 2
    U(1,z) = min((U0(z+1) + U0(z-1))./2, Umu(z));
end
U(1,2*T+3) = T+1;


for n = 2 : T
    U(n,1) = T+1;
    for z = 2 : 2*T+2
        U(n,z) = min((U(n-1,z+1) + U(n-1, z-1))./2, Umu(z));
    end
    U(n,2*T+3) = T+1;
end

c = zeros(1,2*T+3);

for z = 4 : 2 : 2*T
    c(z) = Umu(z) - (U(T-1,z+1)+ U(T-1, z-1))./2;
end

ceq = 0;


end