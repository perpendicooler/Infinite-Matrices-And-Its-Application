function [C, count] = strassenRecursive(A, B)
    if numel(A) == 1 % Base case for a 1x1 matrix
        C = A * B;
        count = 1;
        return;
    end

    [m, ~] = size(A);

    % Divide matrices into quadrants
    mid = m / 2;
    A11 = A(1:mid, 1:mid);
    A12 = A(1:mid, mid+1:end);
    A21 = A(mid+1:end, 1:mid);
    A22 = A(mid+1:end, mid+1:end);

    B11 = B(1:mid, 1:mid);
    B12 = B(1:mid, mid+1:end);
    B21 = B(mid+1:end, 1:mid);
    B22 = B(mid+1:end, mid+1:end);

    % Recursive multiplication
    [P1, count1] = strassenRecursive(A11 + A22, B11 + B22);
    [P2, count2] = strassenRecursive(A21 + A22, B11);
    [P3, count3] = strassenRecursive(A11, B12 - B22);
    [P4, count4] = strassenRecursive(A22, B21 - B11);
    [P5, count5] = strassenRecursive(A11 + A12, B22);
    [P6, count6] = strassenRecursive(A21 - A11, B11 + B12);
    [P7, count7] = strassenRecursive(A12 - A22, B21 + B22);

    % Calculate quadrants of the result matrix
    C11 = P1 + P4 - P5 + P7;
    C12 = P3 + P5;
    C21 = P2 + P4;
    C22 = P1 - P2 + P3 + P6;

    % Combine quadrants to form the result
    C = [C11, C12; C21, C22];

    % Count total multiplications
    count = count1 + count2 + count3 + count4 + count5 + count6 + count7 + 18; % 18 multiplications for Strassen
end