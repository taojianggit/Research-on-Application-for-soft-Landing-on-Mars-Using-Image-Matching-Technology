clc
clear
a = gallery('circul',4)
a1=a-repmat(mean(a),size(a,1),1)

b=cov(a)
b1=a1'*a1/4

[p1,p2,p3,p4,p5,p6]=pca(a);
% d=pcacov(b)

[e,f]=eig(b);

coff=fliplr(e)
latent=a1*fliplr(e)