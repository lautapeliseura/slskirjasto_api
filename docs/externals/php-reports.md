## php-reports

Php-reports on Jeremy Dornin varsin vaikuttava raporttigeneraattori php:llä. Sen lähdekoodi löytyy [GitHubista](https://github.com/jdorn/php-reports), mutta valittettavasti sitä ei ole vähään aikaan päivitelty ja pull requestien puolella roikkuu tavaraa, jotka olisivat kivoja. Generaattorissa on yksi _feature_, joka tekee siitä suoraan käyttökelvottoman postgresql:n kanssa.

Projekti myös riippuu toisesta jdornin vaikuttavasta projektista [sql-formatterista](https://github.com/jdorn/sql-formatter). Jossa siinäkin on muutamia roikkuvia pull-requesteja ja ikäviä puutteita postgresql-tuen suhteen.

Tämän takia olen forkannut molemmat projektit ja tehnyt kumpaankin vähän paikkoja.

## Php-reports installointi

Tämä on kuvaus siitä miten php-reports on asennettu "demo"-ympäristöön, joka on CentOS Linux 7.9.2009 (Core) versiota ja pyörittää apachea. Koneelle on asennettu php-versio 8, jossakin vaiheessa historiaa, todennäköisesti ohjeella, joka on samankaltainen kuin löytyy [computingforgeeks.com:sta](https://computingforgeeks.com/how-to-install-php-8-on-centos-linux/) Oletuksena web-root on määritettynä hakemistoon /web/generalfailure.net

* `cd /web/generalfailure.net/`
* `sudo setfacl -m group:wheel:rwx .`
* `sudo setfacl -d -m group:wheel:rwx .`
* `mkdir slskirjasto_api`
* `cd slskirjasto_api`
* `sudo yum install git` installoidaan puuttunut git
* `git clone -b daFool https://github.com/daFool/php-reports.git`
* `cd php-reports`

Centos 7:n repoissa on liian vanha composer, joten asennetaan se tässä vaiheessa suoraan lähteeltä ja lähteen ohjeiden [mukaan](https://getcomposer.org/download/), jota sitten tylysti täydennetään ja jatketaan:

* `sudo mv composer.phar /usr/local/bin/composer`
* `sudo chmod a+rx /usr/local/bin/composer`
* `composer update`
* `cd vendor jdorn`
* `git clone -b daFool https://github.com/daFool/sql-formatter.git`

Sitten tajutaan, että demopalvelimella ei ole edes Postgresql-kantaa, joten asennellaan:

* Noudatetaan pätevää ohjetta [computingforgeeks.com:sta](https://computingforgeeks.com/how-to-install-postgresql-14-centos-rhel-7/) 
* `sudo su - postgres`
* `createuser mos -s`
* `exit`
* `sudo yum install postgresql-jdbc -y`
* `sudo yum install php-pgsql -y`

Asennuksen jälkeen luodaan kantakäyttäjä omalla käyttäjätunnuksella ja vivulla "-s", jotta saadaan kaikki maailman oikeudet.

Jatketaan php-reports-asennusta.
* `cd ../../` palataan takaisin php-reports-hakemiston juureen
* `mkdir cache` luodaan cache-hakemisto, twig-template enginelle
* `sudo semanage fcontext -a -t httpd_sys_rw_content_t "/web/generalfailure.net/slskirjasto_api/php-reports/cache(/.*)?"`  
* `sudo restorecon -v -R /web/generalfailure.net/slskirjasto_api/php-reports/` 
* `sudo setsebool httpd_can_network_connect_db on -P`
* `setfacl -m user:apache:rwx cache/`
* `setfacl -d -m user:apache:rwx cache/`
* `composer dump-autoload`
* `cp config/config.php.sample /config/config.php`

Nyt on saatu kokoon perusasetukset php-reportsille ja käynnistyksen jälkeen osa esimerkkiraporteista toimiikin niin kuin olettaisi. Osa kaatuu komeasti ja saadaan logiin varoituksia php-virheistä.