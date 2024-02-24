function Matrics_trace(A)
    
    if nargin < 1
        matrixSize = randi([4, 5]);
        A = randn(matrixSize);
        
        % Counter for attempts to generate matrix with positive real eigenvalues
        attemptCount = 1;
        
        % Keep generating matrices until all eigenvalues are positive real numbers
        while any(imag(eig(A)) ~= 0) || any(eig(A) <= 0)
            A = randn(matrixSize);
            attemptCount = attemptCount + 1;
        end
        
        fprintf('Generated matrix with positive real eigenvalues after %d attempts.\n', attemptCount);
    end
    
    % Calculate the matrix logarithm
    log_A = logm(A);
    
    % Calculate the matrix exponential
    exp_log_A = expm(log_A);
    
    % Calculate the trace of the logarithm of A
    trace_log_A = trace(log_A);
    
    % Calculate the exponential of the trace of the logarithm of A
    exp_trace_log_A = exp(trace_log_A);
    
    % Calculate determinants
    det_A = det(A);
    det_exp_log_A = det(exp_log_A);
    
    % Calculate eigenvalues
    eigenvalues_A = eig(A);
    
    % Display the results with formatting
    disp('Generated Matrix A:');
    disp(A);
    
    fprintf('Matrix Size: %dx%d\n', size(A));
    fprintf('Determinant of A: %.6f\n', det_A);
    fprintf('Determinant of exp(Log(A)): %.6f\n', det_exp_log_A);
    fprintf('Exponential of Trace of Logarithm of A: %.6f\n', exp_trace_log_A);
    
    % Display eigenvalues until they are all positive real numbers
    while any(imag(eigenvalues_A) ~= 0) || any(eigenvalues_A <= 0)
        A = randn(matrixSize);
        eigenvalues_A = eig(A);
    end
    
    fprintf('Eigenvalues of A:\n');
    disp(eigenvalues_A);
    
    % Save the data to a .mat file
    save('output_data.mat', 'A', 'det_A', 'det_exp_log_A', 'exp_trace_log_A', 'eigenvalues_A');
    
    norm_of_A = norm(A);
    fprintf('Norm of A \n');
    disp(norm_of_A)
end
