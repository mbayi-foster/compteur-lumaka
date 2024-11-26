<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class AuthenticatedSessionController extends Controller
{
    // /**
    //  * Handle an incoming authentication request.
    //  */
    // public function store(LoginRequest $request): Response
    // {
    //     $request->authenticate();

    //     $request->session()->regenerate();

    //     return response()->noContent();
    // }

    // /**
    //  * Destroy an authenticated session.
    //  */
    // public function destroy(Request $request): Response
    // {
    //     Auth::guard('web')->logout();

    //     $request->session()->invalidate();

    //     $request->session()->regenerateToken();

    //     return response()->noContent();
    // }

   public function register(Request $request)
   {
       try {
           $validateUser = Validator::make(
               $request->all(),
               [
                   'name' => 'required',
                   'email' => 'required|email',
                   'password' => 'required'
               ]
           );
   
           if ($validateUser->fails()) {
               return response()->json([
                   'status' => false,
                   'message' => 'validation errors',
                   'errors' => $validateUser->errors()
               ], 401);
           };
   
           $user = User::create([
               'name' => $request->name,
               'email' => $request->email,
               'password' => bcrypt($request->password)
           ]);
   
           $token = $user->createToken("myApiToken")->plainTextToken;
   
           return response()->json([
               'status' => true,
               'message' => 'User Created Successfully',
               'token' => $token
           ], 200);
       } catch (\Throwable $e) {
           return response()->json([
               'status' => false,
               'message' => $e->getMessage()
           ], 500);
       }
   }
   
   public function login(Request $request)
   {
       try {
           $validateUser = Validator::make(
               $request->all(),
               [
                   'name' => 'required',
                   'email' => 'required|email',
                   'password' => 'required'
               ]
           );
   
           if ($validateUser->fails()) {
               return response()->json([
                   'status' => false,
                   'message' => 'validation errors',
                   'errors' => $validateUser->errors()
               ], 401);
           };
   
           if (!Auth::attempt($request->only(['name', 'email', 'password']))) {
               return response()->json([
                   'status' => false,
                   'message' => 'Email & Password does not match with our record.',
               ], 200);
           }
   
           $user = User::where('email', $request->email)->first();
   
           $token = $user->createToken("myApiToken")->plainTextToken;
           return response()->json([
               'status' => true,
               'message' => 'User Logged In Successfully',
               'token' => $token
           ], 200);
       } catch (\Throwable $e) {
           return response()->json([
               'status' => false,
               'message' => $e->getMessage()
           ], 500);
       }
   }
}
