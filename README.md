NodeMCU y MicroPython
===============

Mis aproximaciones a NodeMCU (Amica / Lolin ) con MicroPython.

##Ambiente de desarrollo
El desarrollo es básicamemnte utilizando `Geany` como editor y `screen`como consola serial, todo en Linux Debian. Los siguientes pasos son los requeridos para tener el firmware corriendo en el NodeMCU:

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

## Primeros pasos con MicroPython

1. Acceder a la consola con algún software tipo terminal (putty, etc; yo utilizo screen):

	![](Images/screen.png "" "width:300px;")

	![](Images/boot.png "" "width:300px;")

2. Desde aquí ya es posible experimentar con MicroPython. Cuando se inicia se intenta ejecutar `boot.py` (que actualmente levanta el módulo web de REPL) y luego `main.py` (que no existe y es en donde deberiamos dejar nuestro código para que se ejecute):

	![](Images/boot_py.png "" "width:300px;")

3. Desde consola es interesante ir probando diferentes comandos para experimentar, sin embargo cuando se tienen muchas líneas de código o se desea grabar un script el proceso no es simple. El comando `help()` nos muestra una interesante opción:

	![](Images/help.png "" "width:300px;")

4. Presionando `CTRL-E`en una línea en blanco se entra a modo `PASTE` en donde podemos pegar código copiado desde algún otro lugar (ej. Geany). Finalizamos con `CTRL-D` retornando así al modo REPL

	![](Images/paste.png "" "width:300px;")

5. He tenido problemas pegando código que supera 1Kb. Por ahora es apropiado para enviar código pequeño y poder experimentar

6. Para enviar archivos utilizaba ESPlorer, pero me obligaba a cerrar la conexión cada vez que requería utilizar `screen`. Siendo `Geany` mi editor de preferencia, y aprovechando el plugin LUA para Geany, me hice un script que transforma el archivo en edición dejándolo listo para copiar y pegar en la consola de MicroPython (ver el directorio `tools/` e instalarlo en `.config/geany/plugins/geanylua`)

	![](Images/plugin.png "" "width:300px;")

	![](Images/filtered.png "" "width:300px;")

7. Lo anterior no está exento de problemas y al pegar el código a veces se pierden caracteres en el modo `REPL` lo que genera errores en el intérprete. En el modo `PASTE` he tenido problemas con código mayor que 1kb.


***
##Historia
* Jun 05, 2016: Implementa plugin en LUA para facilitar grabación de archivos en uPy
* Jun 04, 2016: Prepara ambiente de trabajo para compilar y generar las imágenes de uPy, así grabarlas en el NodeMCU

