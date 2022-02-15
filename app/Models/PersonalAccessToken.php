<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PersonalAccessToken extends Model
{
    use HasFactory;

    protected $hidden =  [ 
            "tokenable_type"
            , "tokenable_id"
            , "name"
            , "abilities"
            , "created_at"
            , "updated_at"

    ];
      
}
