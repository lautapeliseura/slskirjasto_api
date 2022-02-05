<?php
namespace App\Models;
$games = file("games.csv");
foreach($games as $lineNumber=>$line) {
    $d = explode(';',$line);
    $fs = [ "names", "designers", "publishers", "gtin", "source", "bggurl", "bggrank", "bggdate", "bggscore", "durationmin",
            "durationmax", "minplayers", "maxplayers", "yearpublished", "agesince", "ageuntil", "oldid" ];

    $a = [];
    foreach($fs as $i=>$f) {
        $d[$i]=trim($d[$i]);
        if ($d[$i]=='') {
            $d[$i]=null;
        }        
        $a[$f]=$d[$i];
    }
    $a["created_by"]="tinker importGames.php";
    $game=Game::create($a);
}
?>