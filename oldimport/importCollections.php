<?php
namespace App\Models;
$collections = file("collections.csv");
foreach($collections as $lineNumber=>$line) {
    $d = explode(';', $line);
    $fs = [ "collection_name", "collection_class", "group_id", "event_id", "publicity" ];
    $a = [];
    foreach($fs as $i=>$f) {
        $d[$i]=trim($d[$i]);
        if ($d[$i]=='') {
            $d[$i]=null;
        }    
        switch($f) {
            case "collection_name":
            case "collection_class":
            case "publicity":
                $a[$f]=$d[$i];
                break;
            case "group_id":
                $group = Group::firstWhere("group_name", $d[$i]);
                $a[$f]=$group["id"]??null;
                break;
            case "event_id":
                $event = Event::firstWhere("event_name", $d[$i]);
                $a[$f] = $event["id"]??null;
                break;
        }
    }
    $a["created_by"]="tinker importCollections.php";
    $collection = Collection::create($a);
}