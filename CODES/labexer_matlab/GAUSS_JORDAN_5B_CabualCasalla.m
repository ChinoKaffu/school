% MAIN %
    clc
    clear
    format long

    % start of user input %
    A = [
        1 1 1;
        4 6 8;
        0.5 0.5 0.25;
    ];

    b = [20;108;46];

    % end of user input 

    % Gauss-Jordan Elimination %
    fprintf("Now executing GAUSS-JORDAN ELIMINATION\n"); 
    fprintf("1.. ");    pause(1);    
    fprintf("2.. ");    pause(1);    
    fprintf("3.. ");    pause(1);

    [M,x] = gaussjordan(A,b);
    fprintf("\nFinal Augmented matrix M: \n");    disp(array2table(M)); 
    disp(array2table(x,"RowNames",["A","B","C"],"VariableNames","Solution vector/array x"));

% FUNCTIONS %
    function [M,x] = gaussjordan(A,b)
        len = length(A);
        M = [A,b];
        x=[];

        for i = 1 : len
            M(i,:) = M(i,:) / M(i,i);
            for j = i+1 : len
                M(j,:) = M(j,:) - M(j,i) * M(i,:);
            end
        end

        for i = len:-1:2
            for j = i-1:-1:1
                M(j, :) = M(j, :) - M(j, i) * M(i, :);
            end
        end

        x(:,1) = M(:,len+1);
    end