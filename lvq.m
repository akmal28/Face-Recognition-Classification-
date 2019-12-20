% Kelompok Pemadam Api
% Akmal Ramadhan Arifin
% Michael Wijaya
% Julius Hotma Baginda Sianturi
% Muhammad Adhie Nugroho

function [recogRateLvq,benarLvq] = lvq(X_train,X_test,Y_train,Y_test)

  %weight initialization
  Wmn = zeros(size(Y_train)(2),size(X_train)(2));
  for i=1:size(Y_train)(2)
    Wmn(i,:) = X_train(i,:);
  endfor

  alpha_min = 0.001;
  alpha = 0.5;
  epoch = 0;
  epoch_max = 100;

  %Training
  while alpha > alpha_min && epoch < epoch_max
    Dm = zeros(size(Y_test)(2),1);
    for num=1:size(X_train,1)
      Xn = X_train(num,:);
      for i=1:size(Y_test)(2)
        Dm(i) = sqrt(sum(Wmn(i,:)-Xn).^2);
      endfor
      [nilaiMin, indexMin] = min(Dm);     
      [nilaiMax, indexMax] = max(Y_train(num,:));
      if indexMin == indexMax
        Wmn (indexMin,:) = Wmn(indexMin,:)+alpha*(Xn-Wmn(indexMin,:));
      else 
        Wmn (indexMin,:) = Wmn(indexMin,:)-alpha*(Xn-Wmn(indexMin,:));
      endif
      
      %visualization
##      scatter3(Wmn(1,1),Wmn(1,2),Wmn(1,3),1,[1 0 0],"filled");
##      hold on
##      scatter3(Wmn(2,1),Wmn(2,2),Wmn(2,3),1,[0 1 0],"filled");
##      hold on
##      scatter3(Wmn(3,1),Wmn(3,2),Wmn(3,3),1,[0 0 1],"filled");
##      hold on
    endfor
    epoch = epoch+1;
    alpha = 0.5*alpha;
  endwhile

  benar = 0;
  totalTest = size(X_test,1);
  desiredOutput = Y_test;
  Dm = zeros(size(Y_test)(2),1);
  %Testing
  for num=1:totalTest
    Xn = X_test(num,:);
    for i=1:size(Y_test)(2)
        Dm(i) = sqrt(sum(Wmn(i,:)-Xn).^2);
    endfor
    [nilaiMin, indexMin] = min(Dm);
    
    %comparison
    desiredOutput(num,:)';
    Dm(Dm<=nilaiMin)=-1;
    Dm(Dm>nilaiMin)=0;
    Dm(Dm==-1)=1;
    if Dm == desiredOutput(num,:)'
      benar = benar+1;
    endif
  endfor
  benarLvq = benar;
  recogRateLvq = (benar/totalTest)*100;
  
 endfunction