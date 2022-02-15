## Käyttäjää koskeva API

### Käyttäjän tiedot

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /user | GET | Kirjautunut käyttäjä |

Palauttaa:

| Attribuutti | Selitys | Esimerkki |
|-----------|---------|-----------|
| id | Käyttäjän tunniste | 2 |
| name | Käyttäjän nimi autentikaatiopalvelussa | Mauri Sahlberg |
| email | Käyttäjän sähköpostiosoite | mauri.sahlberg@gmail.com |

### Käyttäjän tokenit

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /user/tokens | GET | Kirjautunut käyttäjä |

Palauttaa:

| Attribuutti | Selitys | Esimerkki |
|-------------|---------|-----------|
| id | Tokenin tunniste | 7 |
| token | Tokenin sisältö | &lt;heksadesimaalijono&gt; |
| last_used | Viimeksi käytetty | 2022-02-15
17:29:11 |

Käyttäjällä voi olla useampia tokeneita, joista suurin osa on todennäköisesti käyttämättömiä.

### Käyttäjän tokenin poistaminen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /user/token/{id} | DELETE | Kirjautunut käyttäjä |

Parametrit:  

* id - tokenin kokonaislukuavain

### Käyttäjän ryhmät

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /user/groups | GET | Kirjautunut käyttäjä |

Palauttaa:

| Attribuutti | Selitys | Esimerkki |
|-------------|---------|-----------|
| group_name | Ryhmän nimi | Käyttäjät |
| group_purpose | Ryhmän tarkoitus | Järjestelmän kokoelmaomistajat |
| user_id | Ryhmän omistajan id | null |
| created_at | Koska ryhmä on luotu | 2022-02-06T15:51:27.289356Z |
| updated_at | Koska ryhmää on päivitetty | null |
| created_by | Kuka ryhmän loi | Initial load |
| updated_by | Kuka ryhmää on päivittänyt | null |

Käyttäjällä voi olla useampia ryhmiä.

