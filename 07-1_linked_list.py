#!/usr/bin/python3

# sauberere Implementation?

#     from __future__ import annotations # erlaubt Selbstreferenz ("Node")
#     from dataclasses import dataclass
#     
#     @dataclass
#     class Node:
#         next:    Node
#         content: str

class Node:
    def __init__( self, next_node, content_):
        self.next = next_node
        self.content = content_


erster_knoten = Node(None, "das ist ein Knoten, der heisst Persepolis")

linked_list = erster_knoten

zweiter_knoten = Node(None, "anderer Knoten, Hanspeter")
dritter_knoten = Node(None, "Monika")

linked_list.next = zweiter_knoten
linked_list.next.next = dritter_knoten

# iterate through the list
node = linked_list
while( True ):
    print(node.content)
    node = node.next
    if node == None:
        print("we have reached the end of the linked list")
        break

