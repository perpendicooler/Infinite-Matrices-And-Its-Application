
%% only for jordan canonical form
function Matrix_jordan_canonical_form(A)
    
  
    
    if nargin < 1
        matrixSize = randi([3, 4]);
        A = randn(matrixSize);
    end
    
    % Extract the diagonal elements
    diag_A = diag(A);
    
    % Create a diagonal matrix with the diagonal elements of A
    Diagonal_A = diag(diag_A);
    
    % Display the generated matrix A
    disp('Generated Matrix A:');
    disp(A);
    
    % Display the modified matrix with only diagonal elements
    disp('Matrix with only Diagonal Elements:');
    disp(Diagonal_A);
    
    % Save the data to a .mat file
    save('jordan_canonical_form.mat', 'A', 'Diagonal_A');
    
    % Calculate eigenvalues of the original matrix A
    eigenvalues_A = eig(A);
    
    % Display the eigenvalues of A
    fprintf('Eigenvalues of A:\n');
    disp(eigenvalues_A);
    
    % Calculate the determinant of A and the determinant of the diagonal matrix
    det_A = det(A);
    det_Diagonal_A = prod(diag_A);
    det_exp = det(exp(log(Diagonal_A)));
    trace_exp = exp(trace(log(Diagonal_A)));
    
    % Display determinants
    fprintf('Determinant of A: %.6f\n', det_A);
    fprintf('Determinant of Diagonal Matrix: %.6f\n', det_Diagonal_A);
    fprintf('Determinant with det(exp(log(A)))%.6f\n',det_exp); 
    fprintf('Determinant of exp(trace(logA))) Matrix: %.6f\n', trace_exp);
    fprintf('Matrix Size = ');
    disp(matrixSize)
    % Calculate the norm of the original matrix A
    norm_of_A = norm(A);
    fprintf('Norm of A: %.6f\n', norm_of_A);
end
