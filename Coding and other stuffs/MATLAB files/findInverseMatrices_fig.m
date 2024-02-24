function findInverseMatrices_fig()

    % Start the timer
    totalTimeStart = tic;

    % Initialize attempt counter
    totalAttempts = 0;

    while true
        % Generate a random square matrix size
        matrixSize = randi([3, 6]); % Adjust the range of matrix sizes as needed
        m = randn(matrixSize);

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
        fprintf("The norm is %f\n", p);

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

            % Display the total number of attempts
            fprintf("Total Attempts: %d\n", totalAttempts);

            % Stop the total timer and display total time
            totalTime = toc(totalTimeStart);
            fprintf("Total Time: %.5f seconds\n", totalTime);
            
            % Plot the original matrix and the inverse matrix
            figure;
            subplot(1, 2, 1);
            imagesc(m);
            colormap('hot');
            title('Original Matrix');

            subplot(1, 2, 2);
            imagesc(inv(m));
            colormap('hot');
            title('Inverse Matrix');

            % Exit the loop once a suitable matrix is found
            break;
        else
            disp("Norm must be less than 1. Trying again...");
        end
    end

end
