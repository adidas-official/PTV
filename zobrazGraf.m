function zobrazGraf(func, x1Limits, x2Limits, pointsVisited, bestPoint)
    % Vytvoření gridu pro vykreslení funkce
    [x1Grid, x2Grid] = meshgrid(linspace(x1Limits(1), x1Limits(2), 100), linspace(x2Limits(1), x2Limits(2), 100));
    zGrid = arrayfun(func, x1Grid, x2Grid);
    
    % Vykreslení mapy
    figure;
    contourf(x1Grid, x2Grid, zGrid, 20, 'LineColor', 'none');
    hold on;
    colorbar;
    colormap('jet');
    title('Optimalizace funkce');
    xlabel('x1');
    ylabel('x2');
    
    % Vykreslení všech navštívených bodů
    plot(pointsVisited(:, 1), pointsVisited(:, 2), 'wo-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Navštívené body');
    
    % Vykreslení prvního bodu
    plot(pointsVisited(1, 1), pointsVisited(1, 2), 'yo', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'První bod');
    
    % Vykreslení nejlepšího bodu
    plot(bestPoint(1), bestPoint(2), 'go', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Nejlepší bod');       
    
    legend('show');
    hold off;
end
