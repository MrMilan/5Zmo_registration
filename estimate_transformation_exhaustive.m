function t_optim = estimate_transformation_exhaustive(img, img_ref, ...
	cost_func, t_rng)
% Find the optimal transformation of the input image to the reference image
% by searching the space of all possible transformations exhaustively.
%
% Input:
%   img [MxN double] image for which transformation should estimated
%   img_ref [KxL double] reference image
%   cost_func [@(img1, img2) -> double] function evaluating similarity
%     of two images
%   t_rng [struct] ranges of parameters to be searched
%
% Output:
%   t_optim [struct] estimated transformation

% generate space of all transformations to be searched
t_space = transformation_space_exhaustive(t_rng);

% TODO: Replace with your own implementation.
t_optim = t_space(1);
[h, w] = size(img);   % size of the template image
[x, y] = meshgrid(1:w, 1:h); % coodinate system of the template image

fmin = inf;

for i=1:size(t_space, 2)
    t = t_space(i);
               
    [xt, yt] = transform_grid(x, y, t);   % transformed coordinate system
    img_ref_t = sample_image(img_ref, xt, yt);   % subimage of the reference image
        
    argmin = cost_func(img, img_ref_t);
    
    if argmin < fmin
        fmin = argmin;
        t_optim = t;
    end
end

end
