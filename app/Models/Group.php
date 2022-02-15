<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Group extends Model
{
    use HasFactory;
    protected $hidden=[ 
            "schema_version"
            , "group_type"
            , "pivot"
    ];
    protected $guarded=[];

    function users() {
        return $this->hasManyThrough(User::class, Groupmember::class, 'group_id', 'id', 'id', 'user_id');
    }

    function collections() {
        return $this->hasMany(Collection::class);
    }
}
