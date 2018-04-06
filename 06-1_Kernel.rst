Kernel anpassen
===============
* Arbeitsverzeichnis erstellen und reinwechseln

  * mkdir uebung && cd uebung

* auf kernel.org gehen und URL des aktuelsten Kernels notiern
* Kernel runterladen. Z.B.

  * wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.19.3.tar.xz

* Kernel auspacken

  * tar xJvf linux-3.19.3.tar.xz

* ins Kernel Quellcode-Verzeichnis wechseln

  * cd linux-3.19.3

* Abhängikeiten des Kernel Builds installieren:

  - unter Debian/Ubuntu/etc.
    * apt-get install ncurses-dev pkg-config bc gcc libc6-dev make bzip2 binutils dpkg-dev
  - unter Fedora/RedHat/CentOS/etc,
    * yum install bison flex bc rpm-build bc gcc make bzip2 # nicht getestet

* Kernel konfigurieren

  - eigenen Kernel konfigurieren
    * make menuconfig
    * so viel Unnötiges wie mögliche weg-konfigurieren, damit Bauzeit kürzer wird
    * VirtualBox Netzwerk-Karte ist Intel PRO/1000
  - minimalen Kernel konfigurieren
    * make tinyconfig

* vim +432 arch/x86/boot/compressed/misc.c
  - folgende Zeile einfügen:
    * __putstr("done.\nBooting Bumba Zumba OS.\n");
    * Meldung frei anpassen

* Paket des Kernels bauen

  - Debian
    * als root: make deb-pkg
    * dauert lange

  - rpm
    * als root: make binrpm-pkg
    * dauert lange
    * Paket ist unter /root/rpmbuild/RPMS/$ARCH/kernel-3.19.3-1.i386.rpm

* wenn nötig neuen Kernel in VM hineinkopieren

  * Parameter des folgenden Kommandos müssen an lokale Gegebenheiten
    angepasst werden:

  * scp -P 1234567 ../linux-image-3.19.3_3.19.3-1_amd64.deb localhost:/tmp

* neuen Kernel in VM installieren

  * cd /dorthin_wo_linux-image-3.19.3_3.19.3-1_amd64.deb_ist
    (entweder unter /tmp oder ../)

  * Debian
    - dpkg -i linux-image-3.19.3_3.19.3-1_amd64.deb

  * rpm
    * rpm -i kernel-4.16.0-1.i386.rpm
    * vim /etc/grub.d/40_custom
      * menu entry hinzufügen, analog zu /boot/grub2/grub.conf
    * grub2-mkconfig -o /boot/grub2/grub.cfg

* VM neustarten
