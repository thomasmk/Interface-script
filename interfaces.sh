#!/bin/bash

#reiniciar o serviço e checa versão do OS 

os=$(cat /etc/*-release | grep ^'ID'=deb* | awk -F= '{print $2}')
 
if [ $os == 'debian' ]; then


	
#backup do arquivo de configuração de de rede no Debian  usando caminhos absolutos 
cp /etc/network/interfaces  /etc/network/interfaces.old

echo "Digite a interface de rede"
read interface
echo "Digite novamente a interface de rede"
read interface2 
echo -e "auto $interface " > /etc/network/interfaces
echo -e  "iface $interface2 inet static \n " >> /etc/network/interfaces

echo "Digite um IP"
read ip
echo "Digite o Broadcast"
read broadcast
echo "Digite uma mascara"
read netmask
echo "Digite o Gateway"
read gateway
echo "Digite o dns "
read dns

clear 

echo -e "address $ip \n  " >> /etc/network/interfaces 
echo -e "broadcast $broadcast \n  " >> /etc/network/interfaces
echo -e "netmask $netmask \n  " >> /etc/network/intefaces
echo -e "gateway  $gateway \n " >> /etc/network/interfaces
echo -e "dns $dns    \n     " >> /etc/network/interfaces

echo "o Serviço esta sendo reiniciado"

service networking restart 


#mostra configuração final do arquivo

cat /etc/network/interfaces

else  #mesmo procedimento porém com CentOS

cp /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0.old


echo "Digite a interface de rede"
read interface
#echo "Digite novamente a interface de rede"
#read interface2

echo "Digite um IP"
read ip
echo "Digite o Broadcast"
read broadcast
echo "Digite uma mascara"
read netmask
echo "Digite o Gateway"
read gateway
echo "Digite o dns "
read dns
echo   "TYPE=Ethernet" > /etc/sysconfig/network-scripts/ifcfg-eth0
echo   "BOOTPRO=static" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo   "IPADDR=$ip" >>     /etc/sysconfig/network-scripts/ifcfg-eth0
echo   "NETMASK=$netmask" >>/etc/sysconfig/network-scripts/ifcfg-eth0
echo   "DEFROUTE=yes" >>    /etc/sysconfig/network-scripts/ifcfg-eth0
echo   "DEVICE=$interface ">> /etc/sysconfig/network-scripts/ifcfg-eth0
echo   "PEERDNS=yes"	    >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo   "PEERROUTES=yes"    >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo   "ONBOOT=yes"         >> /etc/sysconfig/network-scripts/ifcfg-eth0


#configuracao de DNS antes de reiniciar o serviço

cp /etc/resolv.conf /etc/resolv.conf.old

echo "192.168.1.1" > /etc/resolv.conf
echo "8.8.8.8" 	   >> /etc/resolv.conf
echo "8.8.8.8"     >> /etc/resolv.conf

cat /etc/sysconfig/network-scripts/ifcfg-eth0
sleep 3
clear

echo "O serviço de rede vai ser reiniciado agora"
sleep 3
clear 

systemctl restart network 

echo ping -c3 www.google.com

clear 

fi


