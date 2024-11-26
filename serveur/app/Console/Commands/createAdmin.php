<?php

namespace App\Console\Commands;

use App\Models\User;
use App\Models\Role;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;


class createAdmin extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'make:admin';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $user = User::create([
            'name' => 'Admin',
            'email' => 'ucc@admin.com',
            'password' => bcrypt('123456')
        ]);
        $roleId = DB::table('roles')->where('name', 'Admin')->get('id')->first();
        $user->assignRole($roleId);
        return $this->info("the Admin user created successfully");
    }
}
