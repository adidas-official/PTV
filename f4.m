function val = f4(x1, x2)  
    val = 20 .* sin(pi * x1/2) .* cos(pi .* x2/2 - 0.5) + (x1 - 1)^2 + (x2 - 1)^2 + 50;
end
