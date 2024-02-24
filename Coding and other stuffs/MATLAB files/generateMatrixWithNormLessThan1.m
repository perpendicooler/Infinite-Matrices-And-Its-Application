function generateMatrixWithNormLessThan1()

    maxAttempts = 10;
    matrixSize = 4; % Adjust the matrix size as needed
    maxNorm = 1;    % Maximum allowed norm
    
    for attempt = 1:maxAttempts
        % Generate a random square matrix
        M = randn(matrixSize);

        % Check if the norm is less than the specified maximum
        if norm(M) < maxNorm
            disp("Generated Matrix with Norm less than 1:");
            disp(M);
            
            % Calculate and display the norm
            normValue = norm(M);
            disp(['Norm: ' num2str(normValue)]);
            break;
        else
            disp("Generated Matrix does not meet the condition. Trying again...");
        end
    end
end
