<?php
namespace App\Models;
$collections = file("loans.csv");
foreach($collections as $lineNumber=>$line) {
    $d = explode(';', $line);
    $fs = [ "lent_at", "returned_at", "collectiongame_id", "game_id", "slsmember", "event_id" ];
    $a = [];
    foreach($fs as $i=>$f) {
        $d[$i]=trim($d[$i]);
        if ($d[$i]=='') {
            $d[$i]=null;
        }    
        switch($f) {
            case "collectiongame_id":
                $collectiongame = Collectiongame::firstWhere("barcode",$d[$i]);
                $a[$f]=$collectiongame["id"]??null;
                break;
            case "game_id":              
                $a["game_id"]=$collectiongame["game_id"]??null;
                break;
            case "event_id":
                $event = Event::firstWhere("event_name",$d[$i]);
                $a[$f]=$event["id"]??null;
                break;
    
            default:
                $a[$f] = $d[$i];
                break;

        }
    }
    $a["created_by"]="tinker importLoans.php";
    $loan = Loan::create($a);
}
?>
