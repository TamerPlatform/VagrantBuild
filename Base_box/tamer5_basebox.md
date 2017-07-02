# Tamer5 base Box how to build

The Tamer5 base box is build with following steps.

1. Default debian 9 netinstall.
    2. no root password
    3. android:tamer credentials + sudo access with NOPASSWD
    3. install build-essentials dkms, and kernel headers
    4. as listed in https://www.vagrantup.com/docs/virtualbox/boxes.html

2. Cleanup
    3. sudo apt-get autoremove
    4. cleanup packages
    5. sudo apt-get install localepurge (only keep en_US, en_UTF)
    6. standard Cleanup scripts like
    ```
    sudo apt-get clean -y
    sudo apt-get autoclean -y
    sudo rm -rf /usr/src/vboxguest*
    sudo rm -rf /usr/share/doc
    sudo find /var/cache -type f -exec rm -rf {} \;
    
    sudo umount /vagrant
    sudo rm -rf /usr/src/linux-headers*
    sudo rm -rf /usr/share/locale/{af,an,am,ar,ary,as,ast,az,bal,be,bg,bn,bn_IN,bo,br,bs,byn,ca,ca@valencia,ckb,cr,crh,cs,csb,cv,cy,da,de,de_AT,dv,dz,el,en_AU,en_CA,en_GB,eo,es,et,et_EE,eu,fa,fa_AF,fi,fil,fo,fr,frp,fur,fy,ga,gd,gez,gl,gu,gv,haw,he,hi,hr,ht,hu,hy,id,is,it,ja,jv,ka,kk,km,kn,ko,kok,ku,ky,lb,lg,ln,lt,lo,lv,mg,mhr,mi,mk,ml,mn,mr,ms,mt,my,nb,nds,ne,nl,nn,no,nso,oc,or,os,pa,pam,pl,ps,pt,pt_BR,qu,ro,ru,rw,sc,sd,shn,si,sk,sl,so,sq,sr,sr*latin,sv,sw,ta,te,th,ti,tig,tk,tl,tr,trv,tt,ug,uk,ur,urd,uz,ve,vec,vi,wa,wal,wo,xh,zh,zh_HK,zh_CN,zh_TW,zu}
    ```

    7. once all clean lets cleanup slack space
    ```
       $ sudo dd if=/dev/zero of=zerofill bs=1M
       $ sudo rm zerofill
       $ history -c
       $  sudo shutdown -h now
    ```
    9.  On your base machine following commands in folder where all your vmdk files are present
    10.  Clear snapshots
```
    vagrant snapshot list
    vagrant snapshot delete ...
```
    11. reduce disk utilization
```
    VBoxManage clonehd box-disk1.vmdk box-disk1.vdi --format vdi
    VBoxManage modifyhd box-disk1.vdi --compact
    del box-disk1.vmdk
```
    12. at this point go to virtualbox and release and remove the vmdk file from the media manager. then follow below steps
```
    VBoxManage clonehd box-disk1.vdi box-disk0.vmdk --format vmdk
    del box-disk1.vdi
```
    12. Finally box is extracted for upload on the server
```
vagrant package --base <vm_name> --output <vm_name>.box
```


Note: this resulted in overall decrease of box size from 900+MB to ~360MB. 