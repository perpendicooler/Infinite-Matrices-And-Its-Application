matrixSize = 10;
attemptCount = 0;

while true
    A = diag(randn(matrixSize,1));
    
    if any(imag(eig(A)) ~= 0) || any(eig(A) < 0) || norm(eye(matrixSize) - A) > 1
        attemptCount = attemptCount + 1;
        disp(['Attempt ', num2str(attemptCount), ': Conditions not met. Trying again...']);
    else
        disp(['Matrix found after ', num2str(attemptCount), ' attempts.']);
        disp('Matrix A:');
        disp(A);
        break;
    end
end
