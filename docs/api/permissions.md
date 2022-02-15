## Käyttöoikeuksien hallinta

Autentikaatiosta huolehtivat 3. osapuolet. Testivaiheessa ainut tuettu autentikaatiopartneri on GitHub, mutta tulevaisuudessa kelpuutetaan ainakin Facebook ja Google, koska ne ovat Socialiten tukemia partnereita.

Autentikaatioon liittyy muutamia kantatauluja:

|Taulu|Tarkoitus|
|-----|---------|
| users | Kaikki järjestelmän käyttäjät ja heistä sähköposti, nimi ja **id**. |
| password_resets | Ei käytössä, mutta olisi paikka paikallisten käyttäjien vielä avoimille salasanojen palautuspyynnöille. |
| personal_access_tokens | Sanctumin luomat ja hallinnoimat _Bearer tokenit_, joita käyttäjillä on. Sarake: **tokenable_id**, on omistajan **id**. |
| providers | 3. osapuolien autentikaatioiden _mäppäys_-avaimet, **provider_id** -> **id** |

### Autentikaation kulku

Käyttäjä, jolla ei ole voimassa olevaa bearer tokenia tai istuntoa aloittaa kirjautumalla:

* Käyttäjä yrittää kirjautua osoitteella: api/login/_provider_, josta hänet ohjataan _provider_:n kirjautumissivulle. 
* _Providerin_ kirjautumissivu palauttaa api/login/_provider_/callback:iin, jossa:
  * Käyttäjää etsitään sähköpostiosoitteen perusteella ja jos käyttäjää ei ole, sellainen luodaan **users**-tauluun
  * Käyttäjän _provider_-tietoja etsitään **providers**-taulusta ja jos tietoja ei ole, käyttäjä luodaan tauluun
  * Käyttäjälle luodaan access_token
  * Käyttäjän kirjataan sisään APIiin
  * Palautetaan headerissa token ja bodyssä käyttäjän tiedot: **id**, nimi ja sähköposti

Oletusarvoisesti luotu tokeni on voimassa ajasta ikuisuuteen. Oleelliset php-tiedostot: `routes/api.php` ja `app/Http/Controllers/LoginController.php`

Jos käyttäjällä on **tokeni**, voi hän suoraan tehdä kutsuja apiin käyttämällä tokenia.

## Autorisaatio

Kolme kantataulua:

| Taulu | Tarkoitus |
|-------|-----------|
| groups | Käyttäjäryhmät |
| roles | Käyttäjäroolit |
| groupmembers | Ryhmäjäsenyydet ja roolit |

### Käyttäjärymät

Käyttäjäryhmiä on kahdenlaisia:

1. Järjestelmäryhmiä (System), valmiit: **Taikaviitat**, **Käyttäjät** ja **Operaattorit**
2. Omistajuusryhmiä (Owner), valmiit: **Norkkokujan Sirkus** ja **SLS**

Järjestelmäryhmän jäsenyys antaa automaattisesti oikeuksia asioihin järjestelmässä ja omistajaryhmät puolestaan kertovat miten kokoelmia, kokoelmien pelejä, varastoja ja hyllyjä hallinnoidaan. Järjestelmäryhmien tuomat oikeudet:

| Ryhmä | Oikeus |
|-------|--------|
| Taikaviitat | Ihan kaikki oikeudet tehdä ihan mitä vain järjestelmässä. |
| Käyttäjät | Saavat perustaa kokoelmia ja hallita niihin liittyvien käyttöoikeusryhmän jäsenyyksiä, saavat muokata pelejä ja lahjoittajia. |
| Operaattorit | Saavat automaattisesti lainata ja palauttaa pelejä julkisista kokoelmista sekä päätyä kokoelmien omistajuusryhmien jäseniksi.|
| Ryhmättömät | Saavat katsoa omat käyttäjätietonsa ja päätyvät jossakin vaiheessa automaattisesti roskikseen, jos heitä ei koroteta vähintään operaattoreiksi.|

Kaikki käyttäjät saavat lisäksi poistaa itsensä, kunhan se toteutetaan. Poistettaessa käyttäjää pitää:

* poistaa ne kokoelmat ja niihin liittyvät varastot ja hyllyt, joille poistettu käyttäjä on viimeinen omistaja
* poistaa ne lainat, jotka kohdistuivat poistettuihin kokoelmiin

### Omistajaryhmät ja roolit

| Rooli | Tarkoitus|
|-------|----------|
| Owner | Omistaa kohteen ja hallitsee siihen liittyviä oikeuksia. |
| Admin | Saa käsitellä kohdetta kuin omistaja, mutta ei voi antaa, poistaa eikä muokata kohteen oikeuksia. |
| ServiceManager | Saa _operoida_ kohdetta. |

Roolien tulkinta ja tarkemmat oikeudet riippuvat siitä mikä on kohde, johon rooli on myönnetty. Nämä kuvataan myöhemmin kunkin kohteen kohdalla. Jokaiselle kokoelmalle luodaan automaattisesti omistajaryhmä. Kannassa on näitä valmiiksi kaksi kappaletta:

| Rymä | Tarkoitus |
|------|-----------|
| Norkkokujan Sirkus | Fuula-sedän pelikokoelman käyttöoikeudet. |
| SLS | SLS:n pelikokoelman käyttöoikeudet. |

## Käsite publicity

Kannan joissakin tauluissa on sarake _publicity_, jonka tarkoitus on kontrolloida täysin autorisoimatonta katselua. Sarake on taulukko _flägejä_ , joilla tietojen katseltavuutta voidaan rajata. Jos rivillä on flägi: **PUBLIC**, on tieto vapaasti katsottavissa kannasta ilman autorisaatiota tai autentikaatiota. Jos taas flägi on **PRIVATE**, ei tietoja näytetä kuin kohteen käyttöoikeusrymän jäsenille. Jos flägejä ei ole, ei tieto ole julkisesti saatavissa, mutta jokainen vähintään operaattoritasoinen käyttäjä voi sen katsella.
