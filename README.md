NodeMCU y MicroPython
===============

Mis aproximaciones a NodeMCU (Amica / Lolin ) con uPy.

##Ambiente de desarrollo
El desarrollo se realiza utilizando Geany en Linux Debian.

1. Obtener el SDK para ESP8266 (https://github.com/pfalcon/esp-open-sdk)

2. Obtener MicroPython (https://github.com/micropython/micropython) y seguir las indicaciones en README.md del directorio principal y de esp8266

3. Flashear el firmware. En particular utilizo un script como el siguiente (earse_flash asegura que se borren los datos de la conexión WiFi):
    ```
    PORT=/dev/ttyUSB0
    SPEED=230400

    esptool.py -p $PORT -b $SPEED erase_flash && \
    esptool.py -p $PORT -b $SPEED write_flash  0x00000 ./MicroPython/esp8266/build/firmware-combined.bin -fs 32m -fm dio -ff 40m && \
    esptool.py -p $PORT -b $SPEED verify_flash 0x00000 ./MicroPython/esp8266/build/firmware-combined.bin
    ```

## Interactuar con uPy

1. Acceder a la consola con algún software tipo terminal (putty, etc.). Yo utilizo screen:
![](Images/screen.png "" "width:300px;")![](Images/boot.png "" "width:300px;")
2. Ya es posible experimentar con uPy desde aquí. Cuando se inicia se intenta ejecutar `boot.py` (actualmente levanta el módulo web de REPL) y luego `main.py` que no existe y es donde deberiamos dejar nuestro código para que se ejecute cada vez
![](Images/boot_py.png "" "width:300px;")
3. Desde consola es interesante ir probando diferentes comandos para experimentar, sin embargo cuando se tienen muchas líneas de código o se desea grabar un script el proceso no es simple. El cmando `help()` nos muestra una interesante opcíon:
![](Images/help.png "" "width:300px;")
4. Presionando `CTRL-E`en una línea en blanco entra en modo `PASTE` en donde podemos pegar código copiado desde algún otro lugar (ej. Geany). Finalizamos con `CTRL-D' retornando así al modo REPL
![](Images/paste.png "" "width:300px;")

5. He tenido problemas pegando código que supera 1Kb al no tener control de flujo. Por ahora es apropiado para enviar código peqieño y poder experimentar
6. Para enviar archivos utilizaba ESPlorer, pero mi editor de preferencia es Geany por lo cual me hice un script en LUA que se encuentra en el directorio `tools\`. Se deberá instalar el plugin de LUA para Geany y copiar el script a `.config/geany/plugins/geanylua`
![](Images/plugin.png "" "width:300px;")
![](Images/filtered.png "" "width:300px;")
7. Finalmente pegar el código transformado utilizando el modo `PASTE`



***
##Historia
* Jun 05, 2016: Implementa plugin en LUA para facilitar grabación de archivos en uPy
* Jun 04, 2016: Prepara ambiente de trabajo para compilar y generar las imágenes de uPy, así grabarlas en el NodeMCU

