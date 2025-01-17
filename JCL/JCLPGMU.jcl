 //REPORT01 JOB (PGMUNIVE),                              
 //             'EJECUTA PGMUNIVE',                      
 //             CLASS=A,                                 
 //             MSGCLASS=H,                              
 //             REGION=8M,TIME=1440,                     
 //             NOTIFY=HERC01,                           
 //             MSGLEVEL=(1,1)                           
 //*                                                     
 //*    PASO DE COMPILACIOM DEL PROGRAMA PGMUNIVE        
 //*                                                     
 //COMPILE  EXEC COBOL,                                  
 //             PROG='PGMUNIVE',                         
 //             PDSF='HERC01.PLATZI.SRC',                
 //             PDSL='HERC01.PLATZI.LOAD'                
 /*                                                      
 //*                                                     
 //*    OBJETIVO BORRA ARCHIVO DE TRABAJO                
 //*                                                     
 //PASO01   EXEC PGM=IEFBR14                             
 //SYSPRINT  DD DISP=(MOD,DELETE),                       
 //             DSN=HERC01.REPORTE.BECAS,                
 //             UNIT=3350,                               
 //             SPACE=(TRK,(0))                          
 /*                                                      
 //*                                                     
 //*    OBJETIVO BORRA ARCHIVO DE TRABAJO                
 //*                                                     
 //PASO02   EXEC PGM=IEFBR14                             
 //SYSPRINT  DD DISP=(MOD,DELETE),                       
 //             DSN=HERC01.ORDENA.ALUMNOS,               
 //             UNIT=3350,                               
 //             SPACE=(TRK,(0))                          
 /*                                                      
 //*                                                     
 //*    OBJETIVO RESPALDO DE ARCHIVO DE ENTRADA          
 //*                                                     
 //PASO03   EXEC PGM=IEBGENER,COND=(9,LT,PASO02)                   
 //SYSUT1    DD DSN=HERC01.ALUMNOS.BECAS,DISP=SHR                  
 //SYSUT2    DD DSN=HERC01.ORDENA.ALUMNOS,                         
 //             UNIT=3350,                                         
 //             VOL=SER=PUB010,                                    
 //             DCB=(*.SYSUT1),                                    
 //             SPACE=(TRK,(200)),                                 
 //             DISP=(,CATLG,DELETE)                               
 //SYSPRINT  DD SYSOUT=*                                           
 //SYSIN     DD DUMMY                                              
 /*                                                                
 //*                                                               
 //*    OBJETIVO EJECUTAR PROGRAMA QUE GENERA REPORTE DE BECADOS   
 //*                                                               
 //PASO04   EXEC PGM=PGMUNIVE,PARM='29032021',COND=(9,LT,PASO03)   
 //STEPLIB   DD DSN=HERC01.PLATZI.LOAD,DISP=SHR                    
 //SYSOUT    DD SYSOUT=*                                           
 //ALUMNO    DD DSN=HERC01.ALUMNOS.BECAS,DISP=OLD                  
 //REPORTE   DD DSN=HERC01.REPORTE.BECAS,                          
 //             DISP=(,CATLG,DELETE),                              
 //             UNIT=SYSDA,                                        
 //             SPACE=(TRK,(10,5),RLSE),                           
 //             DCB=(RECFM=FB,LRECL=80,BLKSIZE=27200)              
 /*      