<?php

namespace App\Http\Controllers;

use GuzzleHttp\Exception\ClientException;
use Illuminate\Http\Request;
use Laravel\Socialite\Facades\Socialite;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    //
    public function redirectToProvider($provider="github")
    {
        $validated = $this->validateProvider($provider);
        if (!is_null($validated)) {
            return $validated;
        }
        return Socialite::driver($provider)->stateless()->redirect();
    }

    public function handleProviderCallback($provider)
    {
        $validated = $this->validateProvider($provider);
        if (!is_null($validated)) {
            return $validated;
        }
        try {
            $user = Socialite::driver($provider)->stateless()->user();
        } catch (ClientException $exception) {
            return response()->json(['error'=>'Invalid credentials provided.'], 422);
        }
        $userCreated = User::firstOrCreate(
                [
                        'email' =>$user->getEmail()
                ],
                [
                    'email_verified_at'=>now(),
                    'name' => $user->getName(),
                    'status' => true,
                ]
                );
        $userCreated->providers()->updateOrCreate(
            [
                'provider' => $provider,
                'provider_id' => $user->getId(),
            ],
            [
                'avatar' => $user->getAvatar()
            ]
            );
        $token = $userCreated->createToken('token-name')->plainTextToken;
        Auth::login($userCreated);    
        return response()->json($userCreated, 200, ['Access-Token'=> $token]);
    }

    protected function validateProvider($provider)
    {
        if (!in_array($provider, explode(" ", env('AUTH_PROVIDERS')))) {
            return response()->json(['error'=>'Unsupported auth provider', 422]);
        }
    }
}
