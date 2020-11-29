function [valueT] = valueT(x)   %Preference value of a given distribution

global alphaplus;
global alphaminus;
global deltaplus;
global deltaminus;
global lambda;
%x(1) = prob(S_\tau > = 1), x(2) = prob(S_\tau > = 2), x(3) = prob(S_\tau > = 3), x(4) = prob(S_\tau > = 4), x(5) = prob(S_\tau > = 5)
%x(6) = prob(S_\tau < = -1), x(7) = prob(S_\tau < = -2), x(8) = prob(S_\tau < = -3), x(9) = prob(S_\tau < = -4), x(10) = prob(S_\tau < = -5) 

global T; 

valueplus = 0;
valueminus = 0;
for n = 1 : T
valueplus = valueplus + (n.^alphaplus-(n-1).^alphaplus).*w(deltaplus,x(n));
valueminus = valueminus + (n.^alphaminus-(n-1).^alphaminus).*w(deltaminus,x(n+T));
end

valueT = -(valueplus - lambda.*valueminus);

end

function [w] = w(delta,x)

w = x.^delta./(x.^delta+(1-x).^delta).^(1./delta);

end