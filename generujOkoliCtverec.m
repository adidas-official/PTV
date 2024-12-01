% Funkce pro generování okolí ve čtvercovém tvaru
function maticeOkoli = generujOkoliCtverec(x1, x2, ns, x1Limits, x2Limits, potentialSolution)
    % Definice hranic okolí
    minX1 = max(x1 - ns, x1Limits(1)); % Levý kraj
    maxX1 = min(x1 + ns, x1Limits(2)); % Pravý kraj
    minX2 = max(x2 - ns, x2Limits(1)); % Dolní kraj
    maxX2 = min(x2 + ns, x2Limits(2)); % Horní kraj
    
    % Generování hodnot pro x1 a x2
    nh1 = linspace(minX1, maxX1, potentialSolution); % n rovnoměrně rozmístěných bodů pro x1
    nh2 = linspace(minX2, maxX2, potentialSolution); % n rovnoměrně rozmístěných bodů pro x2
    
    % Vytvoření mřížky pomocí meshgrid
    [X1, X2] = meshgrid(nh1, nh2);
    
    % Kombinace souřadnic do matice NxN - potentialSolution^2 bodů
    maticeOkoli = [X1(:)'; X2(:)'];
end
