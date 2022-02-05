## slskirjasto_api

This repository contains database backend for Finnish Board Game Society game library. The backend is going to be REST-API on Postgresql database implemented with 
[Laravel 8.x](www.laravel.com) using [Socialite](https://laravel.com/docs/8.x/socialite) and [Sanctum](https://laravel.com/docs/8.x/sanctum). This project is replacing the old game [library](https://github.com/daFool/slskirjasto) hopefully during spring 2022.

The architecture will consist of following components:
* A master instance of at least version 14 [Postgresql database](www.Postgresql.org) which may be replicated. 
* At least one API instance - possibly inside container
* Several UI applications consuming the API
* OAuth authentication providers: at least Google, Facebook and GitHub

This repository contains code for the API and the database. This a work in progress. Rest of the documentation will be in Finnish until someone translates it to the English.

Varsinainen dokumentaatio löytyy kansiosta [docs](docs/) ja jos sinulla ei ole kilkettä md-tiedostojen lukemiseen, kannattaa aloittaa tiedostosta [usage.md](docs/usage.md), jossa mm kerrotaan miten voit rakentaa ja asentaa koko dokumentaation.

