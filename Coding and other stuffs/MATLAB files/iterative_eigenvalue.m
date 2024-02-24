function iterative_eigenvalue()
    matrixSize = randi([2,3]);
   % A = diag(randn(matrixSize,1)); 
    n = size(A, 1);
    % Replace 'your_matrix' with your actual matrix
   while true
        A = diag(randn(matrixSize,1));
%any(imag(eig(A)) ~= 0) || any(eig(A) < 0) || 
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

    max_iterations = 100;
    tolerance = 1e-6;
    

    eigen_exact = eig(A);
    % Initialize eigenvalue guess
    eigenvalue = zeros(n, 1);
    log_A_series = zeros(size(A));
    % Perform iterations
    for k = 1: max_iterations 
        term = ((-1)^(k+1)) * ((A - eye(size(A)))^k) / k;
        log_A_series = log_A_series + term;
        
        % Compare det(A) and det(exp(trace(log_A_series)))
        %det_exp_trace_log_A_series(k) = det(exp(trace(log_A_series)));
        
        % Calculate the error
        %det_error(k) = abs(det_A - det_exp_trace_log_A_series(k));
       if exp(trace(log_A_series) = 0
           break
       end
    disp(eigen_exact)
    disp('Calculated Eigenvalue:');
    disp(eigenvalue);

    %disp('Convergence Error:');
    %disp(convergence_error);
    end
    if k == max_iterations
        warning('Maximum iterations reached without convergence.');
    end
end
