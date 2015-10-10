# Docrs-installer
##### Software Repository: [DOCRS](https://github.com/InteractSpa/docrs)
##### Installazione:
1. Installare la versione **8.0** di **Tomcat**
2. Installare **nodejs** ed **npm**
3. Clonare il progetto in `$CATALINA_HOME/webapps`
4. Creare il file `setenv.sh` in `$CATALINA_HOME/bin` e modificarlo come segue: `export CATALINA_OPTS="${CATALINA_OPTS} -Djava.awt.headless=true -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true -Dmail.mime.decodeparameters=true -Xms4096m -Xmx8192m -XX:PermSize=1024m -XX:MaxPermSize=2048m -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled"`
5. Installare i moduli di **node**: `sudo npm install <modulo>`
6. Avviare il server Tomcat

##### Utilizzo:
1. Lanciare l'installatore `node installer.js` e seguire le istruzioni

#### TODO:
  * migliorie sulla stabilità di Tomcat
