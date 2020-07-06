#ESTE SCRIPT PERMITE LA DESCARGA DE DATOS DIARIOS DE PRECIPITACIÓN Y TEMPERATURA
#SE DEBE TENER CUENTA DE ACCESO AL PORTAL NASA GIOVANNI
#PRIMERO SE DEBE HACER UNA CONSULTA EN EL PORTAL DE NASA GIOVANI Y GENERAR UN ARCHIVO .CSV CON LA INFORMACIÓN
#QUE CONTENGA EL MÉTODO DE DESCARGA, EL RANGO DE FECHAS, LA REGIÓN, Y LAS VARIABLES A DESCARGAR
#ES NECESARIO CONFIGURAR PREVIAMENTE EL METODO WGET EN EL COMPUTADOR
#NOTA: LAS CORDENADAS DE DESCARGA EN ESTE EJEMPLO SON PARA COLOMBIA


NASA_user <- 'XXXXXXXX'
NASA_pw <- 'XXXXXXXXXX'

#-----------------------------VARIABLES A MODIFICAR--------------------------------------------------------------------------------------------

directorio_save <- "D:/jd/clases/UDES/scripts/nasa/script semanal/descargas/"

#OJO MUY CLAVE posicion del nombre en el archivo de urls
posicion_inicial_nombre_en_url = 159
posicion_final_nombre_en_url = 170

#----------------------------------------------------------------------------------------------------------------------------------------------


listado = read.csv("D:/jd/clases/UDES/scripts/nasa/script semanal/subset_M2T1NXAER_5.12.4_20200706_031718.csv", sep=",", header=FALSE, stringsAsFactors=FALSE)
str(listado)

save_directory_path <-directorio_save

x <- length(listado[,1])
nombre <- c(1:x)

for(i in (1:x)){
  url = listado[i,1]
  nombre[i] <- substr(listado[i,1], posicion_inicial_nombre_en_url, posicion_final_nombre_en_url)
  #Función con el método wget para descargar el archivo de la Nasa
  download.file(url = url,
                destfile = paste(save_directory_path, nombre[i] , sep = ""),
                method = 'wget',
                extra = paste('--load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies --user=', NASA_user, ' --password=', NASA_pw, ' --content-disposition', sep = ""))
  }


### Ciclo para asignación de Nombres
x <- length(listado[,1])
nombre <- c(1:x)
for(i in c(1:x)){
  nombre[i] <- substr(listado[i,1], posicion_inicial_nombre_en_url, posicion_final_nombre_en_url)
}
View(nombre)


