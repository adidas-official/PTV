[selectedFunction, shape, x1Limits, x2Limits, initialValues, neighborhoodSize] = menu.createMenu();
optimisation_function = str2func(selectedFunction);
x1 = initialValues(1);
x2 = initialValues(2);

% Konstanty
minValue = inf; % Pro sledování minima
bestPoint = []; % Pro uložení bodu s minimální hodnotou

% Vygenerování okolí
if shape == "Kruh"
    maticeOkoli = generujOkoliCtverec(x1, x2, neighborhoodSize, x1Limits, x2Limits);
elseif shape == "Čtverec"
    maticeOkoli = generujOkoliCtverec(x1, x2, neighborhoodSize, x1Limits, x2Limits);
else
    fprintf("Nebyl vybrán tvar okolí");
end

% Cyklus pro průchod body matice
disp('Výsledky optimalizační funkce:');
for i = 1:size(maticeOkoli, 2) % Iterace přes 8 bodů (sloupce matice)
    currentX1 = maticeOkoli(1, i); % Hodnota x1 z 1. řádku
    currentX2 = maticeOkoli(2, i); % Hodnota x2 z 2. řádku
    
    % Zavolání optimalizační funkce s aktuálními body
    result = optimisation_function(currentX1, currentX2);
    
    % Výpis aktuálního bodu a výsledku
    fprintf('Bod [%f, %f] -> Hodnota: %f\n', currentX1, currentX2, result);
    
    % Aktualizace minima, pokud je nalezena nižší hodnota
    if result < minValue
        minValue = result;
        bestPoint = [currentX1, currentX2];
    end
end

% Výpis bodu s nejnižší hodnotou
fprintf('Nejnižší hodnota: %f nalezena v bodě [%f, %f]\n', minValue, bestPoint(1), bestPoint(2));
