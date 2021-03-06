#ESTE SCRIPT PERMITE LA DESCARGA DE DATOS DIARIOS DE PRECIPITACI�N Y TEMPERATURA
#SE DEBE TENER CUENTA DE ACCESO AL PORTAL https://urs.earthdata.nasa.gov/
#PRIMERO SE DEBE HACER UNA CONSULTA EN EL PORTAL https://urs.earthdata.nasa.gov/ CON LA INFORMACI�N
#QUE CONTENGA EL M�TODO DE DESCARGA, EL RANGO DE FECHAS, LA REGI�N, Y LAS VARIABLES A DESCARGAR
#ES NECESARIO CONFIGURAR PREVIAMENTE EL METODO WGET EN EL COMPUTADOR
#NOTA: LAS CORDENADAS DE DESCARGA EN ESTE EJEMPLO SON PARA COLOMBIA


#**Credenciales para la autenticaci�n**#
#Previamente se debe tener usuario y contrase�a registrados en:
#https://urs.earthdata.nasa.gov/
NASA_user <- 'XXXXXXXXX'
NASA_pw <- 'XXXXXXXXX'

#**Manejo de librer�as**#
#Instalaci�n de ,ibrer�as necesarias, 
#s�lo se debe hacer una �nica vez, se instala para el sistema
install.packages("ncdf4")

#Cargar las librer�as necesarias para correr el progerama
#Se debe hacer siempre que se abra R
library(ncdf4)#Librer�a para manejo de archivos .nc4

#**Descargar los datos de la Nasa**#

#Descargar datos desde 1948 a 1999 (version 2.0)
path_base <- 'http://hydro1.gesdisc.eosdis.nasa.gov/daac-bin/OTF/HTTP_services.cgi?FILENAME=%2Fdata%2FGLDAS%2FGLDAS_NOAH025_M.2.0%2F'
#view-source:https://hydro1.gesdisc.eosdis.nasa.gov/data/GLDAS/GLDAS_NOAH025_M.2.0/
#path_base corresponde a la ruta donde se encuentran las carpetas.
path_base2 <- '%2FGLDAS_NOAH025_M.A'
path_base3 <- '.020.nc4&FORMAT=bmM0Lw&BBOX='

concatenateParams <- '%2C'

#Regi�n espacial para definir las coordenadas

#---> IMPORTANTE: Las coordenadas debe estar en el siguiente orden:
#Latitud sur, Longitud oeste, latitud norte, longitud este.
#Coordenadas Colombia
refineSpatialRegion <- c('-4.638', '-82.222', '16.808', '-66.313')
#Coordenadas Latinoam�rica
#refineSpatialRegion <- c('-56.085', '-134.648', '38.837', '-19.336')


path_base4 <- '&LABEL=GLDAS_NOAH025_M.A'

path_base5 <- '.020.nc4.SUB.nc4&SHORTNAME=GLDAS_NOAH025_M&SERVICE=L34RS_LDAS&VERSION=1.02&DATASET_VERSION=2.0&VARIABLES='

#Variables que se van a descargar
variables <- c("Rainf_f_tavg","Tair_f_inst")

#Directorio donde se va a guardar los archivos descargados
save_directory_path <- 'D:/Disco 1Tb/clases/UDES/scripts_nasa/P&T mensual/descarga/'

#Rango de los datos por a�o
years <- 1948:1999

#Rango de los datos por mes
months <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')

#Ciclos para descargar archivo por archivo mes a mes, a�o a a�o.
for (year in years) {
  for (month in months) {
    url <- paste(path_base, year, path_base2, year, month, "", sep = "")
    
    #Nombre con el que se guardar� el archivo en el pc
    file_name_disk <- paste(variables[c(1)], variables[c(2)], year, month, ".nc4", sep = "")
    
    file_data <- paste(path_base3, refineSpatialRegion[c(1)], concatenateParams, refineSpatialRegion[c(2)], concatenateParams, refineSpatialRegion[c(3)], 
                       concatenateParams, refineSpatialRegion[c(4)], path_base4, year, month, path_base5, variables[c(1)], concatenateParams, variables[c(2)], sep = "")
    
    #url final que ser� descargada
    url_file <- paste(url, file_data, sep = "")
    
    #<----- Descargar desde otro repositorio SIN OPCI�N Subset-Get Data. Lo que no se encuentra comentado funciona cuando existe la opci�n Subset-Get Data ----->#
    #file_name <-paste0("MOD13C2.A",year,month,".006.2015147122546.hdf")
    #file_name_disk <- file_name
    #url_file <- paste0(path_base,"/",year,".",month,".01/",file_name)
    #print(url_file)
    #Funci�n con el m�todo wget para descargar el archivo de la Nasa
    download.file(url = url_file,
                  destfile = paste(save_directory_path, file_name_disk, sep = ""),
                  method = 'wget',
                  extra = paste('--load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies --user=', NASA_user, ' --password=', NASA_pw, ' --content-disposition', sep = ""))
  }
}


#Descargar datos desde 2000 a 2018 (version 2.1)
path_base <- 'http://hydro1.gesdisc.eosdis.nasa.gov/daac-bin/OTF/HTTP_services.cgi?FILENAME=%2Fdata%2FGLDAS%2FGLDAS_NOAH025_M.2.1%2F'
path_base2 <- '%2FGLDAS_NOAH025_M.A'
path_base3 <- '.021.nc4&FORMAT=bmM0Lw&BBOX='

concatenateParams <- '%2C'

#Regi�n espacial para definir las coordenadas
refineSpatialRegion <- c('-4.638', '-82.222', '16.808', '-66.313')

path_base4 <- '&LABEL=GLDAS_NOAH025_M.A'

path_base5 <- '.021.nc4.SUB.nc4&SHORTNAME=GLDAS_NOAH025_M&SERVICE=L34RS_LDAS&VERSION=1.02&DATASET_VERSION=2.1&VARIABLES='

#Variables que se van a descargar
variables <- c("Rainf_f_tavg","Tair_f_inst")

#Directorio donde se va a guardar los archivos descargados
save_directory_path <- 'D:/Disco 1Tb/clases/UDES/scripts_nasa/P&T mensual/descarga/'

#Rango de los datos por a�o
years <- 2000:2018

#Rango de los datos por mes
months <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')

#Ciclos para descargar archivo por archivo mes a mes, a�o a a�o.
for (year in years) {
  for (month in months) {
    url <- paste(path_base, year, path_base2, year, month, "", sep = "")
    
    #Nombre con el que se guardar� el archivo en el pc
    file_name_disk <- paste(variables[c(1)], variables[c(2)], year, month, ".nc4", sep = "")
    
    file_data <- paste(path_base3, refineSpatialRegion[c(1)], concatenateParams, refineSpatialRegion[c(2)], concatenateParams, refineSpatialRegion[c(3)],
                       concatenateParams, refineSpatialRegion[c(4)],path_base4, year, month, path_base5, variables[c(1)], concatenateParams, variables[c(2)], sep = "")
    
    #url final que ser� descargada
    url_file <- paste(url, file_data, sep = "")
    
    #Funci�n con el m�todo wget para descargar el archivo de la Nasa
    download.file(url = url_file,
                  destfile = paste(save_directory_path, file_name_disk, sep = ""),
                  method = 'wget',
                  extra = paste('--load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies --user=', NASA_user, ' --password=', NASA_pw, ' --content-disposition', sep = ""))
    
  }
}
