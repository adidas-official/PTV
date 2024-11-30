% menu.m
% Vytvori uzivatelske rozhrani, ve kterem uzivatel vybere funkci a zada potrebne hodnoty
% Zadane hodnoty jsou overeny a musi splnovat specificke podminky

classdef menu
    methods(Static)
        function [selectedFunction, shape, x1Limits, x2Limits, initialValues, neighborhoodSize] = createMenu()
            % Vytvoření hlavního okna (GUI)
            fig = uifigure('Name', 'Heuristická optimalizace', 'Position', [0 200 400 550]);
        
            % Globální proměnné pro uložení hodnot
            selectedFunction = '';
            shape = '';
            x1Limits = [0, 0];
            x2Limits = [0, 0];
            initialValues = [];
            neighborhoodSize = 0;
        
            % Popisek
            uilabel(fig, ...
                'Text', 'Vítejte v programu pro optimalizaci', ...
                'Position', [50 500 300 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 14);
        
            % Dropdown menu: Výběr funkce
            uilabel(fig, ...
                'Text', 'Vyberte optimalizační funkci:', ...
                'Position', [100 460 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
            
            dropdownFun = uidropdown(fig, ...
                'Items', {'f1', 'f2', 'f3', 'f4'}, ...
                'Position', [100 430 200 30]);
        
            % Dropdown menu: Výběr tvaru okolí
            uilabel(fig, ...
                'Text', 'Vyberte tvar okolí:', ...
                'Position', [100 400 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
            
            dropdownShape = uidropdown(fig, ...
                'Items', {'Kruh', 'Čtverec'}, ...
                'Position', [100 370 200 30]);
        
            % Definice omezení pro x1
            uilabel(fig, ...
                'Text', 'Omezení pro x1 [min, max]:', ...
                'Position', [100 340 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            x1Field = uieditfield(fig, 'text', ...
                'Position', [100 310 200 30], ...
                'Placeholder', 'např. 0, 10');
        
            % Definice omezení pro x2
            uilabel(fig, ...
                'Text', 'Omezení pro x2 [min, max]:', ...
                'Position', [100 280 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            x2Field = uieditfield(fig, 'text', ...
                'Position', [100 250 200 30], ...
                'Placeholder', 'např. -5, 5');
        
            % Zadání počátečních hodnot
            uilabel(fig, ...
                'Text', 'Počáteční hodnoty [x1, x2]:', ...
                'Position', [100 220 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            initialField = uieditfield(fig, 'text', ...
                'Position', [100 190 200 30], ...
                'Placeholder', 'např. 1, 2');
        
            % Zadání velikosti okolí
            uilabel(fig, ...
                'Text', 'Velikost okolí:', ...
                'Position', [100 160 200 30], ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 12);
        
            neighborhoodField = uieditfield(fig, 'numeric', ...
                'Position', [100 130 200 30]);
        
            % Tlačítko pro potvrzení výběru
            btnConfirm = uibutton(fig, ...
                'Text', 'Potvrdit výběr', ...
                'Position', [100 70 200 40], ...
                'ButtonPushedFcn', @(btn, event) confirmSelection());
        
            % Funkce pro potvrzení výběru
            % Pro spusteni procesu je potreba zadat spravne hodnoty
            % Podminky:
            %   - omezeni funkce x1 musi byt zadano
            %   - omezeni funkce x2 musi byt zadano
            %   - pocatecni hodnoty musi byt zadany
            %   - hodnota velikosti okoli musi byt kladne cislo
            function confirmSelection()
                selectedFunction = dropdownFun.Value;
                if isempty(x1Field.Value)
                    fprintf("Zadejte hodnoty pro omezeni x1\n");
                elseif isempty(x2Field.Value)
                    fprintf("Zadejte hodnoty pro omezeni x2\n");
                elseif isempty(initialField.Value)
                    fprintf("Zadejte pocatecni hodnoty\n");
                elseif neighborhoodField.Value < 1
                    fprintf("Zadejte velikost minima > 0\n");
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

                    if initialValues(1) > x1Limits(1) && initialValues(1) < x1Limits(2) && initialValues(2) > x2Limits(1) && initialValues(2) < x2Limits(2)
                    
                        % Zpracování velikosti okolí
                        neighborhoodSize = neighborhoodField.Value;
                
                        % Zavření okna
                        close(fig);
                    else
                        fprintf("Vybraný bod je mimo definovanou oblast.\n");
                    end
                end
            end
        
            % Čekej, dokud uživatel nevyplní všechny hodnoty
            uiwait(fig);
        end
    end
end