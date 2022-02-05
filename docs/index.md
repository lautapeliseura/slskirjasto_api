# SLSKirjasto API

Käyttääksesi tämä repositoryn sisältöä ohjelmistokehitykseen tarvitset joukon kehitystyökaluja. Tämä projekti on lähtenyt liikenteeseen ajatuksesta että kehittäjällä on työasema, joka pyörittää postgresql-tietokantaa, ajaa web-palvelinta ja kykenee php-sovelluskehitykseen. Kaikki olisi toki voitu toteuttaa kontteina ja jossakin vaiheessa harjoitusta varmaan näin tapahtuukin. Sitä ennen tarvitset kehitysympäristön. Yksi esimerkki kehitysympäristöstä: [Fuula-setä](fuula.md).

* Repositoryn [käyttöönotto](usage.md)
* API-projektin [tilanne](status.md)
* Tietokannan skeeman [dokumentaatio](schema)
* Mahdollinen vanhan kannan skeeman [dokumentaatio](oldschema)
* Mahdolliset php-reports [raportit](php-reports)

## Hakemiston sisältö päätasolla
    app/                    # Laravelin luoma php-sovelluksen päähakemisto
    bin/                    # [Bash-skriptejä](bash/) asioiden tekemiseen 
    bootstrap/              # Laravelin css- ja js-tiedostot
    config/                 # Laravel
    database/               # Laravel
    doc/                    # Schemadokumentaation työhakemisto, ei repossa
    docs/                   # Dokumentaation lähdekoodi
    external/               # 3. osapuolet - ei composer
    oldimport/              # Vanhan tietokannan importointi 
    public/                 # Laravel - web juuri
    reports/                # PHP-reports raportit
    resources/              # Laravel
    routes/                 # Laravel
    site/                   # Mkdocs:in työhakemisto, ei repossa
    sql/                    # Tietokannan luontilauseet
    storage/                # Laravel
    tests/                  # Laravel
    vendor/                 # Laravelin / composer, ei osa repoa


    .editorconfig           # Laravel
    .env                    # Laravel konfiguraatio, ei reposssa
    .env.example            # Mallikonfiguraatio
    .gitattributes          # Laravel/Git
    .gitignore              # Git
    .styleci.yml            # Laravel
    artisan                 # Laravelin komentorivityökalu
    collectiongames.csv     # Ei versioida, oldimport kokoelmapelit
    collection.csv          # Ei versioida, oldimport kokoelmat
    composer.json           # Laravel composerin konfiguraatio
    composer.lock           # Composer
    databasedone.txt        # Makefilen pseudo-tulos, ei repossa
    donors.csv              # Ei versioida, oldimport lahjoittajat
    events.csv              # Ei versioida, oldimport tapahtumat
    loans.csv               # Ei versioida, oldimport lainat
    Makefile                # Projektin rakennusohjeet
    mkdocs.yml              # Mkdocs-komennon konfiguraatio
    params_example.sh       # Konfiguraatioesimerkki
    params.sh               # Ei versioida. Konfiguraatio.
    package.json            # Laravel
    phpunit.xml             # Laravel
    README.md               # Github repositoryn readme
    serverp.php             # Laravel
    webpack.mix.js          # Laravel
