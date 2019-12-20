%Kelompok Pemadam Api
%Scaling & Split
##close -a; clear; clc;
function [X_train,X_test,Y_train,Y_test] = scale(dataset_path)

##  dataset_path = 'dataset/ir_face';

  dataset_input = [];
  dataset_output = [];

  className = dir(dataset_path);
  classLength = length(className);

  label = {};

  for i=3:classLength
    label(i-2) = className(i).name;
  endfor

  for i=1:length(label)
    img_path = dir(fullfile(dataset_path,label{i}));
    for j=3:length(img_path)
      imdir = fullfile(dataset_path,label{i},img_path(j).name);
      img = double(imread(imdir));
      if size(size(img))(2) == 3
        image = rgb2gray(img);
      endif
      row_size = size(image,1)*size(image,2);
      img_reshape = reshape(image,[1,row_size]);
      dataset_input = [dataset_input;img_reshape];
      dataset_output = [dataset_output;i];
    endfor
  endfor
  
  dataset_output_conv = [];
##  i = size(dataset_output)(1);
##  while i > 0
##    class = zeros(1,size(label)(2));
##    class(dataset_output(i)) = 1;
##    dataset_output_conv = [dataset_output_conv;class];
##    i = i-1;
##  endwhile
  for i = 1:size(dataset_output)(1)
    class = zeros(1,size(label)(2));
    class(dataset_output(i)) = 1;
    dataset_output_conv = [dataset_output_conv;class];
  endfor
  
  dataset_input = dataset_input-min(dataset_input)./max(dataset_input)-min(dataset_input);
  pca = PCA(dataset_input);

  X_train = [];
  X_test = [];
  Y_train = [];
  Y_test = [];

  for i=1:10
    if i<= 5
      for j=0:13
        X_train = [X_train;pca(i+(10*j),:)];
        Y_train = [Y_train;dataset_output_conv(i+(10*j),:)];
      endfor
    else
      for j=0:13
        X_test = [X_test;pca(i+(10*j),:)];
        Y_test = [Y_test;dataset_output_conv(i+(10*j),:)];
      endfor
    endif
  endfor

##  X_train = X_train-min(X_train)./max(X_train)-min(X_train);
##  X_test = X_test-min(X_test)./max(X_test)-min(X_test);

endfunction

