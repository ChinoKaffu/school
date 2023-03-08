% MAIN %
    clc
    clear
    format long

    % start of user input%
    A = [1 -2;
          2 1];
    b = [-1;3];

    % GAUSS SEIDEL METHOD %
    fprintf("Now executing GAUSS-SEIDEL\n"); 
    fprintf("1.. ");    pause(1);    
    fprintf("2.. ");    pause(1);    
    fprintf("3.. ");    pause(1);

    [M,x] = gaussseidel(A,b);

    disp(array2table(M,"VariableNames",["Iteration","x1","x2"]));
    disp(array2table(x,"VariableNames","Solution vector/array x","RowNames",["x1","x2"]));

    disp("Press any key to continue..."); pause

    fprintf("\nNow executing Convergence Question\n"); 
    fprintf("1.. ");    pause(1);    
    fprintf("2.. ");    pause(1);    
    fprintf("3.. ");    pause(1);
    
    convergence();

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

        function convergence()
        question = 'Does the method converge? Why or why not?';
        button = questdlg(question, 'Question', 'Answer', 'Cancel', 'Answer');

        if strcmp(button, 'Answer')
            answer = 'For the Gauss-Seidel method to converge to a unique solution, a sufficient condition is that the matrix A is diagonally dominant. A matrix is diagonally dominant if the absolute value of each diagonal element is greater than the sum of the absolute values of the other elements in the same row. In the given example, the matrix A = [1 -2; 2 1] is not diagonally dominant, since the absolute value of the diagonal element 1 is not greater than the sum of the absolute values of the other elements in the first row (|-2| + |1| = 3). Therefore, the Gauss-Seidel method may not converge to a unique solution in this case.';
            msgbox(answer, 'Answer');
        end
    end
