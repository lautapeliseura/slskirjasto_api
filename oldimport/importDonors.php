<?php
namespace App\Models;
$events = file("donors.csv");
//$group = Group::where("group_name","SLS")->get();
foreach($events as $lineNUmber=>$line) {
    $d = explode(';', $line);
    $fs = [ "donor_name", "credit" ];
    $a = [];
    foreach($fs as $i=>$f) {
        $d[$i]=trim($d[$i]);
        if ($d[$i]=='') {
            $d[$i]=null;
        }        
        $a[$f]=$d[$i];
    }
    //$a["group_id"]=$group[0]["id"];
    $a["created_by"]="tinker importDonors.php";
    //$a["publicity"]='{"PUBLIC"}';
    $event=Donor::create($a);
}