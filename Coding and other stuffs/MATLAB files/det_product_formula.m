function det_AB_formula = det_product_formula(A, B)
    [m, n] = size(A);

    det_AB_formula = 0;

    % Loop over all combinations of column indices
    for indices = combnk(1:n, m)
        % Extract submatrices A_{j_1j_2...j_m} and B_{j_1j_2...j_m}
        A_sub = A(:, indices);
        B_sub = B(indices, :);

        % Calculate determinants and accumulate the result using the formula
        det_AB_formula = det_AB_formula + det(A_sub) * det(B_sub);
    end
end
