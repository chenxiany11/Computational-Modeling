%question 1
%I pledge this is my code

%initialize delta
dl=0.1;
dt=0.002;

[PX,PY]=meshgrid(0:0.1:10,0:0.1:20);
%get boundary 
r1=(abs(PY-(15+sqrt(-PX.^2+10*PX)))<(dl/1.5))|...
    (abs(PY-(5-sqrt(-PX.^2+10*PX)))<(dl/1.5));
r2=(PX<dl|PX>(10-1.5*dl))&...
    (PY>(5-1.5*dl)&PY<(15+1.5*dl));
r3=(PY<(15+sqrt(-PX.^2+10*PX)))&...
    (PY>(5-sqrt(-PX.^2+10*PX)));
r=r1+2*r2+r3;

c=dt/(dl^2);
u=60*r3+20*r2;
sol=zeros(size(u));

%iterate through the loop and calculate the value, put in the matrix
for i=1:201%20*10+1
    for j=1:101%10*10+1
        if r(i,j)==2
            if i<102
                %hafe
                if (j>51) && (j<100)
                   sol(i,j)=2*c*(u(i-1,j)+u(i,j)+(PX(i-1,j)-5)*dl/sqrt((PX(i-1,j)-5)^2+...
                       (PY(i-1,j)-5)^2)+u(i,j+1)*2+(PY(i,j+1)-5)*dl/sqrt((PX(i,j+1)-5)^2+(PY(i,j+1)-5)^2)-4*u(i,j));
                end
                %another half
                if j<=51
                   sol(i,j)=u(i,j)+c*(u(i+1,j)+(PX(i+1,j)-5)*dl/sqrt((PX(i+1,j)-5)^2+...
                       (PY(i+1,j)-5)^2)+u(i,j+1)*2+(PY(i,j+1)-5)*dl/sqrt((PX(i,j+1)-5)^2+(PY(i,j+1)-5)^2)-4*u(i,j));
                end
           end
           if i>=102
               if j>=52
                  sol(i,j)=u(i,j)+(dt/(dl^2))*(u(i+1,j)*2+(PX(i+1,j)-5)*dl/sqrt((PX(i+1,j)-5)^2+...
                      (PY(i+1,j)-5)^2)+(PY(i,j-1)-5)*dl/sqrt((PX(i,j-1)-5)^2+(PY(i,j-1)-5)^2)-4*u(i,j)+u(i,j-1)*2);
             
               elseif  j>2&&j<51
                    sol(i,j)=u(i,j)+c*2*(u(i+1,j)+(PX(i+1,j)-5)*dl/sqrt((PX(i+1,j)-5)^2+(PY(i+1,j)-5)^2)+...
                       u(i,j-1)*2+(PY(i,j-1)-5)*dl/sqrt((PX(i,j-1)-5)^2+(PY(i,j-1)-5)^2)-4*u(i,j));
                end
           end
        end
        if r(i,j)==1
            %not the first and last
           if (i>1) && (i<201)
               sol(i,j)=u(i,j)+c*(u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1)-4*u(i,j));
           end
        end
        %boundary condition
        if r(i,j)==3
           sol(i,j)=80;
        end
    end
    mesh(PX,PY,sol);
    title('heat equation');
    xlabel('x(position)');
    ylabel('y(position)');
    zlabel('u(displacement)');
end