function determinantApproximationForEigenvalues(A)
    % Function to approximate the determinant for multiple eigenvalues using series expansion

    % Parameters
    number_of_terms = 1000;
    tolerance = 1e-10;

    % Initialize matrix and attempt counter
    matrixSize = 7;
    attemptCount = 0;

    while true
        % Generate a random diagonal matrix
      A = [1.2000, -0.0200, -0.1200, -0.0600, -0.0800, -0.0030, -0.0050;
    -0.0800, 0.9997, -0.0030, -0.0400, -0.0200, -0.0070, -0.0060;
    -0.0100, -0.0100, 0.9997, -0.0060, -0.0070, -0.0040, -0.0006;
    -0.0300, -0.0100, -0.0200, 0.9994, -0.0200, -0.0500, -0.0700;
    -0.0300, -0.2141, -0.0007, -0.0942, 0.9999, -0.0009, -0.0001;
    -0.0800, -0.0120, -0.0004, -0.0009, -0.9890, 0.9994, -0.0005;
    -0.0300, -0.0010, -0.0050, -0.0020, 0, -0.3000, 0.9998];


        % Check conditions for convergence
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

    % Display norm of (I-A)
    fprintf('Norm of (I-A): %.6f\n', norm(eye(matrixSize) - A));

    for eigenIdx = 1:length(eig(A))
        % Calculate the logarithm using the series expansion
        log_A_series = zeros(size(A));
        eigen_A = eig(A);

        fprintf('Eigenvalue #%d: %.6f\n', eigenIdx, eigen_A(eigenIdx));

        % Initialize variables for plotting
        det_exp_trace_log_A_series = zeros(1, number_of_terms);
        det_error = zeros(1, number_of_terms);

        % Create a new figure for each eigenvalue
        figure;

        for k = 1:number_of_terms
            term = ((-1)^(k+1)) * ((A - eigen_A(eigenIdx) * eye(size(A)) - eye(size(A)))^k) / k;
            log_A_series = log_A_series + term;

            % Compare det(A) and det(exp(trace(log_A_series)))
            det_exp_trace_log_A_series(k) = exp(trace(log_A_series));

            % Calculate the error
            det_error(k) = abs(det(A - eigen_A(eigenIdx) * eye(size(A))) - det_exp_trace_log_A_series(k));

            % Break the loop if the error is below tolerance
            if det_error(k) <= tolerance
                break;
            end
        end

        % Display the final determinant error
        fprintf("Final Determinant Error for Eigenvalue #%d: %.10f\n", eigenIdx, det_error(k));

        % Plot the error after each iteration
        semilogy(1:k, det_error(1:k), '-o', 'LineWidth', 1.5);
        xlabel('Iteration');
        ylabel('Determinant Error');
        title(sprintf('Convergence of Determinant Error for Eigenvalue #%d', eigenIdx));
        grid on;
    end
end
