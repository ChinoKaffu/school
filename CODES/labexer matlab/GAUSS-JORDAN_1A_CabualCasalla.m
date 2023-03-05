% MAIN %
    clc
    clear
    format long

    % start of user input %
    A = [
        4 -1 -1 0 0 0 0 0;
        -1 4 -1 -1 0 0 0 0;
        0 -1 4 -1 -1 0 0 0;
        0 0 -1 4 -1 -1 0 0;
        0 0 0 -1 4 -1 -1 0;
        0 0 0 0 -1 4 -1 -1;
        0 0 0 0 0 -1 4 -1;
        0 0 0 0 0 0 -1 4;
    ];

    b = [18;18;4;4;26;16;10;32];

    % end of user input %

    % Gauss-Jordan Elimination %
    fprintf("Now executing GAUSS-JORDAN ELIMINATION"); 
    fprintf("1.. ");    pause(1);    
    fprintf("2.. ");    pause(1);    
    fprintf("3.. ");    pause(1);

    [M,x] = gaussjordan(A,b);
    fprintf("\nFinal Augmented matrix M: \n");    disp(array2table(M)); 
    disp(array2table(x,"VariableNames","Solution vector/array x"));

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

        x(:,1) = M(:,9);
    end