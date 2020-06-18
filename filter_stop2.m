files = dir('*.mat');
%random
for file = files'
    csv = load(file.name);
    vx=diff(csv.x_pos);
    vy=diff(csv.y_pos);
    v=sqrt((vx.^2)+(vy.^2));
    ncount = 0;
    save((file.name),'v','-append')
    
    %formation of an array which can be used for binary purpose.
    for i = 1:(size(csv.v));
            flag(i)=0;
    end
    
    %flagging the required part as '1'
    for i = 1:size(csv.v);
        if v(i)<0.4;
            flag(i)=1;
        else
            continue;
        end
    end

    %formation of new array, which can be used to count each '1' sequence.
    for i = 1:(size(csv.v));
        count(i)=1;
    end

    %formation of new array, which can be used to mark the beginning of '1'
    %sequence
    for i = 1:(size(csv.v));
        b(i)=0;
    end
    
    %correct till now.
    
    k=1;
    i=1;
    o=1;
    bg=0;
    for i=1:size(csv.v);
        if flag(i)==0 || flag(i)==1;
            bg=bg+1;
        end
    end
    %correct till now.
    
    i=1;
    while flag(i)==1 || flag(i)==0;
        if i>1 && flag(i-1)==0 && flag(i)==1 && flag(i+1)==0;
            flag(i)=0;
        end
        i=i+1;
        if i>=bg;
            break;
        end
    end
    i=1;
    while flag(i)==1 || flag(i)==0;
        if i==1 && flag(i)==1; 
                b(k)=1;
                k=k+1;
        end

        if flag(i)==1 && flag(i+1)==1;
            count(o)=count(o)+1;
        end
        if i>1 && flag(i-1)==1 && flag(i)==1 && flag(i+1)==0;
            o=o+1;
        end

        if i>1 && flag(i+1)==1 && flag(i)==0;
                b(k)=i+1;
                k=k+1;
        end
        i=i+1;
        if i>=bg;
            break;
        end
    end
    dcount=transpose(count);
    for i=1:size(dcount);
        if dcount(i)>10;
            ncount=ncount+1;
        end
    end
    
    
    o=1;
    i=1;
    %while dcount(o)>1 && dcount(o)<10;
     %   while flag(i)==0 || flag(i)==1;
      %      if flag(i)==0 && flag(i+1)==1 && flag(i+dcount(o))==1;
       %         for j=b(o):b(o)+dcount(o)-1;
        %            flag(j)=0;
         %       end
          %      i=i+1;
           %     if i+dcount(o)>bg;
            %        break;
             %   end
            %else
             %   i=i+1;
              %  if i+dcount(o)>bg;
               %     break;
                %end
            %end
       % end
        %o=o+1;
    %end

    o=1;
    
    o=1;
    while count(o)>1;
        if count(o)<10;
            dcount(o)=0;
            o=o+1;
        else
            o=o+1;
        end
    end
    
    %for i= 1:bg-1;
      %  if dcount(i)==0;
       %     dcount(i)=dcount(i+1);
        %end
    %end
    for i=1:bg;
        ccount(i)=0;
    end
    tccount=transpose(ccount);
    o=1;
    for i=1:bg-1;
        if dcount(i)~=0;
            tccount(o)=dcount(i);
            o=o+1;
        end
    end
    for i=1:bg-1;
        bk(i)=0;
    end
    o=1;
    for i=1:bg-1;
        if count(i)>10;
            bk(o)=b(i);
            o=o+1;
        end
    end
    start_of_a_stop=transpose(bk);
    
    for i= 1:bg-3;
        if start_of_a_stop(i)==start_of_a_stop(i+1);
            start_of_a_stop(i+1)=start_of_a_stop(i+2);
        end
    end
    
    %Number of times it has stopped.
    NumOfStops=ncount;
    disp('The number of times fly has stopped:');
    disp(NumOfStops);

    d=1;
    for i = 1:ncount;
        stop_of_a_stop(i)=0;
    end
    for i = 1:ncount;
        jk(i)=0;
    end
    
    tstart_of_a_stop=transpose(jk);
    for i = 1:ncount;
        tstart_of_a_stop(i)=start_of_a_stop(i);
    end
    for i = 1:ncount;
        stop_of_a_stop(i)=start_of_a_stop(i)+tccount(i)-1;
    end
    tstop_of_a_stop=transpose(stop_of_a_stop);
    save((file.name),'NumOfStops','-append')
    save((file.name),'tstart_of_a_stop','-append')
    save((file.name),'tstop_of_a_stop','-append')
    
end

