
  PROGRAM

  MAP
    MODULE('Win32')      
      API_ODS(*CSTRING),RAW,PASCAL,NAME('OutputDebugStringA')
    END   
    SQLODS(STRING)
  END
  
gMSSQLOwner   STRING(255)  
  
MSSQLTable           FILE,DRIVER('MSSQL','/TURBOSQL=TRUE /BUSYRETRIES=200 /MULTIPLEACTIVERESULTSETS=TRUE /BUSYHANDLING=2'),OWNER(gMSSQLOwner),NAME('dbo.company'),PRE(MS),BINDABLE,THREAD !                     
Record                   RECORD,PRE()
Sysid                       LONG
                         END
                     END   

  CODE
  
  SQLODS('Starting')  

  SYSTEM{PROP:DriverTracing} = '1'
  MSSQLTable{PROP:TraceFile} = 'DEBUG:'
  MSSQLTable{PROP:Details}   = 1  
  MSSQLTable{PROP:Profile}   = 'DEBUG:' 
  MSSQLTable{PROP:LogSQL}    = 1
  
  gMSSQLOwner = 'put your owner string here'   ! commonly used: 'serverip,databasename,username,password'
  SHARE(MSSQLTable)
  MSSQLTable{PROP:SQL} = 'select count(*) from sys.tables'
  NEXT(MSSQLTable)
  MESSAGE('I found ' & MSSQLTable.Sysid & ' tables.')
  CLOSE(MSSQLTable)  
  SQLODS('Done')
  RETURN 
  
!-------------------------------------------------------------------------------
SQLODS              PROCEDURE(STRING pText)         ! allows passing a string to ODS
!-------------------------------------------------------------------------------
db          CSTRING(8193)
intRegDebug LONG 

 CODE                                                    

 DB = '[SQLODS] ' &  CLIP(pText) & '<13,10,0>'
 API_ODS(DB)
 RETURN 