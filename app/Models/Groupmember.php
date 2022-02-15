<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Groupmember extends Model
{
    use HasFactory;
    protected $guarded=[];

    function role() {
        return $this->hasOne(Role::class, 'id','role_id');
    }

    function group() {
        return $this->hasOne(Group::class, 'id','group_id');
    }

    function user() {
        return $this->hasOne(User::class, 'id','user_id');
    }
}
