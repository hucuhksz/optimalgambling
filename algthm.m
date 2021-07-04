function[tau] = algthm(x,T)


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

U = zeros(T,2*T+3);
for n = 1 : T
    for z = 1 : 2*T + 3
        U(n,z) = abs(z-T-2);
    end
end






tau = zeros(3,2*T+3);

U(1,1) = T+1;
for z = 2 : 2*T + 2
    U(1,z) = min((U0(z+1) + U0(z-1))./2, Umu(z));
end
U(1,2*T+3) = T+1;

z = T+2;
if tau(1,z) == 0
    if U(1,z) >= Umu(z)
        tau(2,z) = 0; %tau(2,) boundary time %tau(2,2) --> -T, tau(2,3) --> -(T-1)... tau(2,2*T+1) --> T-1, tau(2,2*T+2) --> T
        tau(3,z) = ((U0(z+1) + U0(z-1))./2 - Umu(z))./((U0(z+1) + U0(z-1))./2-U0(z)); %tau(3,): stop probability
        tau(1,z) = 1; %tau(1,) = 1 then Umu value achieved
    end
end

for n = 2 : T
    U(n,1) = T+1;
    for z = 2 : 2*T+2
        U(n,z) = min((U(n-1,z+1) + U(n-1, z-1))./2, Umu(z));
    end
    U(n,2*T+3) = T+1;
    for z = -(n-1)+T+2 : 2 : (n-1)+T+2
        if tau(1,z) == 0
            if U(n,z) >= Umu(z)
                tau(2,z) = n-1;
                if (U(n-1,z+1) + U(n-1,z-1))./2 == U(n-1,z)
                    tau(3,z) = 1;
                else
                    tau(3,z) = ((U(n-1,z+1) + U(n-1,z-1))./2 - Umu(z))./((U(n-1,z+1) + U(n-1,z-1))./2-U(n-1,z));
                end
                tau(1,z) = 1;
            end
        end    
    end 
end

end


