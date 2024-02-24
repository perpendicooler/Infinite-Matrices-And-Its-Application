function newton_raphson(A, max_iterations, tolerance)
    
    n = size(A, 1); % Get the size of the matrix
    initial_guess = 1e-6 * rand(1, n) + 1e-7; % Random number between 1e-7 and 1e-6
    computed_eigenvalues = zeros(max_iterations, n);

    for i = 1:n
        lambda = initial_guess(i);

        for k = 1:max_iterations
            f = det(A - lambda * eye(size(A)));
            f_prime = trace(inv(A - lambda * eye(size(A))));
            
            lambda = lambda - f / f_prime;
            
            computed_eigenvalues(k, i) = lambda;

            if abs(f) < tolerance
                computed_eigenvalues = computed_eigenvalues(1:k, :);
                break;
            end
        end
    end
end
