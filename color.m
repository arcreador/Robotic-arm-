%%define pins and obj
   
configurePin(A,'d5','DigitalInput');
configurePin(A,'d6','DigitalInput');
configurePin(A,'d8','DigitalOutput');
configurePin(A,'d7','DigitalOutput');

cam=webcam('USB2.0 PC CAMERA');pause(2); 

%%write original position of servo

s=servo(A,'D4');
rr=servo(A,'D3');
t=servo(A,'D2');

writePosition(s,0.4)
pause(1);
writePosition(rr,0.2)
pause(1);
writePosition(t,0.0)
pause(1)
 


%%detect color of captured shot

disp('capturing');
pause(2) 

for i=1:2
    
       img=snapshot(cam); 
       figure;imshow(img);
       writeDigitalPin(A,'d8',1) %start the conveyer belt
       disp('got it');
   
end 

red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
r=mean(red(:));
g=mean(green(:));
bb=mean(blue(:));
 
%%position servo based on color

if  r>120 && g<200
disp('ripen');
a=0.8; b=0.2;c=0.1;
elseif r<85 && g>140
disp('unripen');
 a=0.4;
    b=0.2;
    c=0.2;
else
    disp('rotten');
    a=0.6;
    b=0.2;
    c=0.2;
end

%%picking of fruit

for I=1:15
    pause(1.4)
 n = readDigitalPin(A,'d6');   
if n==0
pause(1.5)    
writeDigitalPin(A, 'd8', 0); %stop the conveyer belt
 writeDigitalPin(A, 'd7', 1); %start the vaccum pump to pick the fruit
    pause(2)  

 
 break 
 else
        writeDigitalPin(A, 'd8', 1);
end
disp(I)
    
end 

%%placed

writePosition(s,c)
pause(1)
writePosition(rr,b)
pause(1)
writePosition(t,a)
pause(1)

%% read the servo position
writeDigitalPin(A, 'd7', 0);
readPosition(s)
readPosition(rr)
readPosition(t)
pause(2);


