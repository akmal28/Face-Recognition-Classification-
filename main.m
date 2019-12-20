%Kelompok Pemadam Api

close -a; clear; clc;

##dataset_path = 'dataset/ir_face';
dataset_path = 'dataset/faces_kelas';
[X_train,X_test,Y_train,Y_test] = scale(dataset_path);
[recogRateSom,benarSom] = som(X_train,X_test,Y_train,Y_test)
[recogRateLvq,benarLvq] = lvq(X_train,X_test,Y_train,Y_test)
[recogRateKnn, benarKnn] = KNN(X_train,X_test,Y_train,Y_test,3)