<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Library\ApiHelper;
use App\Services\AuthService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    use ApiHelper;

    protected $authService;

    public function __construct(AuthService $authService)
    {
        $this->authService = $authService;
    }

    public function register(Request $request)
    {
        $validateUser = Validator::make($request->all(), 
        [
            'name' => 'required',
            'email' => 'required|email|unique:users,email',
            'password' => 'required',
        ]);

        if($validateUser->fails()){
            return $this->onError(400, $validateUser->errors()->toArray(), "Validation errors");
        }

        return $this->authService->createUser($request->all());
    }

    public function login(Request $request)
    {
        $validateUser = Validator::make($request->all(), 
        [
            'email' => 'required|email',
            'password' => 'required'
        ]);

        if($validateUser->fails()){
            return $this->onError(400, $validateUser->errors()->toArray(), "Validation errors");
        }

        return $this->authService->loginUser($request->only(['email','password']));
    }
}
