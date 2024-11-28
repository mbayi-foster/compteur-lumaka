<?php

namespace App\Models;

use App\Models\RolePermission;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    protected $table = 'roles';

    protected $fillable = [
        'id',
        'name',
    ];

    public function permissions()
    {
        return $this->hasMany(RolePermission::class, 'role_id', 'id');
    }
    public function users()
    {
        return $this->belongsToMany(User::class, 'user_roles');
    }
    public function checkPermission($object, $operation)
    {
        $query = DB::select('select id from role_permission where object = ' . $object . ' and operation = ' . $operation . ' and role_id = ' . $this->id . '');
        if (count($query) > 0) {
            return true;
        } else {
            return false;
        }
    }
}