<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Group;
use App\Models\Groupmember;
use App\Models\User;
use App\Models\Role;

class SystemGroupController extends ApiController
{
    function getGroups() {
        return Group::where("group_type", "System")->get()->toJson();
    }

    protected function fetchGroup(string $id) {
        if(!preg_match('/^\d+$/', $id)) {
            return $this->missing("Which group?");            
        }
        $g=Group::where('id', $id)->where('group_type','System')->first();
        if (!$g) {
            return $this->notFound(("Group not found"));
        }
        return $g;
    }
    
    function getGroup(Request $request, $id) {
        return $this->fetchGroup($id)->toJson();
    }

    function getGroupMembers(Request $request, $id) {
        return $this->fetchGroup($id)->users()->get()->makeHidden('laravel_through_key')->toJson();
    }

    function addMember(Request $request) {        
        $group = $this->fetchGroup(($request["group_id"]));
        $memberid = $request["user_id"];
        if(!preg_match('/^\d+$/', $memberid) || is_null(User::firstWhere("id", $memberid))) {
            return $this->notFound("Member not found");            
        }
        $role = Role::firstWhere("role_name", 'Owner');
        $gm = Groupmember::firstOrCreate(
            [
                "user_id" => $memberid,
                "group_id" => $group["id"],                
            ],
            [
                "user_id" => $memberid,
                "role_id" => $role["id"],
                "group_id" => $group["id"],
                "created_by" => $request->user()["name"]
            ]
        );
        if (is_null($gm)) {
            return $this->failed("Group member creation failed");            
        }
        return $this->success("Group member added");
    }

    function deleteMember(Request $request, $id, $memberid) {
        $this->fetchGroup($id);
        if(!preg_match('/^\d+$/', $memberid) || is_null(User::firstWhere("id", $memberid))) {
            return $this->notFound("Member not found");            
        }
        $gm = Groupmember::where("user_id",$memberid)->where("group_id", $id)->first();
        if(is_null($gm)) {
            return $this->notFound("Member not in group");
        }
        $gm->delete();
        return $this->success("Group member removed");
    }
}
