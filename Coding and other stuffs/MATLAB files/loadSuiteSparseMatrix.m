function A = loadSuiteSparseMatrix()
    % Load the SuiteSparse matrix
    A = readmatrix('1138_bus.mat', 'FileType', 'text');
    Problem = struct('A', A);

    A =Problem.A;
end
