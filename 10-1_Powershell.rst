Powershell
==========

Basierend auf dem "Powershell Tutorial":http://www.powershellpro.com/powershell-tutorial-introduction/
von Jesse Hamrick.

* output sind Objekte und nicht Text (im Gegensatz zu Unix Shells!)
* commandos sind `CmdLets`

:: 

    get-command
    get-command -Verb Get # alle Kommandos mit "Get" Verb anzeigen
                          # andere z.B. Add, Clear, New, and Set
    get-command -Type CmdLet ¦ sort-object noun ¦ format-table -group noun

Docu
====

::

    get-help  Kommando     # oder
    man       Kommando
    man -full Kommando 
    man -full Kommando ¦ format-list  # zeigt Infos in Listen Form an
    man -full Kommando ¦ format-list ¦ more
    help about_* ¦ more

Pipes
=====
Auf der Tastatur gibt's zwei 'Pipe' Zeichen, die gleich aussehen (können).
Eines davon ist falsch. Eines ist richtig. Hinweis: es ist nicht dasjenige,
das man im Unix verwendet...

History
=======
* Kommandozeilen Log: (Fn-)F7

Dienste
=======
* Get-Command -Noun Service
* Get-Service
* Start-Service ...


