<?php
namespace App\Models;
$events = file("events.csv");
$group = Group::where("group_name","SLS")->get();
foreach($events as $lineNUmber=>$line) {
    $d = explode(';', $line);
    $fs = [ "event_name", "event_location", "event_starts", "event_ends" ];
    $a = [];
    foreach($fs as $i=>$f) {
        $d[$i]=trim($d[$i]);
        if ($d[$i]=='') {
            $d[$i]=null;
        }        
        $a[$f]=$d[$i];
    }
    $a["group_id"]=$group[0]["id"];
    $a["created_by"]="tinker importEvents.php";
    $a["publicity"]='{"PUBLIC"}';
    $event=Event::create($a);
}