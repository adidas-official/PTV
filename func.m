% func.m
% zde jsou definovany funkce, ze kterych muze uzivatel vybirat

% Globalni hodnota promenne d
d = 2;

% Funkce f1
function val = f1(x1, x2)
    % suma mocnin x1 a x2
    val = sum(x1^2 + x2^2);      
end

% Funkce f2
function val = f2(x1, x2, d)
    
    x = [x1 x2];    % definice pole pro prochazeni
    s = 10 .* d;    % pocatecni suma
    for i=1:d       % cyklus prochazeni pole 
        s = s + (x(i)^2 - 10 .* cos(2 .* pi .* x(i)));
    end
    val = s;
end

% Funkce f3
function val = f3(x1, x2, d)
    s = 418.9829 .* d;
    x = [x1 x2];
    for i=1:d
        s = s - x(i) .* sin(sqrt(abs(x(i))));
    end 
    val = s;
end

% Funkce f4
function val = f4(x1, x2)  
    val = 20 .* sin(pi * x1/2) .* cos(pi .* x2/2 - 0.5) + (x1 - 1)^2 + (x2 - 1)^2 + 50;
end


%f1(2,5)
%f2(1,1,d)
%f3(2,5,d)
%f4(1,2)