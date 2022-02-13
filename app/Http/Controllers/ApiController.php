<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ApiController extends Controller
{
    protected function notFound(string $what) {
        return response()->json(["error"=>$what], 404);
    }

    protected function failed(string $what) {
        return response()->json(["error"=>$what], 422);
    }

    protected function success(string $what) {
        return response()->json(["success"=>$what], 200);
    }

    protected function missing(string $what) {
        return response()->json(["error"=>$what], 400);
    }
}
