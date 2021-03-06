# Projektin tilanne ja seuraavat askeleet

| Päivämäärä | Tavoite | Status | Askel |
|------------|---------|-------|--------|
| 2022-02-06 | 2022-02-13 | Kesken | Socialite, käyttäjien hallinta [2](#socialite-ja-k%C3%A4ytt%C3%A4jien-hallinta)|
| 2022-02-05 | 2022-02-06 | Valmis | Uuden kantarakenteen demoasennus ja github-repository [1](#uuden-kantarakenteen-demoasennus-ja-github-repository) |


## Uuden kantarakenteen demoasennus ja github-repository

Tavoitteet:  

* SLS:n organisaatiossa on GitHub-repository
* Projektin dokumentaatio on katsottavissa osoitteessa [generalfailure.net/slskirjasto_api](http://generalfailure.net/slskirjasto_api)
* Uusi ja vanha kanta ovat kyseisellä koneella
* Uuteen kantaan on pari demoraporttia katsottavissa php-reportsilla
* Demoasennus on [dokumentoitu](demo.md)
 
## Socialite ja käyttäjien hallinta

Tavoitteet:  

* Sanctum on konfiguroitu 
* Socialite on konfigoroitu
* APIin voi rekisteröityä käyttäjäksi APIn kautta, GitHub
* Jos käyttäjä on _taikaviitta_, voi tämä APIn kautta katsoa, luoda, poistaa ja muokata käyttäjäryhmiä API-kutsuilla
* Jos käyttäjä on _taikaviitta_, voi tämä APIn kautta liittää ja poistaa käyttäjiä ryhmiin API-kutsuilla
* Käyttäjäryhmien ja käyttäjien hallintaan liittyvät api-kutsut on dokumentoitu ja löytyvät demokoneelta.
* Käyttöikeusmekanismi on dokumentoitu [dokumentaatiossa](api/permissions.md).
