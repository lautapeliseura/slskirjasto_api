<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends ApiController
{
    function get(Request $request) {
        return $request->user();        
    }
    
    function getTokens(Request $request) {
        return $request->user()->personal_access_tokens()->get()->toJson();
    }
    
    function deleteToken(Request $request, $id) {
        $user = $request->user();
        if(preg_match('/^\d$/', $id)) {
            $token = $user->personal_access_tokens()->where('id', $request['id'])->first();
            if ($token) {
                $token->delete();
                return response()->json(['success'=>'Token succesfully deleted.'],200);
            }
        }
        return response()->json(['error'=>'Token not deleted.'] ,400);
    }
    
    function getUsers(Request $r) {
        return User::get()->toJson();
    }

    function getGroups(Request $r) {
        return $r->user()->groups()->get()->toJson();
    }

}
