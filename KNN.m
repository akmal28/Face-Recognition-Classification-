function [recogRateKnn, benarKnn] = KNN(X_train, X_test, Y_train, Y_test,k)
  predictions = zeros(size(Y_test));
  
  %Looping data testing
  for i=1:size(X_test)(1)
    %Looping data training
    for j=1:size(X_train)(1)      
      dist(j,1) = sqrt(sumsq((X_test(i,:) .- X_train(j,:)), 2)); %Mencari distance dengan Euiclidean
    endfor
    [sorted_neighbor,index] = sort(dist); %Mengurutkan distance dari terkecil
    nearest_index = index(1:k); %Index distance sebanyak jumlah k
    k_nearest = sorted_neighbor(1:k,:); %Nilai distance sebanyak k
    
    for m=1:size(nearest_index)(1)
      nearest_predict(m,:) = Y_train(nearest_index(m),:); %Mengambil kelas dari data acuan
    endfor
    
    total = sum(nearest_predict); %Menjumlahkan matrix berdasarkan kolom
    max_total = max(total);
    total(total<max_total) = 0; %Mengganti nilai di bawah max dengan 0
    total(total==max_total) = 1; %Mengganti nilai max dengan 1
    predictions(i,:) = total; %Matrix prediksi
  endfor
  
  benar = 0;
  total_test = size(Y_test)(1);
  
  %Pengecekan
  for num=1:total_test
    if predictions(num,:) == Y_test(num,:)
      benar = benar+1;
    endif
  endfor
  
  benarKnn = benar;
  recogRateKnn = (benarKnn/total_test)*100;
  
endfunction
