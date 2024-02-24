function logA_series_plot()
    number_of_terms = 1000;
    tolerance = 1e-10;  % Set the desired threshold for convergence
    %iteration_limit = 500;  % Set an upper limit on iterations to avoid an infinite loop
    
    if nargin < 1
        matrixSize = randi([3, 4]);
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
    disp('Original Matrix A:');
    disp(A);
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
    
    for k = 1:number_of_terms
        term = ((-1)^(k+1)) * ((A - eye(size(A)))^k) / k;
        log_A_series = log_A_series + term;
        
        % Compare det(A) and det(exp(trace(log_A_series)))
        det_exp_trace_log_A_series(k) = det(exp(trace(log_A_series)));
        
        % Calculate the error
        det_error(k) = abs(det_A - det_exp_trace_log_A_series(k));
       if (det_error(k) < tolerance)
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
        pause(0.0005);
    end
    
    fprintf("Original matrix determinant (up to 10 decimal places): %.10f\n", det_A);
    fprintf("Approximated determinant after %d iterations: %.10f\n", k, det(exp(trace(log_A_series))));
    
    % Count the final error
    final_det_error = abs(det_A - det(exp(trace(log_A_series))));
    fprintf("Final Determinant Error: %.10f\n", final_det_error);
    disp(log_A_series)
end
