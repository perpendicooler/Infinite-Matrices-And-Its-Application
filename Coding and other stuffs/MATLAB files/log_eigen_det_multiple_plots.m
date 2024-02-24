function log_eigen_det_multiple_figures()
    number_of_terms = 100;
    tolerance = 1e-10;
    matrixSize = 10;
    num_eigenvalues = 25;
    num_subplots_per_figure = 5;

    % Initialize a counter for eigenvalues
    eigenvalue_counter = 1;

    while eigenvalue_counter <= num_eigenvalues
        % Initialize the figure for plotting
        figure;

        % Loop through each subplot in the figure
        for subplotIdx = 1:num_subplots_per_figure
            % Generate a random diagonal matrix A
            A = diag(randn(matrixSize, 1));

            % Display the original matrix A
            disp(['Original Matrix A for Subplot ', num2str(subplotIdx), ':']);
            disp(A);
            eigenvalues_A = eig(A);
            p = norm(eye(matrixSize) - A);
            fprintf('Eigenvalues of A for Subplot %d:\n', subplotIdx);
            disp(eigenvalues_A);
            fprintf('Norm of (I-A) for Subplot %d: %.6f\n', subplotIdx, p);

            % Create subplot
            subplot(num_subplots_per_figure, 1, subplotIdx);
            hold on;

            % Loop through 4 eigenvalues for each subplot
            for eigenIdx = 1:min(4, num_eigenvalues - eigenvalue_counter + 1)
                % Calculate the logarithm using the series expansion
                log_A_series = zeros(size(A));
                eigen_A = eigenvalues_A(eigenIdx);

                fprintf('Eigenvalue #%d for Subplot %d: %.6f\n', eigenIdx, subplotIdx, eigen_A);

                % Initialize variables for plotting
                det_exp_trace_log_A_series = zeros(1, number_of_terms);
                det_error = zeros(1, number_of_terms);

                for k = 1:number_of_terms
                    term = ((-1)^(k+1)) * ((A - eigen_A * eye(size(A)) - eye(size(A)))^k) / k;
                    log_A_series = log_A_series + term;

                    % Compare det(A) and det(exp(trace(log_A_series)))
                    det_exp_trace_log_A_series(k) = (exp(trace(log_A_series)));

                    % Calculate the error
                    det_error(k) = abs(det(A - eigen_A * eye(size(A))) - det_exp_trace_log_A_series(k));

                    if (det_error(k) <= tolerance)
                        break
                    end
                end

                % Plot the error after each iteration
                semilogy(1:k, det_error(1:k), '-o', 'LineWidth', 1.5);
                
                % Increment the eigenvalue counter
                eigenvalue_counter = eigenvalue_counter + 1;
            end

            xlabel('Iteration');
            ylabel('Determinant Error');
            title(sprintf('Convergence of Determinant Error for Subplot %d', subplotIdx));

            grid on;
            hold off;
        end
    end
end
