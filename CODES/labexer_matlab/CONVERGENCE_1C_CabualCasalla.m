% MAIN %
    clc 
    clear
    convergence();

%FUNCTIONS

    function convergence()
        question = 'Is the convergence for Jacobi guaranteed? Why or why not?';
        button = questdlg(question, 'Question', 'Answer', 'Cancel', 'Answer');

        if strcmp(button, 'Answer')
            answer = 'The convergence of the Jacobi method is not always guaranteed. Specifically, the method is guaranteed to converge if the matrix is diagonally dominant. Diagonal dominance means that the absolute value of the diagonal element in each row is greater than the sum of the absolute values of the other elements in that row. Under this condition, the Jacobi method will converge to the solution of the linear system, regardless of the initial guess. However, if the matrix is not diagonally dominant, the solution may still converge, but it is not guaranteed to converge towards the solution. In some cases, the method may diverge instead of converging towards the solution. Therefore, diagonal dominance ensures the convergence of the Jacobi method, but it is not a necessary condition.';
            msgbox(answer, 'Answer');
        end
    end