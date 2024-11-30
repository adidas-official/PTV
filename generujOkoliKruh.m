function maticeOkoli = generujOkoliKruh(x1, x2, ns, x1Limits, x2Limits)
    % Počet bodů v kruhu
    numPoints = 16; % Nastavení počtu bodů (čím více, tím jemnější rozložení)
    
    % Úhly pro body na kruhu (od 0 do 2*pi)
    angles = linspace(0, 2*pi, numPoints + 1);
    angles = angles(1:end-1); % Poslední úhel je totožný s prvním, odstraníme ho
    
    % Generování souřadnic bodů na kruhu
    nh1 = x1 + ns * cos(angles); % x-souřadnice
    nh2 = x2 + ns * sin(angles); % y-souřadnice
    
    % Ujištění, že body zůstávají v rámci omezení
    nh1 = min(max(nh1, x1Limits(1)), x1Limits(2));
    nh2 = min(max(nh2, x2Limits(1)), x2Limits(2));
    
    % Kombinace souřadnic do matice 2xN
    maticeOkoli = [nh1; nh2];
end