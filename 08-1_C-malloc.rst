malloc, free und verkettete Listen
=================================

malloc
------

* malloc dient unter C dem Aquisition eines Stückes Speicher,
  den man dann frei beschreiben kann

* Der von malloc erhaltene Speicher liegt im *Heap*. Der Heap
  wird nicht wie der Stack bei Funktionsaufrufen auf- und
  abgebaut.

* Das heisst also, dass das von malloc erhaltene Speicherstück
  Funktionsaufrufe überdauert 

free
----

* free wird für die Rückgabe von nicht mehr gebrauchtem
  Speichers an das System verwendet.

* wenn man laufend Speicher via malloc alloziiert, aber
  nie mehr via free freigibt, dann hat das System weniger
  und weniger freien, noch zu vergebenden Speicher



Verkettete Listen
=================

Die Verkettete Liste ("linked list") ist eine fundamentaler,
oft benutzter Baustein der Informatik.

Eine verkette Liste besteht aus einzelnen Knoten, die miteinander
verknüpft sind. Knoten enthalten auch Nutzdaten.
