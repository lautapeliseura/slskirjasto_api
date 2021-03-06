<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'email_verified_at',
        'remember_token',
        'created_at',
        'updated_at'
        ,"laravel_through_key"
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    function providers() {
        return $this->hasMany(Provider::class, 'user_id', 'id');
    }

    function groups() {
        return $this->belongsToMany(Group::class, 'groupmembers', 'user_id', 'group_id');
    }

    function personal_access_tokens() {
        return $this->hasMany(PersonalAccessToken::class, 'tokenable_id');
    }

    function isTaikaviitta() : bool {
        return $this->groups()->firstWhere('group_name','Taikaviitat') ? true : false;
    }
 }
