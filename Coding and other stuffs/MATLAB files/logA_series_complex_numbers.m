function logA_series_complex_numbers()
    number_of_terms = 100;
    if nargin < 1
        matrixSize = randi([2, 3]);
        
        % Counter for attempts to generate complex matrix
        attemptCount = 1;
        
        % Keep generating matrices until all eigenvalues are in the specified strip
        % and the norm is less than 1
        while true
            A = randn(matrixSize) + 1i * randn(matrixSize);  % Generate a complex matrix
            eigenvalues_A = eig(A);
            in_strip = all(-pi < imag(eigenvalues_A) & imag(eigenvalues_A) < pi);
            norm_A = norm(eye(matrixSize) - A);
            
            if in_strip && norm_A < 1
                break;
            end
            
            attemptCount = attemptCount + 1;
        end
        
        fprintf('Generated complex matrix with eigenvalues in the strip and norm less than 1 after %d attempts.\n', attemptCount);
    end
    
    % Display the original matrix A
    disp('Original Complex Matrix A:');
    disp(A);
    eigenvalues_A = eig(A);
    fprintf('Eigenvalues of A:\n');
    disp(eigenvalues_A);
    
    % Calculate the logarithm using the series expansion
    log_A_series = zeros(size(A));
    
    for k = 1:number_of_terms
        term = ((-1)^(k+1)) * ((A - eye(size(A)))^k) / k;
        log_A_series = log_A_series + term;
    end
    
    fprintf("Original matrix determinant\n");
    disp(det(A))
    fprintf('Approximated Logarithm of A using series expansion:\n');
    disp(log_A_series);
    fprintf("exp_trace_log_A_series\n");
    disp(exp(trace(log_A_series)));
    norm_of_log_A_series = norm(log_A_series);
    fprintf('Norm of Approximated Logarithm of A: %.6f\n', norm_of_log_A_series);
    
    % Plot the complex matrix, eigenvalues, and the strip lines
    figure;
    
    % Scatter plot for complex matrix A and eigenvalues
    scatter(real(A(:)), imag(A(:)), 'Marker', 'o', 'MarkerEdgeColor', 'b', 'DisplayName', 'Complex Matrix A');
    hold on;
    scatter(real(eigenvalues_A), imag(eigenvalues_A), 'Marker', 'o', 'MarkerEdgeColor', 'r', 'DisplayName', 'Eigenvalues');
    
    % Plot the strip lines on the x and y axes
    strip_line_x = linspace(-pi, pi, 100);
    plot(zeros(size(strip_line_x)), strip_line_x, '--', 'Color', [0.2, 0.8, 0.2], 'LineWidth', 2, 'DisplayName', 'Strip Line X-axis');
    
    strip_line_y = linspace(-pi, pi, 100);
    plot(strip_line_y, zeros(size(strip_line_y)), '--', 'Color', [0.2, 0.2, 0.8], 'LineWidth', 2, 'DisplayName', 'Strip Line Y-axis');
    
    % Plot the lines parallel to x-axis at pi and -pi
    plot([min(real(A(:))), max(real(A(:)))], [pi, pi], '-', 'Color', [0.8, 0.2, 0.2], 'LineWidth', 2, 'DisplayName', 'Line at pi');
    plot([min(real(A(:))), max(real(A(:)))], [-pi, -pi], '-', 'Color', [0.8, 0.2, 0.2], 'LineWidth', 2, 'DisplayName', 'Line at -pi');
    
    % Plot the lines parallel to y-axis at pi and -pi
    plot([pi, pi], [min(imag(A(:))), max(imag(A(:)))], '--', 'Color', [0.8, 0.2, 0.2], 'LineWidth', 2, 'DisplayName', 'Line at pi Y-axis');
    plot([-pi, -pi], [min(imag(A(:))), max(imag(A(:)))], '--', 'Color', [0.8, 0.2, 0.2], 'LineWidth', 2, 'DisplayName', 'Line at -pi Y-axis');
    
    % Plot the bounded region
    fill([min(real(A(:))), max(real(A(:))), max(real(A(:))), min(real(A(:)))], ...
         [pi, pi, -pi, -pi], [0.8, 0.8, 0.8], 'FaceAlpha', 0.2, 'DisplayName', 'Bounded Region');
    
    xlabel('Real Part');
    ylabel('Imaginary Part');
    title('Complex Matrix, Eigenvalues, and Bounded Region Plot');
    legend('Location', 'Best');
    axis equal;  % Set the aspect ratio to be equal
    grid on;
    hold off;
end
