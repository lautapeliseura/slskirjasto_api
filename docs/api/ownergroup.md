## Omistajaryhmät

Kaksi käyttöikeustasoa:

- Taikaviitat, kaikki operaatiot sallittuja ja
- Käyttäjät, jotkin operaatiot sallittuja
  
### Omistajaryhmät

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /ownerGroups | GET | Taikaviitat, Käyttäjät |

Taikaviitat näkevät kaikki ryhmät, Käyttäjät vain ne ryhmät, jotka omistavat tai joissa ovat jäseniä.

Palauttaa:

| Attribuutti | Selitys | Esimerkki |
|-------------|---------|-----------|
| group_name | Ryhmän nimi | Norkkokujan Sirkus |
| group_purpose | Ryhmän tarkoitus | Fuula-sedän pelikokoelman ylläpitoryhmä |
| user_id | Ryhmän omistajan id | null |
| created_at | Koska ryhmä on luotu | 2022-02-06T15:51:27.289356Z |
| updated_at | Koska ryhmää on päivitetty | null |
| created_by | Kuka ryhmän loi | Initial load |
| updated_by | Kuka ryhmää on päivittänyt | null |

### Omistajaryhmän luominen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /ownerGroup | POST | Taikaviitat, Käyttäjät |

Parametrit form-muotoisina:

| Parametri | Selitys | Esimerkki |
|-----------|---------|-----------|
| group_name | Ryhmän nimi | Testi |
| group_purpose | Ryhmän tarkoitus | Testataan ryhmän luomista | 

Järjestelmässä ei voi olla useampia ryhmiä samalla nimellä. 

### Omistajaryhmän muokkaaminen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /ownerGroup | POST | Taikaviitat, Käyttäjät |

Käyttäjä voi muokata vain omistamiaan ryhmiä, eli ryhmiä jotka on itse luonut tai ryhmiä, joihin on saanut "OWNER"-roolin. Taikaviitat muokkaavat mitä haluavat.

| Parametri | Selitys | Esimerrki |
|-----------|---------|-----------|
| _method | Patch-kludge | PATCH |
| id | Muokattavan ryhmän id | 9 |
| group_name | Ryhmän mahdollinen uusi nimi | Testi2 
| group_purpose | Ryhmän mahdollinen uusi tarkoitus | Muokattu ryhmä

### Omistajaryhmän jäsenet

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /ownerGroup/{id}/members | GET | Taikaviitat, Käyttäjät |

Käyttäjä voi katsoa vain ryhmien joiden omistaja on jäseniä. Taikaviitat näkevät kaikkien.

| Parametri | Selitys | Esimerkki |
|-----------|---------|-----------|
| id | Ryhmän id | 9

Palauttaa:

| Attribuutti | Selitys | Esimerkki |
|-------------|---------|-----------|
| id | Käyttäjäavain | 3|
| name | Käyttäjän nimi | Mauri Sahlberg
| email | Käyttäjän sähköposti | mauri.sahlberg@advania.com

Tämä jäsenkysely ei palauta ryhmien omistajia, vaan ainoastaan lisätyt jäsenet.

### Jäsenen lisääminen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /ownerGroup/member | POST | Taikaviitat, Käyttäjät|

Parametrit:

| Parametri | Selitys | Esimerkki |
|-----------|---------|-----------|
| user_id | Lisättävän käyttäjän tunniste | 3
| group_id | Ryhmän johon lisätään tunniste | 9
| role_id | Lisättävän roolin tunniste | 2 

Käyttäjät voivat lisäillä jäseniä vain omistamiinsa ryhmiin.

### Ryhmän poistaminen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /ownerGroup/{id} | DELETE | Taikaviitat, Käyttäjät|

Vain tyhjän ryhmän voi poistaa.

| Parametri | Selitys | Esimerkki |
|-----------|--------|----------|
| id | Poistettavan ryhmän tunniste | 8

Taikaviitat voivat poistaa mitä vain, käyttäjät vain omiaan.

### Jäsenen poistaminen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /ownerGroup/{id}/members/{id}|DELETE|Taikaviitat, Käyttäjät|

| Parametri | Selitys | Esimerkki |
|-----------|--------|----------|
| id | Ryhmän josta poistetaan tunniste | 8
| memberid | Poistettava jäsen| 3

Taikaviittat voivat poistaa kenet vain, käyttäjät vain omiaan.
