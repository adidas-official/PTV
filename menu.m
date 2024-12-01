classdef menu
    methods(Static)
        function [selectedFunction, shape, x1Limits, x2Limits, initialValues, neighborhoodSize, potentialSolutions] = createMenu()
            % Vytvoření hlavního okna (GUI)
            fig = uifigure('Name', 'Heuristická optimalizace', 'Position', [0 200 400 600]);
        
            % Globální proměnné pro uložení hodnot
            selectedFunction = '';
            shape = '';
            x1Limits = [0, 0];
            x2Limits = [0, 0];
            initialValues = [];
            neighborhoodSize = 0;
            potentialSolutions = 0; % Nová proměnná
        
            % Popisek
            uilabel(fig, ...
                'Text', 'Vítejte v programu pro optimalizaci', ...
                'Position', [50 550 300 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 14);
        
            % Dropdown menu: Výběr funkce
            uilabel(fig, ...
                'Text', 'Vyberte optimalizační funkci:', ...
                'Position', [100 510 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
            
            dropdownFun = uidropdown(fig, ...
                'Items', {'f1', 'f2', 'f3', 'f4'}, ...
                'Position', [100 480 200 30]);
        
            % Dropdown menu: Výběr tvaru okolí
            uilabel(fig, ...
                'Text', 'Vyberte tvar okolí:', ...
                'Position', [100 450 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
            
            dropdownShape = uidropdown(fig, ...
                'Items', {'Kruh', 'Čtverec'}, ...
                'Position', [100 420 200 30]);
        
            % Definice omezení pro x1
            uilabel(fig, ...
                'Text', 'Omezení pro x1 [min, max]:', ...
                'Position', [100 390 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            x1Field = uieditfield(fig, 'text', ...
                'Position', [100 360 200 30], ...
                'Placeholder', 'např. 0, 10');
        
            % Definice omezení pro x2
            uilabel(fig, ...
                'Text', 'Omezení pro x2 [min, max]:', ...
                'Position', [100 330 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            x2Field = uieditfield(fig, 'text', ...
                'Position', [100 300 200 30], ...
                'Placeholder', 'např. -5, 5');
        
            % Zadání počátečních hodnot
            uilabel(fig, ...
                'Text', 'Počáteční hodnoty [x1, x2]:', ...
                'Position', [100 270 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            initialField = uieditfield(fig, 'text', ...
                'Position', [100 240 200 30], ...
                'Placeholder', 'např. 1, 2');
        
            % Zadání velikosti okolí
            uilabel(fig, ...
                'Text', 'Velikost okolí:', ...
                'Position', [100 210 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            neighborhoodField = uieditfield(fig, 'numeric', ...
                'Position', [100 180 200 30]);

            % Zadání počtu potenciálních řešení
            uilabel(fig, ...
                'Text', 'Počet potenciálních řešení:', ...
                'Position', [100 150 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            solutionsField = uieditfield(fig, 'numeric', ...
                'Position', [100 120 200 30], ...
                'Limits', [1 Inf], ...
                'RoundFractionalValues', true);
        
            % Tlačítko pro potvrzení výběru
            btnConfirm = uibutton(fig, ...
                'Text', 'Potvrdit výběr', ...
                'Position', [100 70 200 40], ...
                'ButtonPushedFcn', @(btn, event) confirmSelection());
        
            % Funkce pro potvrzení výběru
            function confirmSelection()
                selectedFunction = dropdownFun.Value;
                if isempty(x1Field.Value)
                    fprintf("Zadejte hodnoty pro omezení x1\n");
                elseif isempty(x2Field.Value)
                    fprintf("Zadejte hodnoty pro omezení x2\n");
                elseif isempty(initialField.Value)
                    fprintf("Zadejte počáteční hodnoty\n");
                elseif neighborhoodField.Value < 1
                    fprintf("Zadejte velikost okolí > 0\n");
                elseif solutionsField.Value < 1
                    fprintf("Počet potenciálních řešení musí být kladné číslo\n");
                else
                    shape = dropdownShape.Value;
            
                    % Zpracování omezení x1
                    x1Str = strsplit(x1Field.Value, ',');
                    x1Limits = str2double(x1Str);
            
                    % Zpracování omezení x2
                    x2Str = strsplit(x2Field.Value, ',');
                    x2Limits = str2double(x2Str);          
            
                    % Zpracování počátečních hodnot
                    initialStr = strsplit(initialField.Value, ',');
                    initialValues = str2double(initialStr);

                    % Zpracování velikosti okolí a počtu řešení
                    neighborhoodSize = neighborhoodField.Value;
                    potentialSolutions = solutionsField.Value;
                
                    % Zavření okna
                    close(fig);
                end
            end
        
            % Čekej, dokud uživatel nevyplní všechny hodnoty
            uiwait(fig);
        end
    end
end
