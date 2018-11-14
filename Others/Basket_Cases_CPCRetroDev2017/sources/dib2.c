/*-+ extremely quick and dirty DIB to CPC MODE 0+1+2 graphics encoder +-*/
/*-+ written by CNGSOFT for his personal projects a looooong time ago +-*/

#include <stdio.h>
#include <string.h>

FILE *fi,*fo; unsigned char tt[200],ti[100],to[100],bi[1<<16],bo[1<<16],*s,*t,xlat[1<<8];
int encoding=0,mulx=2,muly=2,bx,by,px,py,lx,ly,tx,ty,ttx,tty,gray;
int grayjump[8]={+1,+2,-1,+4,+1,-2,-1,+4},grayturn; // 0,1,3,2,6,7,5,4: set 3,h.. set 4,h.. res 3,h.. set 5,h.. set 3,h.. res 4,h.. res 3,h.. res 5,h

int readint()
{
	unsigned char c; int n=0,t=0;
	while ((c=*s++)=='-')
		n=1;
	do
	{
		t=t*10+(c-48);
	}
	while (((c=*s++)>='0')&&(c<='9'));
	if (n)
		t=-t;
	return t;
}

int main(int argc,char *argv[])
{
	int i=1,status=0; char *c;
	ti[0]=to[0]=0;
	while (i<argc)
	{
		if (!strcmp(argv[i],"-m"))
			encoding=atoi(argv[++i]);
		else if (!strcmp(argv[i],"-x"))
			mulx=atoi(argv[++i]);
		else if (!strcmp(argv[i],"-y"))
			muly=atoi(argv[++i]);
		else if (!ti[0])
			strcpy(ti,argv[i]);
		else if (!to[0])
			strcpy(to,argv[i]);
		else
			status=1;
		i++;
	}
	if (status||!ti[0])
	{
		puts("syntax: DIB2 [-m MODE] [-x MULX] [-y MULY] source[.dib] [target[.grf]]");
		return 1;
	}
	switch (encoding)
	{
		case 0:
			for (i=0;i<256;i++)
				xlat[i]=((i&1)<<6)+((i&2)<<1)+((i&4)<<2)+((i&8)>>3)+
					((i&16)<<3)+((i&32)>>2)+((i&64)>>1)+((i&128)>>6);
			break;
		case 1:
			for (i=0;i<256;i++)
				xlat[i]=((i&1)<<4)+((i&2)>>1)+
					((i&4)<<3)+((i&8)>>2)+
					((i&16)<<2)+((i&32)>>3)+
					((i&64)<<1)+((i&128)>>4);
			break;
		case 2:
		default:
			break;
	}
	if (!to[0])
		strcpy(to,ti);
	if ((!(c=strrchr(ti,'.')))||c<strrchr(ti,'\\'))
		strcat(ti,".dib");
	if ((!(c=strrchr(to,'.')))||c<strrchr(to,'\\'))
		strcat(to,".grf");
	if (fi=fopen(ti,"rb"))
	{
		if (fo=fopen(to,"wb"))
		{
			fread(bo,1,10+4,fi);
			i=bo[10]+bo[11]*256-(10+4);
			fread(bo,1,i,fi);
			bx=bo[4]+bo[5]*256;
			by=bo[8]+bo[9]*256;
			int x,y;
			while (by--)
			{
				t=bi+by*256; // UPSIDE DOWN!
				fread(s=bo,1,bx,fi);
				x=bx;
				switch (encoding)
				{
					case 0:
						while (x)
						{
							i=(15&*s++)<<4;
							i+=15&*s++;
							*t++=xlat[i];
							x-=2;
						}
						break;
					case 1:
						while (x)
						{
							i=(3&*s++)<<6;
							i+=(3&*s++)<<4;
							i+=(3&*s++)<<2;
							i+=3&*s++;
							*t++=xlat[i];
							x-=4;
						}
						break;
					case 2:
						while (x)
						{
							i=(1&*s++)<<7;
							i+=(1&*s++)<<6;
							i+=(1&*s++)<<5;
							i+=(1&*s++)<<4;
							i+=(1&*s++)<<3;
							i+=(1&*s++)<<2;
							i+=(1&*s++)<<1;
							i+=1&*s++;
							*t++=i;
							x-=8;
						}
						break;
					default:
						break;
				}
			}
			//FILE *ff=fopen("temp","wb"); fwrite(bi,256,256,ff); fclose(ff);
			t=bo;
			while (gets(s=tt))
				if (*s>='0'&&*s<='9')
				{
					px=readint();
					py=readint();
					lx=readint();
					ly=readint();
					tx=readint();
					ty=readint();
					if (lx>0)
						gray=0;
					else
					{
						lx=-lx;
						gray=1;
					}
					for (tty=0;tty<ty;tty++)
						for (ttx=0;ttx<tx;ttx++)
						{
							if ((by=ly*muly)>0)
							{
								y=(py+ly*tty)*muly;
								grayturn=0;
								while (by--)
								{
									s=bi+y*256+(px+lx*ttx)*mulx;
									x=lx*mulx;
									while (x--)
										*t++=*s++;
									if (gray)
										y+=grayjump[grayturn++&7];
									else
										y++;
								}
							}
							else
							{
								y=(py-ly*tty-ly)*muly-1;
								grayturn=0;
								while (by++)
								{
									s=bi+y*256+(px+lx*ttx)*mulx;
									x=lx*mulx;
									while (x--)
										*t++=*s++;
									if (gray)
										y-=grayjump[grayturn++&7];
									else
										y--;
								}
							}
						}
				}
			fwrite(bo,1,t-bo,fo);
			fclose(fo);
		}
		else
		{
			puts("Error: cannot create target!");
			status=1;
		}
		fclose(fi);
	}
	else
	{
		puts("Error: cannot open source!");
		status=1;
	}
	return status;
}
