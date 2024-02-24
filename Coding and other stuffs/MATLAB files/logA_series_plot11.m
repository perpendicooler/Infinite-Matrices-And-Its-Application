function logA_series_plot11(A)
    number_of_terms = 100;
    tolerance = 1e-10;
    matrixSize = randi([4,5]);
    attemptCount = 0;

    while true
        A = generate_diagonal_matrix(matrixSize);  % Function to generate a random diagonal matrix
        if norm(eye(matrixSize) - A) > 1
            attemptCount = attemptCount + 1;
            display('Attempt ' + string(attemptCount) + ': Conditions not met. Trying again...');
        else
            display('Matrix found after ' + string(attemptCount) + ' attempts.');
            display('Matrix A:');
            display(A);
            break;
        end
    end

    display('Original Matrix A:');
    display(A);

    eigenvalues_A = calculate_eigenvalues(A);
    norm_IA = norm(eye(matrixSize) - A);

    display('Eigenvalues of A:');
    display(eigenvalues_A);
    display('Norm of (I-A): ' + string(norm_IA, "%.6f"));

    det_A = calculate_determinant(A);
    det_exp_trace_log_A_series = zeros(1, number_of_terms);
    det_error = zeros(1, number_of_terms);

    figure;

    log_A_series = zeros(size(A));

    for k = 1:number_of_terms
        term = ((-1)^(k+1)) * ((A - eye(size(A)))^k) / k;
        log_A_series = log_A_series + term;

        det_exp_trace_log_A_series(k) = calculate_determinant(exp(trace(log_A_series)));

        det_error(k) = abs(det_A - det_exp_trace_log_A_series(k));

        if det_error(k) < tolerance
            break;
        end

        semilogy(1:k, det_error(1:k), '-o', 'LineWidth', 1.5);
        xlabel('Iteration');
        ylabel('Determinant Error');
        title('Convergence of Determinant Error');
        grid on;
        drawnow;

        pause(0.00005);
    end

    fprintf('Original matrix determinant (up to 10 decimal places): %.10f\n', det_A);
    fprintf('Approximated determinant after %d iterations: %.10f\n', k, det_exp_trace_log_A_series(k));

    final_det_error = abs(det_A - det_exp_trace_log_A_series(k));
    fprintf('Final Determinant Error: %.10f\n', final_det_error);
    display(log_A_series);
end

function result = generate_diagonal_matrix(size)
    % Function to generate a random diagonal matrix
    result = diag(randn(size, 1));
end

function eigenvalues = calculate_eigenvalues(matrix)
    % Function to calculate eigenvalues of a matrix
    eigenvalues = eig(matrix);
end

function determinant = calculate_determinant(matrix)
    % Function to calculate the determinant of a matrix
    determinant = det(matrix);
end
