function maticeOkoli = generujOkoliKruh(x1, x2, ns, x1Limits, x2Limits, potentialSolution)
    % Funkce generuje rovnoměrně rozmístěné body uvnitř kruhu definovaného středem a poloměrem
    
    % Rozdělení poloměru
    r = linspace(0, ns, potentialSolution);

    % Rozdělení kruhu
    theta = linspace(0, 360, potentialSolution);
    
    % Převod na kartézské souřadnice
    nh1 = x1 + r .* cos(theta);
    nh2 = x2 + r .* sin(theta);
    
    % Omezení bodů na limity
    nh1 = min(max(nh1, x1Limits(1)), x1Limits(2));
    nh2 = min(max(nh2, x2Limits(1)), x2Limits(2));

    % Vytvoření mřížky pomocí meshgrid
    [X1, X2] = meshgrid(nh1, nh2);
    
    % Kombinace souřadnic do matice NxN - potentialSolution^2 bodů
    maticeOkoli = [X1(:)'; X2(:)'];
end
