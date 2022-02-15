<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class vOwnergroupmember extends Model
{
    use HasFactory;

    protected $table="vOwnergroupmembers";
    protected $hidden=["user_id", "group_type"];
}
