function maticeOkoli = generujOkoliKruh(x1, x2, ns, x1Limits, x2Limits, potentialSolution)
    % Funkce generuje rovnoměrně rozmístěné body uvnitř kruhu definovaného středem a poloměrem
    
    numPoints = potentialSolution;
    % Generování bodů v polárních souřadnicích
    r = randn(1, numPoints) * (ns / 2); % Poloměr s normálním rozdělením
    r = abs(r); % Ujistíme se, že vzdálenost je kladná
    r(r > ns) = ns; % Oříznutí na maximální poloměr
    
    theta = rand(1, numPoints) * 2 * pi; % Náhodný úhel v rozsahu 0 až 2*pi
    
    % Převod na kartézské souřadnice
    nh1 = x1 + r .* cos(theta);
    nh2 = x2 + r .* sin(theta);
    
    % Omezení bodů na limity
    nh1 = min(max(nh1, x1Limits(1)), x1Limits(2));
    nh2 = min(max(nh2, x2Limits(1)), x2Limits(2));
    
    % Kombinace souřadnic do matice 2xN
    maticeOkoli = [nh1; nh2];
end
