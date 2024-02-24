    
    function DetLogApproxWithEigenvals()
    number_of_terms = 1000;
    tolerance = 1e-4;  % Set the desired threshold for convergence
    
    if nargin < 1
        matrixSize = 2;
        A = randn(matrixSize);

        % Counter for attempts to generate matrix with positive real eigenvalues
        attemptCount = 1;

        % Keep generating matrices until all eigenvalues are positive real numbers
        while any(imag(eig(A)) ~= 0) || any(eig(A) < 0) || norm(eye(matrixSize) - A) > 1
            A = randn(matrixSize);
            attemptCount = attemptCount + 1;
        end

        fprintf('Generated matrix with positive real eigenvalues and norm(identity - A) < 1 after %d attempts.\n', attemptCount);
    end
    
    % Display the original matrix A
    fprintf('Original Matrix A:\n');
    disp(A);
    
    eigenvalues_A = eig(A);
    p = norm(eye(matrixSize) - A);
    fprintf('Eigenvalues of A:\n');
    disp(eigenvalues_A);
    fprintf('Norm of (I-A): %.6f\n', p);

    % Initialize variables for plotting
   % det_A = det(A);
    
    % Initialize the figure for plotting
    figure;
    
    for eigenIdx = 1:length(eigenvalues_A)
        % Calculate the logarithm using the series expansion
        log_A_series = zeros(size(A));
        eigen_A = eigenvalues_A(eigenIdx);
        
        fprintf('Eigenvalue #%d: %.6f\n', eigenIdx, eigen_A);

        % Initialize variables for plotting
        det_exp_trace_log_A_series = zeros(1, number_of_terms);
        det_error = zeros(1, number_of_terms);

        for k = 1:number_of_terms
            term = ((-1)^(k+1)) * ((A - eigen_A * eye(size(A))-eye(size(A)))^k) / k;
            log_A_series = log_A_series + term;

            % Compare det(A) and det(exp(trace(log_A_series)))
            det_exp_trace_log_A_series(k) = (exp(trace(log_A_series)));

            % Calculate the error
            det_error(k) = abs(det(A - eigen_A * eye(size(A))) - det_exp_trace_log_A_series(k));
            
            if (det_error(k) <= tolerance)
                break
            end

            % Plot the error after each iteration
            subplot(length(eigenvalues_A), 1, eigenIdx);
            semilogy(1:k, det_error(1:k), '-o', 'LineWidth', 1.5);
            xlabel('Iteration');
            ylabel('Determinant Error');
            title(sprintf('Convergence of Determinant Error for Eigenvalue #%d', eigenIdx));

            grid on;
            drawnow;
            pause(0.005);

            
            
        end
        
        fprintf("Determinant of (A - eigenvalue(A) * identity): %.10f\n", det(A - eigen_A * eye(size(A))));
        fprintf("exp(trace(log(A - eigenvalue(A) * identity))): %.10f\n", det(exp(trace(log_A_series - eigen_A * eye(size(A))))));
        fprintf("Final Determinant Error for Eigenvalue #%d: %.10f after %d iteration \n", eigenIdx, det_error(end),k);
    end
end