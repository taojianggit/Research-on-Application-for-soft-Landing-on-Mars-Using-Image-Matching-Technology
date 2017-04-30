function H = homography2d(varargin)
    
    [x1, x2] = checkargs(varargin(:));
    M=x1;
    m=x2;
    % Attempt to normalise each set of points so that the origin 
    % is at centroid and mean distance from origin is sqrt(2).
    [x1, T1] = normalise2dpts(x1);
    [x2, T2] = normalise2dpts(x2);
    
    % Note that it may have not been possible to normalise
    % the points if one was at infinity so the following does not
    % assume that scale parameter w = 1.
    % Estimation of the H between the model plane and its image, P18
    Npts = length(x1);
    A = zeros(3*Npts,9);
    
    O = [0 0 0];
    for n = 1:Npts
        X = x1(:,n)';
        x = x2(1,n); y = x2(2,n); w = x2(3,n);
        A(3*n-2,:) = [  O  -w*X  y*X];
        A(3*n-1,:) = [ w*X   O  -x*X];
        A(3*n  ,:) = [-y*X  x*X   O ];
    end
    
    [U,D,V] = svd(A);
    
    % Extract homography
    H = reshape(V(:,9),3,3)';
           
    % Denormalise
    H = T2\H*T1;
    H=H/H(3,3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Maximun likelihood estimation for the H
    % using the function(10), P7
    options = optimset('LargeScale','off','MaxIter',1000 );
%     [x,resnorm,residual,exitflag,output]  = lsqnonlin( @simon_H, reshape(H,1,9) , [],[],options,m, M);
%     H=reshape(x,3,3);
%     H=H/H(3,3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
% Function to check argument values and set defaults

function [x1, x2] = checkargs(arg);
    
    if length(arg) == 2
        x1 = arg{1};
        x2 = arg{2};
        if ~all(size(x1)==size(x2))
            error('x1 and x2 must have the same size');
        elseif size(x1,1) ~= 3
            error('x1 and x2 must be 3xN');
        end
        
    elseif length(arg) == 1
        if size(arg{1},1) ~= 6
            error('Single argument x must be 6xN');
        else
            x1 = arg{1}(1:3,:);
            x2 = arg{1}(4:6,:);
        end
    else
        error('Wrong number of arguments supplied');
    end