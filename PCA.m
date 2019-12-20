%Akmal Ramadhan Arifin
%1606837423

function pca = PCA(im_reshape)
  
  covariance = cov(im_reshape - mean(im_reshape));

  [eigenVector, eigenValue] = eig(covariance);
  
  [eigenValue,i] = sort(diag(eigenValue), 'descend');
  eigenVector = eigenVector(:,i);

  k = 1;
  explainedVariance = 0;
  eigVSum = sum(eigenValue);

  while k<size(eigenVector)(1) && explainedVariance<0.99
    explainedVariance = sum(eigenValue(1:k))/eigVSum;
    k = k+1;
  endwhile
##  k
  eigenVector = eigenVector(:,1:k);
  pca = double(im_reshape)*eigenVector;

endfunction