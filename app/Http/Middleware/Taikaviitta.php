<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class Taikaviitta
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
        $user = $request->user();
        if (!$user) {
            return response()->json([ 'error'=>"Um, no user?"], 400);
        } 
        $t = $user->groups()->firstWhere('group_name', 'Taikaviitat');
        if (!$t) {
            return response()->json(['error'=>"Sorry, not permitted"], 400);
        }
        return $next($request);
    }
}
