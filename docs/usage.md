# Repositoryn käyttöönotto

## Projektin riippuvuudet

Tarvitset toimivan composerin. Teoriassa: `composer update` tai `composer install`, päivittää riippuvuudet. Jos vendor-hakemistoa ei synny, niin poistamalla **composer.lock**-tiedosto pitäisi tapahtua.


## Konfigurointi

Konfiguraatioita on kaksi:  
 
 1. shell-skriptojen käyttämä **params.sh**-tiedosto, jonka saa helpoiten luotua kopioimalla _params_example.sh_-tiedoston params.sh-tiedostoksi.
 2. Laravelin käyttämä **.env-tiedosto*, jonka malli löytyy tiedostosta .env.example

## Params.sh - tietokanta

| Muuttuja | Tarkoitus | Esimerkki |
|----------|-----------|-----------|
| DATABASE | Luotavan tietokannan nimi | slskirjasto |
| DBUSER   | Tietokanan API-käyttäjä, jolla tulee kirjoitusoikeudet kaikkeen | sls |
| DBPASSWORD | Käyttäjälle haluttu salasana | salasana |
| DBHOST | Hosti, jossa klusteri sijaitsee | localhost |
| DBREPORTUSER | Tietokannan raportti-käyttäjä, jolla on lukuoikeudet kaikkeen | slsreport | 
| DBREPORTUSERPASSWORD | Raporttikäyttäjälle haluttu salasana | salasana |
| MATVIEWGROUP | Käyttäjäryhmä, joka tulee omistamaan kaikki materialisoidut näkymät | slsmaterial |

Jos sinulla on palautettuna vanha slskirjasto-kanta (dumppi löytyy SLS:n hallituksen google-drivestä, kansiosta SLSKirjastokanta), niin lisäksi:

| Muuttuja | Tarkoitus | Esimerkki |
|----------|-----------|-----------|
| OLDDATABASE | Vanhan tietokannan nimi | slskirjastoold |

Vanhan kannan oletetaan toistaiseksi sijaitsevan samassa klusterissa kuin uudenkin.
## params.sh Dokumentaatio

| Muuttuja | Tarkoitus | Esimerkki |
|----------|-----------|-----------|
| SCHEMASPY | Schemaspyn jar-tiedoston sijainti|/home/mos/javalib/schemaspy-6.1.0.jar|
| PGSQLJDBC | Postgresql-jdbc-ajurin sijainti|/opt/DbVisualizer/jdbc/postgresql/postgresql.jar
| SCHEMADOCS | Työhakemisto | $DDIR/doc/schema |
| OLDSCHEMADOCS | Työhakemisto vanhalle kannalle | $DDIR/doc/oldschema |
| DOCWEBROOT | Julkaistun web-dokumentaation kohde | /var/www/html/slskirjasto_api |

## .env
[Params.sh](#paramssh---tietokanta) tietokanta-asetuksia vastaavat tiedot pitää asettaa myös .env-tiedostoon Laravelia varten. Esimerkiksi:

    DB_CONNECTION=pgsql
    DB_HOST=127.0.0.1
    DB_PORT=5432
    DB_DATABASE=slskirjasto
    DB_USERNAME=sls
    DB_PASSWORD=salasana

## Kannan rakentaminen
Rakentaaksesi tietokannan tarvitset postgresql klusterin - vähintään, veikkauksena, versiota 13, APIa on kehitetty versiota 14 vasten. Käyttäjätunnuksella, jolla teet kannanluontia tulee olla superkäyttäjän oikeudet kantaklusteriin.

Jos kanta vaatii käyttäjätunnuksellasi salasanaa se kannattaa exportoida muuttujaan PGPASSWORD, koska sitä tarvitaan luonnin aikana useita kertoja.

Mikäli params.sh-tiedoston ja .env-tiedoston sisältö ovat kunnossa, eikä hakemiston juuresta löydy tiedostoa databasedone.txt, pitäisi kannan syntyä repositoryn juuressa seuraavasti:

1. `source params.sh` - lukee muuttujan shell-ympäristöön
2. `make database` - Ajaa kannan luonnin

Tuloksena syntyy paitsi kanta, myös tiedosto "databasedone.txt". Jos haluat luoda kannan uudestaan, droppaa vanha ja poista "databasedone.txt"-tiedosto.

### Vanhan kannan importointi

Jos olet palauttanut vanhan kannan samaan postgresql-kantaklusteriin, esimerkiksi: `pg_restore -d slskirjastoold ../slskirjasto.dmp` ja konfiguroinut sen nimen - esimerkin tapauksessa slskirjastoold, params.sh-tiedostoon, pitäisi sinun saada migroitua sisältö uuteen kantarakenteeseen projektin juuressa seuraavasti:

1. `source params.sh` - tarpeen vain kerran bash-istuntoa kohden!
2. `make oldimport` - ajaa importit

Kannattaa huomata, että prosessin aikana vanhan kannan sisällöstä korjataan muutamia _virheitä_, jotka estävät tietojen onnistuneen tuonnin uuteen rakenteeseen, sekä luodaan näkymiä tuontia helpottamaan. Virheiden korjaaminen **poistaa** vanhasta kannasta tietoa! Ajotunnuksella pitää siis olla riittävästi oikeuksia asioiden luomiseen ja poistamiseen vanhassa kannassa.

Tuonnin voi toistaa koskematta vanhaan kantaan, mutta uusi kanta pitää tyhjentää ennen uutta tuontia, tai tuonti monistaa sisältöä ja todennäköisesti myös kaatuu virheeseen!

## Dokumentaation rakentaminen

Dokumentaatio koostuu neljällä dokumentointityökalulla tuotetusta dokumentaatiosta:

1. Mkdoc - Markdown dokumentaatiosta, jonka lähdekoodi on docs-hakemistossa,
2. Schemadokumentaatiosta - Schemaspyllä kannasta rakennettu, dokumentaatio, joka päätyy doc-työhakemiston alihakemistoon schema,
3. shdoc - Joka tuottaa bin-hakemiston skriptoista dokumentaation docs/bash-alihakemistoon ja
4. Doxygenillä tuotetusta php-dokumentaatiosta, joka päätyy doc-työhakemiston alihakemistoon php

Periaatteessa rakennusjärjestyksen pitäisi olla 3, 2, 4 ja 1. Mutta jos et ole muuttanut bin-hakemistojen skriptoja tai lisännyt skriptoja, on 3:n ajaminen tarpeetonta. 1:n tuottama dokumentaatio sisältää linkkejä kahden muun välineen tuottamaan dokumentaatioon, joten osa dokumenttilinkeistä on 1:n tuottamassa dokumentaatiossa rikki ennen kuin 2 ja 4 on ajettu. Käytännössä ensimmäisen dokumentaatioasennuksen jälkeen ei juuri ole väliä missä järjestyksessä dokumentaatiota generoi.

Jos sinulla ei ole Markdown-lukijaa, kannattaa ajaa 1.:n ensin ja lueskella jatko-ohjeita site-hakemiston alta web-selaimella.

### Mkdoc dokumentaation luominen

Joko `mkdocs build` tai Makefilen kautta - olettaen että `source params.sh` on jo istuntoon ajettuna: `make mkdocs`.

Komennon ajaminen päivitää site-alihakemistoon staattisen html-dokumentaation. 

Komennon tulosta ja tyylejä voi säätää muokkaamalla tiedostoa `mkdocs.yml`.

### Bash dokumentaation luominen

Olettaen että `source params.sh` on suoritettu: `make bashdocs` ajaa shdoc:in jokaiselle bin-hakemiston .sh-päätteiselle tiedostolle ja tuottaa oman tiedoston alihakemistoon doc/bash

### Skeemadokumentaation luominen

Olettaen että `source params.sh` on suoritettu ja kanta tai kannat ovat olemassa, niin `make schemadocs` tuottaa skeemadokumentaation alihakemistoihin doc/schemadoc ja doc/oldschemadoc

## Dokumentaation installointi

Dokumentaation voi kopioda web-juureen (kts [$WEBDOCROOT](#paramssh-dokumentaatio)) helpommin selattavaksi komentamalla `make docsinstall`. Ennen tätä on tietysti hyvä generoida dokumentaatio, jonka ohessa tulee ajettua väkisin myös `source params.sh`.
