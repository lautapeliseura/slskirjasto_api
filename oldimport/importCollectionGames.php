<?php
namespace App\Models;
$collections = file("collectiongames.csv");
foreach($collections as $lineNumber=>$line) {
    $d = explode(';', $line);
    $fs = [ "collection_id", "gamename", "group_id", "donor_id", "shelf_place", "condition", "note", "barcode", "publisher", "added_to_collection_at", "oldgameid" ];
    $a = [];
    foreach($fs as $i=>$f) {
        $d[$i]=trim($d[$i]);
        if ($d[$i]=='') {
            $d[$i]=null;
        }    
        switch($f) {
            case "collection_id":
                $collection = Collection::firstWhere("collection_name",$d[$i]);
                $a[$f]=$collection["id"];
                break;
            case "gamename":              
                /*$w = sprintf("'{\"%s\"}' <@ names", str_replace("'","''",$d[$i]));
                $game = Game::whereRaw($w)->first();
                if ($game==null) {
                    printf("Warning! Game with name %s was not found! %s", $d[$i], PHP_EOL);
                } else {
                    $a["game_id"]=$game["id"];
                }*/
                $a[$f]=$d[$i];
                break;
            case "group_id":
                if ($d[$i]!=null) {
                    $group = Group::firstWhere("group_name", $d[$i]);
                    $a[$f]=$group["id"];
                } else {
                    $a[$f]=$d[$i];
                }
                break;
            case "donor_id":
                if($d[$i]!=null) {
                    $donor = Donor::firstWhere("donor_name", $d[$i]);
                    if ($donor==null) {
                        printf("Warning! Donor with name %s was not found! %s", $d[$i], PHP_EOL);
                    } else {
                        $a[$f] = $donor["id"];
                    }
                } else {
                    $a[$f]=$d[$i];
                }
                break;
            case "oldgameid" :
                $game = Game::firstWhere("oldid", $d[$i]);
                if($game==null) {
                    printf("Warning! Game %s with %d was not found! %s", $a["gamename"], $d[$i], PHP_EOL);
                } else {
                    $a["game_id"]=$game["id"];
                }
                break;
            default:
                $a[$f] = $d[$i];
                break;

        }
    }
    $a["created_by"]="tinker importCollectionGames.php";
    $collectiongame = Collectiongame::create($a);
}