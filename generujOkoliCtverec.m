% Funkce pro generování okolí ve čtvercovém tvaru
function maticeOkoli = generujOkoliCtverec(x1, x2, ns, x1Limits, x2Limits)
    minX1 = max(x1-ns, x1Limits(1)); % levy kraj; vyssi x souradnice mezi levym omezenim x1Limits(1) a zadanym bodem x1 - velikost okoli ns 
    maxX1 = min(x1+ns, x1Limits(2)); % pravy kraj; nizsi x souradnice mezi pravym omezenim x1Limits(2) a zadanym bodem x1 - velikost okoli ns 
    minX2 = max(x2-ns, x2Limits(1)); % dolni kraj; vyssi y souradnice mezi dolnim omezenim x2Limits(1) a zadanym bodem x2 - velikost okoli ns 
    maxX2 = min(x2+ns, x2Limits(2)); % horni kraj; vyssi y souradnice mezi hornim omezenim x2Limits(2) a zadanym bodem x2 - velikost okoli ns 
    
    nh1 = linspace(minX1, maxX1, 8); % Body pro x1
    nh2 = linspace(minX2, maxX2, 8); % Body pro x2
    maticeOkoli = [nh1; nh2]; % Kombinace do matice 2x8
end