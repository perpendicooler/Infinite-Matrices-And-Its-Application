function random_2()
    % Set parameters
    number_of_terms = 100;
    tolerance = 1e-10;
    matrixSize = randi([2, 3]);
    attemptCount = 0;

    % Generate a matrix meeting the conditions
    while true
        A = randn(matrixSize);
        if norm(eye(matrixSize) - A) > 1
            attemptCount = attemptCount + 1;
            disp(['Attempt ', num2str(attemptCount), ': Conditions not met. Trying again...']);
        else
            disp(['Matrix found after ', num2str(attemptCount), ' attempts.']);
            disp('Matrix A:');
            disp(A);
            break;
        end
    end

    % Apply Newton-Raphson method
    n = size(A, 1);
    initial_guess = 1e-6 * rand(1, n) + 1e-7;
    computed_eigenvalues = zeros(number_of_terms, n);

    for i = 1:n
        lambda = initial_guess(i);

        for k = 1:number_of_terms
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
