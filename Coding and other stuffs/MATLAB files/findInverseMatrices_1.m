function findInverseMatrices_1()

    % Start the timer
    totalTimeStart = tic;
    lowerBound = 0.00001;
    upperBound = 0.000009;
    % Initialize attempt counter
    totalAttempts = 100;

    % Initialize the count of found matrices
    foundMatricesCount = 0;

    while foundMatricesCount < 2
        % Generate a random square matrix size
        matrixSize = randi([4, 6]); % Adjust the range of matrix sizes as needed
        m = (upperBound - lowerBound) * rand(matrixSize) + lowerBound;

        % Counting the number of attempts
        totalAttempts = totalAttempts + 1;

        disp("Generated Square Matrix:");
        disp(m);

        o = size(m);
        id = eye(o);

        % Storing The identity Matrices
        s = id;

        % Finding the value of the norm
        p = norm(id - m);
        fprintf("The norm is %f \n", p);

        if p < 1
            tol = 1e-6;
            n = 100;

            % Start the timer for the calculations
            calculationTimeStart = tic;

            for i = 1:n
                a = (id - m)^i;
                s = s + a;
                if norm(m * s - id) < tol
                    break
                end
            end

            % Stop the timer for the calculations
            calculationTime = toc(calculationTimeStart);

            disp("The inverse matrix is:");
            disp(inv(m));
            disp("The matrix we find by expanding series:");
            disp(s);

            % Save the generated matrix 'm' and norm value 'p' to a .dat file
            save(['generated_matrix_' num2str(foundMatricesCount + 1) '.dat'], 'm', 'p', '-ascii');

            % Increment the count of found matrices
            foundMatricesCount = foundMatricesCount + 1;

            % Display the total number of attempts
            fprintf("Total Attempts: %d\n", totalAttempts);

            % Stop the total timer and display total time
            totalTime = toc(totalTimeStart);
            fprintf("Total Time: %.5f seconds\n", totalTime);
            fprintf("Total calculation Time: %.5f seconds\n", calculationTime);

            % Break out of the loop if 5 matrices are found
            if foundMatricesCount == 5
                break;
            end
        else
            disp("Norm must be less than 1. Trying again..");
        end
    end

end
