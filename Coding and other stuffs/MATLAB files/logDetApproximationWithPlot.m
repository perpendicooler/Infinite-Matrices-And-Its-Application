% Source code for the Determinant Approximation algorithm

function logDetApproximationWithPlot()
    % logDetApproximationWithPlot: Approximates determinant using series expansion
    % and plots the convergence of determinant error.

    % Parameters
    number_of_terms = 100;
    tolerance = 1e-10;
    
    % Matrix generation
    matrixSize = randi([4, 5]);
    attemptCount = 0;

    % Generate a matrix meeting specific conditions
    while true
        A = diag(randn(matrixSize, 1));
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

    % Display the original matrix A
    disp('Original Matrix A:');
    disp(A);

    % Eigenvalues and matrix norm
    eigenvalues_A = eig(A);
    p = norm(eye(matrixSize) - A);
    fprintf('Eigenvalues of A:\n');
    disp(eigenvalues_A);
    fprintf('Norm of (I-A): %.6f\n', p);

    % Initialize variables for plotting
    det_A = det(A);
    det_exp_trace_log_A_series = zeros(1, number_of_terms);
    det_error = zeros(1, number_of_terms);

    % Initialize the figure for plotting
    figure;

    % Calculate the logarithm using the series expansion
    log_A_series = zeros(size(A));

    % Main loop for series expansion and determinant approximation
    for k = 1:number_of_terms
        term = ((-1)^(k+1)) * ((A - eye(size(A)))^k) / k;
        log_A_series = log_A_series + term;

        % Compare det(A) and det(exp(trace(log_A_series)))
        det_exp_trace_log_A_series(k) = det(exp(trace(log_A_series)));

        % Calculate the error
        det_error(k) = abs(det_A - det_exp_trace_log_A_series(k));

        % Check for convergence
        if det_error(k) < tolerance
            break
        end

        % Plot the error after each iteration
        semilogy(1:k, det_error(1:k), '-o', 'LineWidth', 1.5);
        xlabel('Iteration');
        ylabel('Determinant Error');
        title('Convergence of Determinant Error');
        grid on;
        drawnow;

        % Pause for a short duration to allow for visualization
        pause(0.00005);
    end

    % Display results and final error
    fprintf("Original matrix determinant (up to 10 decimal places): %.10f\n", det_A);
    fprintf("Approximated determinant after %d iterations: %.10f\n", k, det(exp(trace(log_A_series))));
    fprintf("Final Determinant Error: %.10f\n", det_error(k));
    disp(log_A_series);
end