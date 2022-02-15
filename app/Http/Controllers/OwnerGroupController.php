<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Group;
use App\Models\Groupmember;
use App\Models\User;
use App\Models\vOwnergroupmember;
use Illuminate\Support\Facades\Validator;

class OwnerGroupController extends ApiController
{
    private $group;
    //
    protected function hasRights(User $user, $group_id) {
        $this->group = Group::firstWhere("id", $group_id);
        if($user->isTaikaviitta()) {
            return true;
        }
     
        if($this->group && $this->group["user_id"]==$user["user_id"]) {
            return true;
        }
        $role = GroupMember::where("group_id", $group_id)->where("user_id", $user["user_id"])->first()->role()->first();
        if(is_null($role) || $role!="Owner") {
            return false;
        }
        return true;
    }

    function getGroups(Request $request) {
        if($request->user()->isTaikaviitta()) {
            return Group::where('group_type','Owner')->get()->toJson();
        }
        // return Group::where('group_type', 'Owner')->where('user_id', $request->user()['id'])->get()->toJson();
        return vOwnergroupmember::where('user_id', $request->user()['id'])->get()->toJson();
    }

    function create(Request $request) {
        $validator = Validator::make($request->all(),[
            'group_name' =>'required|unique:groups|max:255',
            'group_purpose' => 'required|max:255',
        ]);
        if($validator->fails()) {
            return $this->missing("Bad or missing parameters");
        }
        $group = new Group([
            "group_name" => $request["group_name"],
            "group_purpose" => $request["group_purpose"],
            "user_id" => $request->user()["id"],
            "created_by" => $request->user()["name"],
            "group_type" => "Owner"
        ]);
        $group->save();
        return $this->success("Group created");
    }

    function getGroupMembers(Request $request, $id) {
        if(!$this->hasRights($request->user(), $id)) {
            return $this->unauthorized("Not permitted");
        }
        $group = Group::where("id",$id)->where("group_type", "Owner")->first();
        if(is_null($group)) {
            return $this->notFound("Group not fonud");
        }        
        return $group->users()->get()->toJson();
    }

    function addMember(Request $request) {
        $validator = Validator::make($request->all(),[
            'user_id' =>'required|exists:users,id',
            'role_id' => 'required|exists:roles,id',
            'group_id' => 'required|exists:groups,id',
        ]);
        if($validator->fails()) {
            return $this->missing("Bad or missing parameters");
        }
        if(!$this->hasRights($request->user(), $request["group_id"])) {
            return $this->unauthorized("Not permitted!");
        }
        $gm = new Groupmember([
            "user_id" => $request["user_id"],
            "role_id" => $request["role_id"],
            "group_id" => $request["group_id"],
            "created_by" => $request->user()["name"],
        ]);
        $gm->save();
        return $this->success("Group member added");

    }

    function delete(Request $request, $id) {
        if(!$this->hasRights($request->user(), $id)) {
            return $this->unauthorized("Not permitted");
        }
        $g = Group::where("id", $id)->where("group_type", "Owner")->first();
        if(is_null($g)) {
            return $this->notFound("Group not found");
        }
        if($g->collections()->count()) {
            return $this->unauthorized("Group owns collections! Delete them first!");
        }
        $g->delete();
        return $this->success("Group deleted");
    }

    function update(Request $request) {
        $validator = Validator::make($request->all(),[
            'group_name' =>'required|max:255',
            'group_purpose' => 'required|max:255',
            'id' => 'required|exists:groups',
        ]);
        if($validator->fails()) {
            return $this->missing("Bad or missing parameters");
        }
        if(!$this->hasRights($request->user(), $request["id"])) {
            return $this->unauthorized("Not permitted!");
        }
        $group = Group::where("id", $request["id"])->where("group_type", "Owner")->first();
        if(is_null($group)) {
            return $this->missing("Group not found!");
        }
        if($group["group_name"]!=$request["group_name"]) {
            $g2 = Group::where("group_name", $request["group_name"])->first();
            if(!is_null($group)) {
                return $this->failed("Group with same name exists!");
            }
        }
        $group["group_name"]=$request["group_name"];
        $group["group_purpose"]=$request["group_purpose"];
        $group["updated_at"]=now();
        $group["updated_by"]=$request->user()['name'];
        $group->save();
        return $this->success("Group modified.");
    }

    function deleteMember(Request $request, $id, $memberid) {
        if(!$this->hasRights($request->user(), $id)) {
            return $this->unauthorized("Not permitted.");
        }
        if(!$this->group ||$this->group["group_type"]!="Owner") {
            return $this->failed("Bad group id");
        }
        $gm = Groupmember::where("group_id",$id)->where("user_id", $memberid)->first();
        if(is_null($gm)) {
            return $this->failed("Not member of the group");
        }
        $gm->delete();
        return $this->success("Membership cancelled");
    }
}
