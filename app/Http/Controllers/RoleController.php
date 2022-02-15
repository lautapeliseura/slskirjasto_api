<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Role;

class RoleController extends ApiController
{
    public function getRoles() {
        return Role::get()->toJson();
    }
}
