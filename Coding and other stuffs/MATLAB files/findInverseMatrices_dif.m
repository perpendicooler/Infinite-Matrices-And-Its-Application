function findInverseMatrices_dif()

    % Start the timer
    totalTimeStart = tic;

    % Initialize attempt counter
    totalAttempts = 0;

    while true
        % Generate a random square matrix size
        matrixSize = randi([2]); % Adjust the range of matrix sizes as needed
        m = randn(matrixSize);

        % Increment attempt counter
        totalAttempts = totalAttempts + 1;

        % Check if the spectral radius is less than 1
        if max(abs(eig(m))) < 1
            disp("Generated Square Matrix:");
            disp(m);

            % Start the timer for the calculations
            calculationTimeStart = tic;

            % Calculate the inverse using the built-in function
            invM = inv(m);

            % Stop the timer for the calculations
            calculationTime = toc(calculationTimeStart);

            disp("The inverse matrix is:");
            disp(invM);

            % Check if the norm of the found matrix is less than 1
            foundMatrixNorm = norm(invM);
            if foundMatrixNorm < 1
                fprintf("Norm of the found matrix: %f\n", foundMatrixNorm);

                % Display the total number of attempts
                fprintf("Total Attempts: %d\n", totalAttempts);

                % Stop the total timer and display total time
                totalTime = toc(totalTimeStart);
                fprintf("Total Time: %.5f seconds\n", totalTime);

                % Exit the loop once a suitable matrix is found
                break;
            else
                disp("Norm of the found matrix must be less than 1. Trying again...");
            end
        else
            disp("Spectral radius must be less than 1. Trying again...");
        end
    end

end
