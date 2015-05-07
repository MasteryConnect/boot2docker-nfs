FROM boot2docker/boot2docker:latest
MAINTAINER Vrakfall <jeremy@artphotolaurent.be>

#Remove the vboxfs automount
RUN rm $ROOTFS/etc/rc.d/automount-shares && \
  WHITELINETOREMOVE=$(( $(sed -n -r '/\/etc\/rc.d\/automount-shares/ =' $ROOTFS/opt/bootscript.sh) + 1)) && \
  sed -i -r $WHITELINETOREMOVE'{/^$/d}' $ROOTFS/opt/bootscript.sh $ROOTFS/opt/bootscript.sh && \
  sed -i -r '/# Automount Shared Folders \(VirtualBox, etc\.\)/d' $ROOTFS/opt/bootscript.sh $ROOTFS/opt/bootscript.sh && \
  sed -i -r '/\/etc\/rc.d\/automount-shares/d' $ROOTFS/opt/bootscript.sh $ROOTFS/opt/bootscript.sh

#Add the nfs automount
RUN mkdir $ROOTFS/Users && \
  echo "192.168.59.3:/Users /Users nfs intr,rw,noatime,async,nfsvers=3,rsize=32768,wsize=32768,proto=tcp,timeo=14 0 0" >> $ROOTFS/etc/fstab && \
  echo "\n# Start the nfs client\n/usr/local/etc/init.d/nfs-client start" >> $ROOTFS/opt/bootscript.sh

#Start the iso maker script
RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
