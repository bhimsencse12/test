pass=0;
fail=0;
score=0;

nodeserver='http://localhost:300';
nginxserver='http://localhost:8000/';


if curl -Is "$nginxserver" | grep -i "200 OK" > /dev/null
then
    ((pass++))
    #echo " Success!!! Nginx Server is up and running."; 
else
    ((fail++))
    #echo "Error!!! Nginx Server is down."; 
fi

for i in 0 1 2 
do
    if curl -Is "$nodeserver$i" | grep -i "200 OK" > /dev/null
    then
        ((pass++))
        #echo " Success!!! Nodejs Server at port 300$i is up and running."; 
    else
        ((fail++))
        #echo "Error!!! Nodejs Server at port 300$i is down."; 
    fi
done

path=/etc/nginx/sites-enabled/;
config=$(ls $path);

if cat $path$config  | grep -i "upstream" > /dev/null
then
    ((pass++))
    #echo " Success!!! Nginx default.conf configured for load balancing."
else
    ((fail++))
    #echo "Error!!!Nginx default.conf NOT configured for load balancing."
fi

nodeip='server 127.0.0.1:300';
for i in 0 1 2
do
    if cat $path$config  | grep -i "$nodeip$i" > /dev/null
    then
        ((pass++))
        #echo " Success!!! $nodeip$i configured for load balancing."
    else
        ((fail++))
        #echo "Error!!! $nodeip$i NOT configured for load balancing."
    fi
done

sudo service nginx restart;

keyword='Hey Nginxer!!! You are now docked onto Nodejs port : 300';
         
for i in 0 1 2 
do 
    for j in 0 1 2
    do  
        if curl -s "$nginxserver" | grep -i "$keyword$j" > /dev/null
        then
            # if the custom error is in the content
            ((pass++))
            #echo " Success!!! Nginx Server load balancing in RR fashion for port 300$j"; 
        else
            ((fail++))
            #echo "Error!!! Nginx Server did NOT load balancing in RR fashion for port 300$j"; 
        fi
    done
done




echo "Test cases executed: $(( $pass + $fail ))"
echo "pass= $pass   fail= $fail"
