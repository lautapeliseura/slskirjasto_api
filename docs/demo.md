# Demo-koneen asennus ja päivitys

## Asennus

Demo-koneeseen on jo tullut asennettua kanta php-reportsin asennuksen [yhteydessä](externals/php-reports.md). Eli tämä ohje lähtee oletusesta, että php-reports on asennettu ja siinä sivussa postgresql-server 14, composer ja sivuosumina kasa php-riippuvuuksia sekä luotu [$DOCWEBROOT](usage.md#paramssh-dokumentaatio). Jos käyttäjätunnuksesi ei ole postgresql superuser, vaihda sellaiseen käyttäjään, joka on, koska kannan ja käyttäjien luominen edellyttää superuser-tason oikeuksia.

1. `git clone git@github.com:lautapeliseura/slskirjasto_api.git` tai jos et ole git-käyttäjä,  jolla on ssh-avaimia niin: `git clone https://github.com/lautapeliseura/slskirjasto_api.git`
2. `cd slskirjasto_api`
3. `cp params_example.sh params.sh`
5. `cp .env.example .env`
6. Muokataan params.sh, vaihdetaan vähintään kantakäyttäjien salasanat sekä $DOCWEBROOT
7. Muokataan .env, vaihdetaan kantaparametrit
8. `composer install`
4. `source params.sh`
5. `make database`

Tässä välissä voidaan ihmetellä mitä on saatu aikaiseksi, komennolla `psql $DATABASE` pitäisi nyt päästä sisään luotuun kantaan.  

    psql (14.1)
    Type "help" for help.

    slskirjasto=# \dt
                    List of relations
    Schema |          Name          | Type  | Owner 
    --------+------------------------+-------+-------
    public | basket_games           | table | mos
    public | baskets                | table | mos
    public | cards                  | table | mos
    public | collectiongames        | table | mos
    public | collections            | table | mos
    public | donors                 | table | mos
    public | events                 | table | mos
    public | failed_jobs            | table | sls
    public | games                  | table | mos
    public | groupmembers           | table | mos
    public | groups                 | table | mos
    public | lenders                | table | mos
    public | loans                  | table | mos
    public | migrations             | table | sls
    public | password_resets        | table | sls
    public | personal_access_tokens | table | sls
    public | roles                  | table | mos
    public | shelves                | table | mos
    public | storages               | table | mos
    public | users                  | table | sls
    (20 rows)

    slskirjasto=# select * from groups;
        group_name     |                     group_purpose                      | user_id | id |          created_at       
        | updated_at |  created_by  | updated_by | schema_version 
    --------------------+--------------------------------------------------------+---------+----+---------------------------
    ----+------------+--------------+------------+----------------
    Norkkokujan Sirkus | Fuula-sedän pelikokoelman ylläpitoryhmä                |         |  1 | 2022-02-06 09:20:16.424892
    +02 |            | Initial load |            | alpha
    SLS                | Suomen lautapeliseura ry:n pelikokoelman ylläpitoryhmä |         |  2 | 2022-02-06 09:20:16.428653
    +02 |            | Initial load |            | alpha
    Taikaviitat        | Koko järjestelmän ylläpitoryhmä                        |         |  3 | 2022-02-06 09:20:16.429721
    +02 |            | Initial load |            | alpha
    (3 rows)

    slskirjasto=# \q
    [mos@error slskirjasto_api]$

Esiripun takana haetaan SLS:n google-drivestä vanhan kannan dumppi ja toimitetaan se asentavan käyttäjän kotihakemistoon tiedostoksi `slskirjasto.dmp`. 

1. `createuser slskirjasto` - tämä käyttäjärooli omistaa vanhan tietokannan taulut, joten se on tarpeen kannan palauttamista varten
2. `createdb slskirjastoold` - vanhan tyhjän kannan luominen
3. `pg_restore -d slskirjastoold ~/slskirjasto.dmp`- vanhan kannan palauttaminen
4. `make oldimport`

Nyt kannassa pitäisi olla slskirjaston sisältö sellaisena kuin se oli vanhassa kannassa, tosin niin että Peli-taulusta on poistettu duplikaatteja ja käyttäjät sekä lainaajat puuttuvat. Lainoista on poistettu tieto siitä kuka lainauksen on tehnyt, joten kannan sisältö täyttää toistaiseksi GDPR-vaatimukset.

1. `yum install mkdocs -y` -mkdocs-dokumenttigeneraattorin asennus
2. `sudo yum install python-setuptools` - mkdocs vaatii tämän, mutta paketti ei vaadi!
3. `yum install doxygen -y` - Doxygen asennus, sitä ei vielä tässä vaiheesa oikeastaan tarvita, mutta pistetään nyt valmiiksi 
4. `sudo yum install graphviz graphviz-java graphviz-gd` - Graphviz graafien piirtoon ja vähän paketteja kaupan päälle
5. `cd`
6. `mkdir javalibs`
7. `cd javalibs`
8. `wget https://github.com/schemaspy/schemaspy/releases/download/v6.1.0/schemaspy-6.1.0.jar`
9. `wget https://jdbc.postgresql.org/download/postgresql-42.3.2.jar`
10. Muokataan params.sh tiedoston schemaspy: `export SCHEMASPY=/home/mos/javalibs/schemaspy-6.1.0.jar`
11. Muokataan params.sh tiedoston jdbc: `export PGSQLJDBC=/home/mos/javalibs/postgresql-42.3.2.jar`
12. Ja koska tässä koneessa on salasana pakollinen, export PGPASSWD=salasana, missä salasana on ajavan käyttäjän postgresql-salasana
13. `make schemadocs` - Tämä kestää useampia minuutteja, ei kannata hermostua. Jos koneessa on toimiva graphviz, kannattaa skriptistä ottaa vivut -vizjs pois
14. Asennetaan [shdoc](https://github.com/reconquest/shdoc)
15. `make bashdocs`
16. `make mkdocs` -  Tulee varoituksia, CentOS 7:n python on mitä on ja sen lisäksi tuo CentOS:n mkdocs paketti on mitä on.
17. Korjataan params.sh tiedoston DOCWEBROOT : `export DOCWEBROOT=/web/generalfailure.net/slskirjasto_api`
18. `make docsinstall` - Asennetaan dokumentaatio
    
Aiemmin on asennettu php-reports, mutta sen konfiguraatio osoittaa malliraportteihin, käydään korjaamassa se osoittamaan slskirjaston raportteja.
1. `cd /web/generalfailure.net/slskirjasto_api/php-reports/config`  
    <?php
return array(
        //the root directory of all your reports
        //reports can be organized in subdirectories
        'reportDir' => '/web/generalfailure.net/slskirjasto_api/reports',

        //the root directory of all dashboards
        'dashboardDir' => '/web/generalfailure.net/slskirjasto_api/dashboards',
    ...
                            // Supports and PDO database
                        'pdo'=>array(
                                'dsn'=>'pgsql:host=localhost;dbname=slskirjasto',
                                'user'=>'slsreport',

Raporttikäyttäjäksi ja salasanaksi pitää tietysti asettaa ne arvot, jotka olet määrittänyt `params.sh`-tiedostoon.

Kun tämän jälkeen komentaa: `make installreports` kopioidaan raporttitiedostot oikealle paikalleen.

Olen kuitenkin jossakin vaiheessa asentanut CentOS 7 :n php Remistä, joka on linkannut php-pgsql-palikan vanhaa 9.6-sarjan postgresql:ää tai jotakin vielä vanhempaa kamaa vasten. Vanha kama ei tue SCRAM-autentikointia, joten pitää downgradeta Postgresql:n turvallisuutta. Tämä tarkoittaa:

* Vaihdetaan postgresql.conf:ssa autentikaatio md5:ksi  
  
    #password_encryption = scram-sha-256	# scram-sha-256 or md5
    password_encryption = md5

* Vaihdetaan pg_hba.conf:ssa pääsyt md5:ksi:

    host	all	all	127.0.0.1/32	md5
    host	all	all	::1/128	md5

* Käynnistetään postgresql uudestaan: `sudo systemctl restart postgresql-14`
* `source bin/dbhelper.sh`
* `psqlexecute "alter user $DBUSER with encrypted password '$DBPASSWORD';"`
* `psqlexecute "alter user $DBREPORTUSER with encrypted password '$DBREPORTUSERPASSWORD';"`

Ja nyt pitäisi raporttien aueta [demokoneelta](https://generalfailure.net/slskirjasto_api/php-reports/)