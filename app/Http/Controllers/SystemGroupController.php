<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Group;

class SystemGroupController extends Controller
{
    function getGroups() {
        return Group::where("group_type", "System")->get()->toJson();
    }

    protected function fetchGroup(string $id) {
        if(!preg_match('/^\d+$/', $id)) {
            return response()->json(['error'=>"Which group?", 400]);
        }
        $g=Group::where('id', $id)->where('group_type', 'System')->first();
        if (!$g) {
            return response()->json(['error'=>"Group not found"], 404);
        }
        return $g;
    }
    
    function getGroup(Request $request, $id) {
        return $this->fetchGroup($id)->get()->toJson();
    }

    function getGroupMembers(Request $request, $id) {
        return $this->fetchGroup($id)->users()->get()->makeHidden('laravel_through_key')->toJson();
    }
}
