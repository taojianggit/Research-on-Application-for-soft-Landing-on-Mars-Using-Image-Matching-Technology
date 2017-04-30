function region=harris(img0,alpha)
	%function:detect corner points using harris
	%input:a-response value parameter of corner, 0.04~0.06
	%output:posr-row coordinate of corner detected
	%output:posc-column coordinate of corner detected
    if length(size(img0))==3
        img=double(rgb2gray(img0));
        
    else
        img=img0;
    end
% 	img=img0;
	%===============compute gradient of image at x,y direction================%
	
	% x direction gradient template
	fx=[-1 0 1];
	% x direction filtering
	Ix=filter2(fx,img);
	% y direction gradient template
	fy=[-1;0;1];
	% x direction filtering
	Iy=filter2(fy,img);
	
	%===============compute gradient  production Ix^2,Iy^2,Ix*Iy==============%
	Ix2=Ix.^2;
	Iy2=Iy.^2;
	Ixy=Ix.*Iy;
	
	%========weighting for the gradient production with gaussian function=====%
	
	%produce a gaussian function, 7*7,sigma=2
	h=fspecial('gaussian',[7,7],2);
	
	A=filter2(h,Ix2);
	B=filter2(h,Iy2);
	C=filter2(h,Ixy);
	
	%==========compute response value of every pixel of image=================%
	[height,width]=size(img);
	R=zeros(height,width);
	E=[];
    E1=[];
    E2=[];
    V1=[];
    V2=[];
    theta=[];
	%response value of pixel(i,j)
	for i=1:height
	    for j=1:width
	        M=[A(i,j) C(i,j);C(i,j) B(i,j)];
	        R(i,j)=det(M)-alpha*(trace(M))^2;
	    end
    end
	
	%remove response value less than  threshold
	Rmax=max(max(R));
	
	%threshold
	t=0.01*Rmax;
	
	for i=1:height
	    for j=1:width
	        if R(i,j)<t;
	            R(i,j)=0;
	        end
	    end
	end
	
	%==================non-maximun suppression in 3*3 field===================%
	corner_peaks=imregionalmax(R);
	countnum=sum(sum(corner_peaks));
	
	%=============================display corner points=======================%
	[posr,posc]=find(corner_peaks==1);
       
     
     
	%posr(position row) is x coordinate,posc(position column) is y coordinate
% 	figure
% 	imshow(img0);
% 	hold on
	for i=1:length(posr)
             M=[A(posr(i),posc(i)) C(posr(i),posc(i));C(posr(i),posc(i)) B(posr(i),posc(i))];
             [V E]=eig(M);
  
             E1=[E1 E(1,1)];
             E2=[E2 E(2,2)];
% 	         plot(posc(i),posr(i),'.r');
             
%              x1 = linspace(-1, 1, 16);
%                 y1 = x1;

%                 P = reshape(sum(T * M .* T, 2), size(X));
%                 contour(x1, y1, P)

%                 G = 2 * M * T.';
%                 quiver(X(:), Y(:), G(1, :).', G(2, :).');
%                 quiver(0, 0, 0.60*1.245, 0.0667*1.245, 'r');

                V1=[V1 V(:,1)];
                V2=[V2 V(:,2)];
                theta=[theta atan(V1(i+1)/V1(i))];
%                 quiver(posc(i),posr(i), V1(i),V1(i+1),40, 'g');
%                 CC=size( img0, 2 );
%                 RR=size( img0, 1 );
%                 assignin('base','RR',RR);assignin('base','CC',CC)
%                 EllipseCenter = [ CC / 2; RR / 2 ];  
%                 imageEllipse=ellipse1(M,RR,CC,EllipseCenter);
    end

     b=1./sqrt(E1);
     a=1./sqrt(E2);
     region=[posc posr a' b' theta'];
     
     
     
     
     
     
