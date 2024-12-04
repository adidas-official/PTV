% 418.9829d - suma( x_i * sin ( sqrt( abs ( x_i ) ) ) ) pro i = [1,d=2]
function val = f3(x1, x2)
    d = 2;
    s = 418.9829 .* d;
    x = [x1 x2];
    for i=1:d
        s = s - x(i) .* sin(sqrt(abs(x(i))));
    end 
    val = s;
end