#include <stdio.h>  /* printf */
#include <stdlib.h> /* malloc */

/* ---------------------------------------------------------- *
 * linked list definition                                     *
 * ---------------------------------------------------------- */
struct node_s
{
  void* data;
  struct node_s* next;
};

typedef struct node_s node;

#define none NULL


node* new_node(void* data)
{
  node* a_node;
 
  /* TODO: error checking is missing */
  a_node = malloc(sizeof(node));
  a_node->data = data;
  a_node->next = none; /* what happens without this? */

  return a_node;
}

void traverse_list(node* linked_list, void act_on_data(void* data))
{
  node* current_node;

  for( current_node = linked_list;
       current_node != none;
       current_node = current_node->next )
  {
    act_on_data(current_node->data);
  }
}

void delete_list(node* linked_list, void free_data(void* data))
{
  node* current_node;
  node* next_node;

  for( current_node = linked_list;
       current_node != none;
       current_node = next_node )
  {
    next_node = current_node->next;
    free_data(current_node->data);
    free(current_node);
  }
}

/* ---------------------------------------------------------- *
 * Data specific functions                                    *
 * ---------------------------------------------------------- */
void print_data(void* data)
{
  printf("%s\n", data);
}

void free_data(void* data)
{
  /* we don't do anything for our data */
}

/* ---------------------------------------------------------- *
 * main                                                       *
 * ---------------------------------------------------------- */
main()
{
  char* text1 = "this is the first node";
  char* text2 = "this is the second node";

  node* linked_list;

  /* insufficient abstraction? */
  linked_list       = new_node(text1);
  linked_list->next = new_node(text2);

  /* print each node */
  traverse_list(linked_list, print_data);

  /* clean up */
  delete_list(linked_list, free_data);
}
