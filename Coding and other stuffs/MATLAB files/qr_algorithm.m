function computed_eigenvalue = qr_algorithm(A, max_iterations, tolerance)
    % A is the matrix for which eigenvalues are to be found
    % max_iterations is the maximum number of iterations
    % tolerance is the convergence criterion

    n = size(A, 1);
   % computed_eigenvalue = zeros(n, 1);

    for k = 1:max_iterations
        % Apply QR decomposition to the matrix
        [Q, R] = qr(A);

        % Update A with R * Q
        A = R * Q;

        % Check for convergence
        if max(abs(tril(A, -1))) < tolerance
            break;
        end
    end

    % Extract eigenvalues from the diagonal of A
    computed_eigenvalue = diag(A);
end
