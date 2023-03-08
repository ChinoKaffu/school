% Main
    clc
    clear
    format long

    A = [1 1 0;
         1 0 1;
         1 -1 0];
    b = [4;-1;-2];

    % GAUSS JORDAN METHOD %

    fprintf("Now executing GAUSS-JORDAN ELIMINATION\n"); 
    fprintf("1.. ");    pause(1);    
    fprintf("2.. ");    pause(1);    
    fprintf("3.. ");    pause(1);

    [M,x] = gaussjordan(A,b);

%Functions
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