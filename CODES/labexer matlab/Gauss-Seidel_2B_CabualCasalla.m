% MAIN %
    clc
    clear
    format long

    % start of user input%
    A = [-4 5;
          1 2];
    b = [18;3];

    % GAUSS SEIDEL METHOD %
    fprintf("Now executing GAUSS SEIDEL\n"); 
    fprintf("1.. ");    pause(1);    
    fprintf("2.. ");    pause(1);    
    fprintf("3.. ");    pause(1);

    [M,x] = gaussseidel(A,b);

    disp(array2table(M,"VariableNames",["Iteration","x1","x2"]));
    disp(array2table(x,"VariableNames","Solution vector/array x"));

% FUNCTIONS %
    function [M,x] = gaussseidel(A,b)
        M = [];
        
        size = (length(A));
        xk = zeros(size, 1); %initial guess
        
        temp = diag(A);
        D = zeros(size);
        for i = 1:size
            D(i,i) = temp(i,:);
        end

        L = tril(A,-1);
        U = triu(A,1);
        Ts = -inv(L+D)*U;
        Cs = inv(L+D)*b; %#ok<MINV> 

        iter = 0;

        M(iter+1,:) = [iter, xk'];

        % const finish%

        for i = 1:100
            iter = iter + 1;
            xk1 = (Ts*xk)+Cs;
            if(norm(xk-xk1)<10^-6), break; end
            M(iter+1,:) = [iter, xk1'];
            xk = xk1;
        end

        x = xk1;
    end