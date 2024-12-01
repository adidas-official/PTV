%{
Start programu

Úvodní parametry pro výpočet získáme od uživatele zavoláním funkce
createMenu()

Proměné potřebné pro spuštění programu:
- selectedFunction: vybraná funkce [f1;f2;f3;f4] - definovené v samostatných souborech
- shape: tvar okolí - čtverec nebo kruh
- x1Limits, x2Limits: okolí je ohraničeno limitem a velikostí
- neighborhoodSize: velikost okolí
- potentialSolutions: počet bodů pro prozkoumání v okolí - je vytvořena
  matice NxN kde N je potentialSolutions, počet bodů na druhou!!
- výsledky se vypisují na terminál a zapisují do souboru vysledky.txt
%}

[selectedFunction, shape, x1Limits, x2Limits, initialValues, neighborhoodSize, potentialSolutions] = menu.createMenu();
optimisation_function = str2func(selectedFunction);

% Otevření souboru pro zápis výsledků
fileID = fopen('vysledky.txt', 'w');

% Bod se souřadnicemi x1 a x2 je středem prvního prohledávaného okolí
x1 = initialValues(1);
x2 = initialValues(2);

% Konstanty
minValue = inf; % Pro sledování minima
bestPoint = []; % Pro uložení bodu s minimální hodnotou
vektor = 0; % Počítadlo vektorů pro zobrazení v tabulce

% Předalokace paměti pro navštívené body
maxIterations = 100; % Předpokládaný maximální počet iterací
pointsVisited = nan(maxIterations, 2); % Matice o velikosti maxIterations x 2
pointsVisited(1, :) = initialValues; % Prni navštívený bod má index 1
visitedIndex = 1; % Index pro přidávání bodů do matice
stredy = nan(maxIterations, 2);
stredIndex = 0;

% Hlavička tabulky
disp('-------------------------------------------------------------');
fprintf(fileID, '-------------------------------------------------------------\n');
fprintf('| %7s | %10s | %10s | %12s | %8s |\n', 'Vektor', 'x1', 'x2', 'f(x1,x2)', 'Iterace');
fprintf(fileID, '| %7s | %10s | %10s | %12s | %8s |\n', 'Vektor', 'x1', 'x2', 'f(x1,x2)', 'Iterace');
disp('-------------------------------------------------------------');
fprintf(fileID, '-------------------------------------------------------------\n');

while true
    % Aktualizace počítadel nutná pro zobrazení ve výpisu a v grafu
    vektor = vektor + 1;
    stredIndex = stredIndex + 1;
    stredy(stredIndex, :) = [x1, x2];
    
    % Generování okolí
    if shape == "Kruh"
        maticeOkoli = generujOkoliKruh(x1, x2, neighborhoodSize, x1Limits, x2Limits, potentialSolutions);
    elseif shape == "Čtverec"
        maticeOkoli = generujOkoliCtverec(x1, x2, neighborhoodSize, x1Limits, x2Limits, potentialSolutions);
    else
        fprintf("Nebyl vybrán tvar okolí\n");
        break;
    end

    iterace = 0; % počítadlo iterací pro zobrazení v tabulce
    % Cyklus pro průchod body matice
    for i = 1:size(maticeOkoli, 2) % Iterace přes body
        currentX1 = maticeOkoli(1, i); % Hodnota x1
        currentX2 = maticeOkoli(2, i); % Hodnota x2
        
        % Kontrola, zda byl bod již navštíven
        if any(ismember(pointsVisited(2:visitedIndex, :), [currentX1, currentX2], 'rows'))
            continue;
        end
        
        % Zavolání optimalizační funkce
        result = optimisation_function(currentX1, currentX2);
        
        iterace = iterace + 1;

        % Výpis aktuálního bodu a výsledku do terminálu
        fprintf('| %7d | %10.4f | %10.4f | %12.4f | %8d |\n', ...
            vektor, currentX1, currentX2, result, iterace);
        
        % Zápis aktuálního bodu a výsledku do souboru
        fprintf(fileID, '| %7d | %10.4f | %10.4f | %12.4f | %8d |\n', ...
            vektor, currentX1, currentX2, result, iterace);
        
        % Aktualizace minima, pokud je nalezena nižší hodnota
        if result < minValue
            minValue = result;
            bestPoint = [currentX1, currentX2];
        end
    end
    
    % Konec iterace bodů jednoho vektoru
    disp('-------------------------------------------------------------');
    fprintf(fileID, '-------------------------------------------------------------\n');
    
    % Kontrola ukončení: pokud je bod s nejnižší hodnotou již navštíven, ukončíme
    if any(ismember(pointsVisited(2:visitedIndex, :), bestPoint, 'rows'))
        fprintf('Nejnižší hodnota %f nalezena v bodě [%f, %f]\n', minValue, bestPoint(1), bestPoint(2));
        fprintf(fileID, 'Nejnižší hodnota %f nalezena v bodě [%f, %f]\n', minValue, bestPoint(1), bestPoint(2));
        break;
    else
        % Přidání bodu do seznamu navštívených bodů
        visitedIndex = visitedIndex + 1;
        pointsVisited(visitedIndex, :) = bestPoint;
    end
    
    % Aktualizace středu pro další iteraci
    x1 = bestPoint(1);
    x2 = bestPoint(2);
    
    % Kontrola: ukončení při dosažení maximálního počtu iterací
    if visitedIndex >= maxIterations
        fprintf('Dosažen maximální počet iterací (%d). Ukončuji.\n', maxIterations);
        fprintf(fileID, 'Dosažen maximální počet iterací (%d). Ukončuji.\n', maxIterations);
        break;
    end
end

% Zavření souboru po ukončení výpočtu
fclose(fileID);

% Odstranění nepoužitých řádků `pointsVisited`
pointsVisited = pointsVisited(1:visitedIndex, :);

% Funkce pro grafické znázornění výstupu
zobrazGraf(optimisation_function, x1Limits, x2Limits, pointsVisited, bestPoint);

% Uložení vygenerovaného grafu do png souboru
outputFileName = 'graf_optimalizace.png';
exportgraphics(gcf, outputFileName, 'Resolution', 300); % Nastavení vyššího rozlišení
fprintf('Graf byl uložen jako "%s" s vysokým rozlišením.\n', outputFileName);

