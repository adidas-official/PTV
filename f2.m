function val = f2(x1, x2)
    d = 2;
    x = [x1 x2];    % definice pole pro prochazeni
    s = 10 .* d;    % pocatecni suma
    for i=1:d       % cyklus prochazeni pole 
        s = s + (x(i)^2 - 10 .* cos(2 .* pi .* x(i)));
    end
    val = s;
end