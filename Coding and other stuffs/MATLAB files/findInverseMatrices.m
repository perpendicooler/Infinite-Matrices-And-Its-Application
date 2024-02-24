
function findInverseMatrices()

    
    % Start the timer
    totalTimeStart = tic;
    
    % Initialize attempt counter
    totalAttempts = 0;
    
    while true
        % Generate a random square matrix size
        matrixSize = randi([5, 7]); % Matrix size within the specified range
        m = diag(randn(matrixSize, 1));
        
        % Count the number of attempts
        totalAttempts = totalAttempts + 1;
        
        disp("Generated Square Matrix:");
        disp(m);
        
        % Get matrix size
        o = size(m);
        id = eye(o);
        
        % Initialize identity and accumulation matrices
        s = id;
        
        % Calculate the norm
        p = norm(id - m);
        fprintf("The norm is %f \n", p);
        
        % Check if the norm is less than 1
        if p < 1
            tol = 1e-10;
            n = 100000; % Maximum number of iterations
            
            % Start the timer for calculations
            calculationTimeStart = tic;
            
            % Initialize variables for plotting
            inverse_error = zeros(1, n);
            
            % Create a figure for the error plot
            figure;
            
            % Iterative series expansion
            for i = 1:n
                a = (id - m)^i;
                s = s + a;
                
                % Calculate the error
                inverse_error(i) = norm(m * s - id);
                
                % Plot the error after each iteration
                semilogy(1:i, inverse_error(1:i), '-o', 'LineWidth', 1.5);
                xlabel('Iteration');
                ylabel('Inverse Matrix Error');
                title('Convergence of Inverse Matrix Error');
                grid on;
                drawnow;
                
                % Pause for a short duration to allow for visualization
                pause(0.000000001);
                
                % Break the loop if the error is below tolerance
                if inverse_error(i) < tol
                    break
                end
            end
            
            % Stop the timer for calculations
            calculationTime = toc(calculationTimeStart);
            
            % Display the computed inverse matrix
            disp("Computed Inverse Matrix:");
            disp(inv(m));
            
            % Display the number of iterations needed for convergence
            fprintf("Convergence achieved up to 6 decimal places in %d iterations.\n", i);
            
            % Display the matrix obtained by expanding the series
            disp("Matrix obtained by expanding the series:");
            disp(s);
            
            % Display the total number of attempts
            fprintf("Total Attempts: %d\n", totalAttempts);
            
            % Stop the total timer and display total time
            totalTime = toc(totalTimeStart);
            fprintf("Total Time: %.5f seconds\n", totalTime);
            fprintf("Calculation Time: %.5f seconds\n", calculationTime);
            
            % Display matrix size
            disp("Matrix Size:");
            disp(matrixSize);
            
            % Exit the loop once a suitable matrix is found
            break;
        else
            disp("Norm must be less than 1. Trying again..");
        end
    end
end