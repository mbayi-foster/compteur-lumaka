<?php

namespace App\Console\Commands;
use App\Models\Role;
use Illuminate\Console\Command;

class createRole extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'make:role';

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
        //
        $role = Role::create(['name' => 'Admin']);

        return $this->info('the superAdmin Role created succeffully');

    }
}
