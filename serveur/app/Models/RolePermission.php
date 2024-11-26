<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RolePermission extends Model
{
    use HasFactory;
     protected $table = 'role_permissions';

     protected $fillable = [
        'id',
        'role_id',
        'object',
        'operation'
     ];
     
     public function role(){
        return $this->belongsTo(Role::class, 'role_id', 'id');
     }
}