function [isDiagonalizable, D, P] = check_diagonalizable(matrix)
    % Check if the matrix is square
    [m, n] = size(matrix);
    if m ~= n
        error('Input matrix must be square for diagonalization.');
    end

    % Check diagonalizability
    [P, D] = eig(matrix);
    isDiagonalizable = all(diag(D) == sort(diag(D)));

    % Display the result
    if isDiagonalizable
        disp('The matrix is diagonalizable.');
        disp('Diagonal matrix D:');
        disp(D);
        disp('Invertible matrix P:');
        disp(P);
    else
        disp('The matrix is not diagonalizable.');
        D = [];
        P = [];
    end
end
