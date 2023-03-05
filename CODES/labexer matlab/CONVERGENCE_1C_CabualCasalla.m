% MAIN %
    clc 
    clear
    convergence();

%FUNCTIONS

    function convergence()
        % Display the initial question
        question = 'Is the convergence for Jacobi guaranteed? Why or why not?';
        button = questdlg(question, 'Question', 'Answer', 'Cancel', 'Answer');

        % If the 'Answer' button is clicked, display the answer
        if strcmp(button, 'Answer')
            answer = 'The convergence of the Jacobi method is guaranteed under certain conditions. Specifically, the method is guaranteed to converge if the matrix A is strictly diagonally dominant, which means that the absolute value of the diagonal element in each row is greater than the sum of the absolute values of the other elements in that row. Under this condition, the Jacobi method will converge to the solution of the linear system, regardless of the initial guess. This is because the method involves iteratively updating the solution vector by using the diagonal elements of A, which are guaranteed to be non-zero and therefore invertible. However, if the matrix A is not strictly diagonally dominant, the Jacobi method may not converge. In such cases, other iterative methods such as the Gauss-Seidel method or the successive over-relaxation (SOR) method may be more effective.';
            msgbox(answer, 'Answer');
        end
    end