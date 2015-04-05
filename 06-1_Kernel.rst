Kernel anpassen
===============
* Arbeitsverzeichnis erstellen und reinwechseln

  * mkdir uebung && cd uebung

* auf kernel.org gehen und URL des letzer kernels notiern
* Kernel runterladen

  * wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.19.3.tar.xz

* Kernel auspacken

  * tar xJvf linux-3.19.3.tar.xz

* ins kernel sourec Verzeichnis wechseln

  * cd linux-3.19.3

* Abhängikeiten des Kernel Builds installieren:

  * apt-get install ncurses-dev pkg-config bc gcc libc6-dev make bzip2 binutils

* Kernel konfigurieren

  * make menuconfig
  * so viel unnötiges wie mögliche weg-konfigurieren, damit Build kürzer ist
  * VirtualBox Netzwerk-Karte ist Intel PRO/1000

* vim +432 arch/x86/boot/compressed/misc.c # Meldung frei anpassen
* Debian Paket des Kernels bauen

  * make deb-pkg
  * dauert lange
