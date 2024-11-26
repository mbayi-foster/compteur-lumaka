<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Role;
use App\Models\User;

class AdminController extends Controller
{
    public function dashboard()
    {
        $roles = Role::pluck('name', 'id')->all();
        $users = User::all();
        return view("admin.dashboard", compact('users', 'roles'));
    }
}
