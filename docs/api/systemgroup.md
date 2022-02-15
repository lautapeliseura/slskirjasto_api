## Järjestelmäryhmät
  
### Järjestelmäryhmät

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /systemGroups | GET | Taikaviitat |

| Attribuutti | Selitys | Esimerkki |
|-------------|---------|-----------|
| group_name | Ryhmän nimi | Taikaviitat |
| group_purpose | Ryhmän tarkoitus | Koko järjestelmän ylläpitoryhmä |
| user_id | Ryhmän omistajan id | null |
| created_at | Koska ryhmä on luotu | 2022-02-04T16:28:15.952923Z |
| updated_at | Koska ryhmää on päivitetty | null |
| created_by | Kuka ryhmän loi | Initial load |
| updated_by | Kuka ryhmää on päivittänyt | null |

### Järjestelmäryhmän jäsenet

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /systemGroup/{id}/members | GET | Taikaviitat |

| Parametri | Selitys | Esimerkki |
|-----------|---------|-----------|
| id | Ryhmän id | 9

Palauttaa:

| Attribuutti | Selitys | Esimerkki |
|-------------|---------|-----------|
| id | Käyttäjäavain | 3|
| name | Käyttäjän nimi | Mauri Sahlberg
| email | Käyttäjän sähköposti | mauri.sahlberg@advania.com

### Jäsenen lisääminen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /systemGroup/member | POST | Taikaviitat|

Parametrit:

| Parametri | Selitys | Esimerkki |
|-----------|---------|-----------|
| user_id | Lisättävän käyttäjän tunniste | 4
| group_id | Ryhmän johon lisätään tunniste | 3


### Jäsenen poistaminen

| Osoite | Tyyppi | Oikeudet |
|--------|--------|----------|
| /systemGroup/{id}/members/{id}|DELETE|Taikaviitat, Käyttäjät|

| Parametri | Selitys | Esimerkki |
|-----------|--------|----------|
| id | Ryhmän, josta poistetaan, tunniste | 8
| memberid | Poistettava jäsen| 3

