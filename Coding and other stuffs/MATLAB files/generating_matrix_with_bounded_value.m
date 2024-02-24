function generating_matrix_with_bounded_value()

    maxAttempts = 100;
    matrixSize = 8; % Adjust the matrix size as needed
    
    % Generate random values for lower and upper bounds within the specified range
    lowerBound = 0.001 ;
    upperBound = 0.0009 ;
    
    for attempt = 1:maxAttempts
        % Generate a random square matrix with elements within the specified range
        M = (upperBound - lowerBound) * rand(matrixSize) + lowerBound;
        p = norm(M);
        % Check if the matrix satisfies the condition
        if norm(M) < 1
            disp("Generated Matrix with Norm less than 1:");
            disp(M);
            
            % Calculate and display the norm
            normValue = norm(M);
            fprintf(['Norm: ' num2str(normValue) '\n']);

            break;
        else
            disp("Generated Matrix does not meet the condition. Trying again...");
        end
    end
end
