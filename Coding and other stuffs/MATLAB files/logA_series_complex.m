function logA_series_complex()
    number_of_terms = 100;
    if nargin < 1
        matrixSize = randi([2, 3]);
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
    % Calculate the logarithm using the series expansion
    log_A_series = zeros(size(A));
    
    for k = 1:number_of_terms
        term = ((-1)^(k+1)) * ((A - eye(size(A)))^k) / k;
        log_A_series = log_A_series + term;
    end
    fprintf("original matrix det")
    disp(det(A))
    fprintf('Approximated Logarithm of A using series expansion:\n');
    disp(log_A_series);
    fprintf("exp_trace_log_A_series");
    disp(exp(trace(log_A_series)));
    norm_of_log_A_series = norm(log_A_series);
    fprintf('Norm of Approximated Logarithm of A: %.6f\n', norm_of_log_A_series);
end
