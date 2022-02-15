<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\SystemGroupController;
use App\Http\Controllers\OwnerGroupController;
use App\Http\Controllers\RoleController;
use App\Http\Middleware\Taikaviitta;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::controller(UserController::class)->middleware(['auth:sanctum'])->group(function (){
    Route::get('/user', 'get');
    Route::get('/user/tokens', 'getTokens');
    Route::delete('/user/token/{id}', 'deleteToken');
    Route::get('/user/groups', 'getGroups');
});

Route::controller(UserController::class)->middleware(['auth:sanctum', 'kayttaja'])->group(function() {
    Route::get('users', 'getUsers');
});
Route::get('login/{provider?}', [LoginController::class, 'redirectToProvider'])->name('login');
Route::get('login/{provider}/callback', [LoginController::class, 'handleProviderCallback']);

Route::controller(SystemGroupController::class)->middleware(['auth:sanctum','taikaviitta'])->group(function () {
    Route::get('/systemGroups', 'getGroups');
    Route::get('/systemGroup/{id}/', 'getGroup');
    Route::get('/systemGroup/{id}/members', 'getGroupMembers');
    Route::post('/systemGroup/member', 'addMember');
    Route::delete('/systemGroup/{id}/member/{memberid}', 'deleteMember');
});

Route::controller(OwnerGroupController::class)->middleware(['auth:sanctum', 'kayttaja'])->group(function () {
    Route::get('/ownerGroups', 'getGroups');
    Route::post('/ownerGroup', 'create');
    Route::get('/ownerGroup/{id}/members', 'getGroupMembers');
    Route::post('/ownerGroup/member', 'addMember');
    Route::delete('/ownerGroup/{id}', 'delete');
    Route::patch('/ownerGroup', 'update');
    Route::delete('/ownerGroup/{id}/members/{memberid}', 'deleteMember');
});

Route::controller(RoleController::class)->middleware(['auth:sanctum', 'kayttaja'])->group(function () {
    Route::get('/roles', 'getRoles');
});