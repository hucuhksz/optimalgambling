% Choose T
global T; 
T = 2; 
% Input risk aversion/seeking degree
global alphaplus;
alphaplus = 0.95;
global alphaminus;
alphaminus = 0.95;
% Input distortion degree
global deltaplus;
deltaplus = 0.5;
global deltaminus;
deltaminus = 0.5;
% Input loss aversion degree
global lambda 
lambda = 1.5;


%run
%Linear constraints
for n = 1 : T
    Aeq(n) = 1;
end
for n = T+1 : 2*T
    Aeq(n) = -1;
end
beq = 0;

lb = zeros(1,2*T);
ub = ones(1,2*T);

A = zeros(2*T-1,2*T);
for n = 1 : T-1
    A(n,n) = -1;
    A(n,n+1) = 1;
end
A(T,1) = 1;
A(T,T+1) = 1;
for n = T+1 : 2*T-1
    A(n,n) = -1;
    A(n,n+1) = 1;
end
b = zeros(2*T-1,1);
b(T) = 1;








%nonlinear optimization
format long
x0 = zeros(1,2*T);
options = optimoptions(@fmincon,'Algorithm','sqp');
problem = createOptimProblem('fmincon','objective',@valueT,'x0',x0,'Aineq',A,'bineq',b,'Aeq',Aeq,'beq',beq,'lb',lb,'ub',ub,'nonlcon',@nonlcon,'options',options);
ms = MultiStart;
[xstar,fval] = run(ms,problem,10000)





