/* TOMADO DE http://totaki.com/poesiabinaria/  */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>       /* round() */

typedef struct bmpFileHeader
{
  uint32_t size;
  uint16_t resv1;
  uint16_t resv2;
  uint32_t offset;
} bmpFileHeader;

typedef struct bmpInfoHeader
{
uint32_t headersize;      /* DIB header size */
  uint32_t width;
  uint32_t height;
uint16_t planes;         /* color planes */
uint16_t bpp;            /* bits per pixel */
  uint32_t compress;
  uint32_t imgsize;     
uint32_t bpmx;        /* X bits per meter */
uint32_t bpmy;        /* Y bits per meter */
uint32_t colors;      /* colors used */
uint32_t imxtcolors;      /* important colors */
} bmpInfoHeader;

void SaveBMP(char *filename, bmpInfoHeader *info, unsigned char *imgdata);
unsigned char calculaColorMedio(unsigned char *pixel);
unsigned char *LoadBMP(char *filename, bmpInfoHeader *bInfoHeader);
bmpInfoHeader *createInfoHeader(unsigned w, unsigned h, unsigned ppp);


int main()
{
  bmpInfoHeader info;  
  unsigned char *img;
  unsigned char color[3];
  unsigned char media;
  char bandera = 0;
  int contador = 0;


  int i, j;
  char opcion;

/* CARGA UNA IMAGEN BMP */
  img=LoadBMP("entrada.bmp", &info);

/* MENU PRINCIPAL */
  printf("************************************* \n");
  printf("MARATON DE PROGRAMACION YO C ? \n");
  printf("1, Imagen 1 (Ejemplo: genera pinguino en blanco y negro)\n");
  printf("2, Imagen 2 (Ejemplo: genera imagen completamente blanca)\n");
  printf("3, Imagen 3 (Ejemplo: genera imagen con linea vertical blanca, luego negra etc.\n");
    printf("4, Imagen 4 imagen con lineas blancas y negras\n");

    printf("DIGITE LA OPCION DESEADA \n");
    scanf("%c",&opcion);
    switch( opcion)
    {
case '1' :  /* CALCULA EL VALOR MEDIO DEL R G B   */	 
     for (i=0; i<info.height; i++)
     {
       for (j=0; j<info.width; j++)
       {
         media=calculaColorMedio(&img[3*(j+i*info.width)]);
         img[3*(j+i*info.width)]=media;
         img[3*(j+i*info.width)+1]=media;
         img[3*(j+i*info.width)+2]=media;
       }
     }
     break;

case '2' : 	/* CREA UNA IMAGEN COMPLETAMENTE NEGRA (R=0,G=0,B=0)  */
		/* CREA UNA IMAGEN COMPLETAMENTE BLANCA (R=255,G=255,B=255)  */
     for (i=0; i<info.height; i++)
     {
       for (j=0; j<info.width; j++)
       {
        img[3*(j+i*info.width)]=255;
        img[3*(j+i*info.width)+1]=255;
        img[3*(j+i*info.width)+2]=255;
      }
    }
    break;

case '3' :       /* Linea negra - linea blanca  */
    for (i=0; i<info.height; i++)
    {
     for (j=0; j<info.width; j++)
     {
      if (j%2==0)
      {
        img[3*(j+i*info.width)]=255;
        img[3*(j+i*info.width)+1]=255;
        img[3*(j+i*info.width)+2]=255;
      }
      else
      {
        img[3*(j+i*info.width)]=0;
        img[3*(j+i*info.width)+1]=0;
        img[3*(j+i*info.width)+2]=0;
      }
    }
  }
  break;
case '4' :       /* Linea negra - linea blanca  */
  for (i=0; i<info.height; i++)
  {
   if(i<(info.height/2))
   {
    if (contador == 20)
    {
      contador = 0;
    }
    contador ++;
  }

  for (j=0; j<info.width; j++)
  {
    if(i>(info.height/2))
    {
      if (j%10==0)
      {
        bandera = bandera^1;
      }
      if (bandera==1)
      {
        img[3*(j+i*info.width)]=255;
        img[3*(j+i*info.width)+1]=255;
        img[3*(j+i*info.width)+2]=255;
      }
      else
      {
        img[3*(j+i*info.width)]=0;
        img[3*(j+i*info.width)+1]=0;
        img[3*(j+i*info.width)+2]=0;
      }
    }
    else
    {
      if (contador<10)
      {
        img[3*(j+i*info.width)]=255;
        img[3*(j+i*info.width)+1]=255;
        img[3*(j+i*info.width)+2]=255;
      }
      else
      {
        img[3*(j+i*info.width)]=0;
        img[3*(j+i*info.width)+1]=0;
        img[3*(j+i*info.width)+2]=0;
      }
    }

  }
}
break;
  case '5' :       /* Linea negra - linea blanca  */
for (i=0; i<info.height; i++)
{
  for (j=0; j<info.width; j++)
  {
    if(i%2==0)
    {
      if (j%2==0)
      {
        img[3*(j+i*info.width)]=255;
        img[3*(j+i*info.width)+1]=255;
        img[3*(j+i*info.width)+2]=255;
      }
      else
      {
        img[3*(j+i*info.width)]=0;
        img[3*(j+i*info.width)+1]=0;
        img[3*(j+i*info.width)+2]=0;
      }
    }
    else
    {
      if (j%2!=0)
      {
        img[3*(j+i*info.width)]=255;
        img[3*(j+i*info.width)+1]=255;
        img[3*(j+i*info.width)+2]=255;
      }
      else
      {
        img[3*(j+i*info.width)]=0;
        img[3*(j+i*info.width)+1]=0;
        img[3*(j+i*info.width)+2]=0;
      }
    }
  }
}
break;


}


/* GUARDA LA IMAGEN BMP*/
SaveBMP("salida.bmp", &info, img);
free(img);

}

unsigned char calculaColorMedio(unsigned char *pixel)
{
  unsigned media = (*pixel + *(pixel+1) + *(pixel+2)) / 3;

  return (unsigned char) media;
}

unsigned char *LoadBMP(char *filename, bmpInfoHeader *bInfoHeader)
{

  FILE *f;
  bmpFileHeader header;
  unsigned char *imgdata;
  uint16_t type;
  f=fopen (filename, "r");
/* handle open error */
  fread(&type, sizeof(uint16_t), 1, f);
  if (type !=0x4D42)
  {
    fclose(f);
    return NULL;
  }
  fread(&header, sizeof(bmpFileHeader), 1, f);

  printf ("size: %u\n", header.size);
  printf ("offs: %u\n", header.offset);
  fread(bInfoHeader, sizeof(bmpInfoHeader), 1, f);
  printf ("header size:      %d\n", bInfoHeader->headersize);
  printf ("image width:      %d\n", bInfoHeader->width);
  printf ("image height:     %d\n", bInfoHeader->height);
  printf ("colour planes:    %d\n", bInfoHeader->planes);
  printf ("bpp:              %d\n", bInfoHeader->bpp);
  printf ("compress:         %d\n", bInfoHeader->compress);
  printf ("imgage size:      %d\n", bInfoHeader->imgsize);
  printf ("bpmx:             %d\n", bInfoHeader->bpmx);
  printf ("bpmy:             %d\n", bInfoHeader->bpmy);
  printf ("colors:           %d\n", bInfoHeader->colors);
  printf ("important colors: %d\n", bInfoHeader->imxtcolors);
  imgdata=(unsigned char*)malloc(bInfoHeader->imgsize);
  fseek(f, header.offset, SEEK_SET);
  printf("leido: %d\n", fread(imgdata, bInfoHeader->imgsize,1, f));
  fclose(f);

  return imgdata;
}

bmpInfoHeader *createInfoHeader(unsigned w, unsigned h, unsigned ppp)
{
  bmpInfoHeader *ih = malloc(sizeof(bmpInfoHeader));

  ih->headersize=sizeof(bmpInfoHeader);
  ih->width=w;
  ih->height=h;
  ih->planes=1;
  ih->bpp=24;
  ih->compress=0;
ih->imgsize=w*h*3;        /* 3 bytes por pixel w*h pixels */
  ih->bpmx=(unsigned)round((double)ppp*100/2.54);
ih->bpmy=ih->bpmx;        /* Misma resolución vertical y horiontal */
  ih->colors=0;
  ih->imxtcolors=0;

  return ih;
}

void SaveBMP(char *filename, bmpInfoHeader *info, unsigned char *imgdata)
{
  bmpFileHeader header;
  FILE *f;
  uint16_t type;

  f=fopen(filename, "w+");
  header.size=info->imgsize+sizeof(bmpFileHeader)+sizeof(bmpInfoHeader);
/* header.resv1=0; */
/* header.resv2=1; */
/* El offset será el tamaño de las dos cabeceras + 2 (información de fichero)*/
  header.offset=sizeof(bmpFileHeader)+sizeof(bmpInfoHeader)+2;
/* Escribimos la identificación del archivo */
  type=0x4D42;
  fwrite(&type, sizeof(type),1,f);
/* Escribimos la cabecera de fichero */
  fwrite(&header, sizeof(bmpFileHeader),1,f);
/* Escribimos la información básica de la imagen */
  fwrite(info, sizeof(bmpInfoHeader),1,f);
/* Escribimos la imagen */
  fwrite(imgdata, info->imgsize, 1, f);
  fclose(f);
}
