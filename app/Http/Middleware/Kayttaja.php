<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Http\Models\User;

class Kayttaja
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        $user = auth('sanctum')->user();
        if (!$user) {
            return response()->json(["error"=>"Um, no user?"], 400);
        }
        $t = $user->groups()->where('group_name', 'Taikaviitat')->orWhere('group_name', 'Käyttäjät')->first();
        if (is_null($t)) {
            return response()->json(['error'=>'Sorry, not permitted'], 400);
        }
        return $next($request);
    }
}
