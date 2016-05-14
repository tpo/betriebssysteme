/* mit -lpthread kompilieren! */

#include <stdio.h>    /* printf */
#include <pthread.h>  /* Thread Manipulation */

/* -------------------------------------- *
 * Pfanne Typ und Methoden                *
 *----------------------------------------*/
#define ESSEN 1
#define LEER (!ESSEN)
struct pfanne_s {
  char inhalt;
  pthread_mutex_t zugriff;
  pthread_cond_t  essen_bereit;
};

typedef struct pfanne_s pfanne_t;

void init_pfanne( pfanne_t* pfanne_p)
{
  pfanne_p->inhalt = LEER;
  pthread_mutex_init( &pfanne_p->zugriff, NULL);
  pthread_cond_init( &pfanne_p->essen_bereit, NULL);
}

void kochen( pfanne_t* pfanne_p)   {
  pfanne_p->inhalt = ESSEN;
  printf( "Papa: Essen ist fertig!\n");
}

void essen( pfanne_t* pfanne_p)   {
  pfanne_p->inhalt = LEER;
  printf( "Kind: Mmmh, das war lecker!\n");
}

/* -------------------------------------- *
 * Aktivitaeten von Papa und Kind         *
 *----------------------------------------*/
void arbeiten()
{
  printf("Papa: Working in the coal mine...");
  printf("done\n");
}

void spielen()  {}

/* pfanne_vp muss ein pfanne_t* sein */
void* papa_aktivitaet( void* pfanne_vp)
{
  pfanne_t* pfanne_p = (pfanne_t*)pfanne_vp;
  arbeiten();

  /* kochen */

    /* pfanne nehmen - zu wenig abstrahiert? */
    pthread_mutex_lock( &pfanne_p->zugriff);

      kochen( pfanne_p);
      pthread_cond_signal( &pfanne_p->essen_bereit);
       
    /* pfanne hinlegen*/
    pthread_mutex_unlock( &pfanne_p->zugriff);
}

/* pfanne_vp muss ein pfanne_t* sein */
void* kind_aktivitaet( void* pfanne_vp)
{
  pfanne_t* pfanne_p = (pfanne_t*)pfanne_vp;
  spielen();

  /* warten auf's essen */

     pthread_mutex_lock( &pfanne_p->zugriff);

       while( pfanne_p->inhalt != ESSEN) {
         printf("Kind: Hunger :-(!\n");
	 pthread_cond_wait( &pfanne_p->essen_bereit, &pfanne_p->zugriff);
       }
       essen( pfanne_p);
        
     pthread_mutex_unlock( &pfanne_p->zugriff);
}

main() {
  pthread_t papa;
  pthread_t kind;

  pfanne_t pfanne;
  init_pfanne( &pfanne);

  /* TODO: Fehler werden nicht behandelt... */
  pthread_create( &kind, NULL, kind_aktivitaet, &pfanne);
  pthread_create( &papa, NULL, papa_aktivitaet, &pfanne);

  /* Warten bis Kind und Papa ihre Aktivitäten erledigt haben */
  pthread_join( papa, NULL);
  pthread_join( kind, NULL);
}
