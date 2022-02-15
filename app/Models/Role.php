<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    protected $hidden = [ 
            "created_at"
            , "created_by"
            , "updated_at"
            , "updated_by"
            , "schema_version"
    ];
}
