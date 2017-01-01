function mi = mutual_information(img1, img2)
% Compute mutual information of two intensity images using 10 bins.
%
% Input:
%   img1 [MxN double] first image
%   img2 [MxN double] second image
%
% Output:
%   mi [double] mutual information

% Notes:
% - Use 10 bins to compute 1D histograms of image intensities, i.e.
%   bin_centers = linspace(0, 1, 10).
% - Use 10x10 bins to compute 2D histogram of intensity pairs from img1, img2.
% - Use functions N = hist(Y, X) and N = hist3(X, CTRS) to compute histograms.

% TODO: Replace with your own implementation.
nbins = linspace(0, 1, 10);
counts1 = hist(img1, nbins);   
p1 = counts1/sum(counts1);


counts2 = hist(img2, nbins);   
p2 = counts2/sum(counts2);


imTogether = [img1(:),img2(:)];
nbins2D = {nbins, nbins};
counts3 = hist3(imTogether,nbins2D);

p3 = counts3/sum(sum(counts3));
p3 = p3(:);

p1(p1==0) = [];
E1 = -sum(p1.*log(p1));

p2(p2==0) = [];
E2 = -sum(p2.*log(p2));

p3(p3==0) = [];
E3 = -sum(p3.*log(p3));
mi = (E1 + E2 - E3); 

end
