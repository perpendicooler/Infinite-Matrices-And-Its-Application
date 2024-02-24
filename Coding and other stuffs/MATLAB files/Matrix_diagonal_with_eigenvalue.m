function Matrix_diagonal_with_eigenvalue(A)
    
    if nargin < 1
        matrixSize = randi([3, 4]);
        A = randn(matrixSize);
        
        % Counter for attempts to generate matrix with positive real eigenvalues
        attemptCount = 1;
        
        % Keep generating matrices until all eigenvalues are positive real numbers
        while any(imag(eig(A)) ~= 0) || any(eig(A) <= 0) || norm(eye(matrixSize) - A) > 1
            A = randn(matrixSize);
            attemptCount = attemptCount + 1;
        end
        
        fprintf('Generated matrix with positive real eigenvalues and norm(identity - A) < 1 after %d attempts.\n', attemptCount);
    end
    
   
  
    
   
    
    % Calculate eigenvalues
    eigenvalues_A = eig(A);
    
    % Display the results with formatting
    disp('Generated Matrix A:');
    disp(A);
    
    fprintf('Matrix Size: %dx%d\n', size(A));
   
    
    
    fprintf('Eigenvalues of A:\n');
    disp(eigenvalues_A);
    

    p = norm(eye(matrixSize) - A);
    
    fprintf('Norm of (I-A): %.6f\n', p);
end
