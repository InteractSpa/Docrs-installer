# Docrs-instances-creator
##### Software Repository: [DOCRS](https://github.com/InteractSpa/docrs)
##### Installazione:
1. Installare la versione **8.0** di **Tomcat**
2. Installare **nodejs** ed **npm**
3. Clonare il progetto in `$CATALINA_HOME/webapps`
4. Creare il file `setenv.sh` in `$CATALINA_HOME/bin` e modificarlo come segue: `export CATALINA_OPTS="${CATALINA_OPTS} -Djava.awt.headless=true -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true -Dmail.mime.decodeparameters=true -Xms4096m -Xmx8192m -XX:PermSize=1024m -XX:MaxPermSize=2048m -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled"`
5. Installare il modulo **ncp** di **node**: `npm install ncp`
6. Avviare il server node: `node instancesCreator.js`
7. Avviare il server Tomcat

##### Utilizzo:
1. L'istanziatore è attivo sulla porta **1234**
2. Una volta creata l'istanza dovrebbe funzionare, se non fosse così potrebbe essere necessario avviarla dal **manager** di **Tomcat**


#### TODO:
  * inserimento logo del Comune
  * gestione di database dedicati
  * migliorie sulla stabilità di Tomcat
