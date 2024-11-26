
<?php

use App\Http\Controllers\CustomController;

use App\Models\Role;
use App\Models\RolePermission;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RoleController extends CustomController
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $roles = Role::all();

        return view('admin.roles.index', compact('roles'));
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('roles.create');
    }
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|unique:roles,name',
        ]);

        $role = Role::create(['name' => $request->input('name')]);

        return redirect()->route('roles.index')
            ->with('status', 'Role créé avec succès .');
    }
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
        DB::table("roles")->where('id', $id)->delete();
        return redirect()->route('roles.index')
            ->with('status', 'Role supprimé avec succès .');
    }
    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $role = Role::find($id);

        $operations = $this->getAllOperations();
        $models = $this->getAllModels();
        return view('admin.roles.edit', compact('role', 'operations', 'models'))->with('class', $this);
    }
    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'name' => 'required',
            'models' => 'required',
        ]);

        $role = Role::find($id);
        $input = $request->all();
        $models = $request->models;
        foreach ($models as $model) {
            $operations = $input['operators' . $model . ''];
            foreach ($operations as $operation) {
                if (!empty($input['id' . $model . $operation . ''])) {
                    $i = $input['id' . $model . $operation . ''];
                    if (!isset($input['permissions' . $model . $operation . ''])) {
                        $rolePermissions = RolePermission::find($i);
                        $rolePermissions->delete();
                    }
                } else {
                    if (isset($input['permissions' . $model . $operation . ''])) {
                        $create = new RolePermission();
                        $create->role_id = $id;
                        $create->operation = $operation;
                        $create->object = $model;
                        $create->save();
                    }
                }
            }
        }
        $role->name = $request->input('name');
        $role->update();
        return redirect()->route('roles.index')
            ->with('status', 'Role modifié avec succès .');
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if (DB::table("roles")->where('id', $id)->where('name', 'Admin')) {
            return redirect()->route('roles.index')
                ->with('danger', 'Le role Admin ne peut pas etre supprimer!');
        } else {
            // DB::table("roles")->where('id', $id)->delete();
            Role::find($id)->delete();
            return redirect()->route('roles.index')
                ->with('success', 'Role supprimé avec succès .');
        }
    }

    public function addPermissions(Request $request, $id)
    {
        $validated = $request->validate([
            'name' => 'required',
            'operations' => 'required',
            'model' => 'required',
        ]);

        $role = Role::find($id);
        $input = $request->all();
        foreach ($input['operations'] as $operation) {

            $rolePermissions = RolePermission::create([
                'role_id' => $id,
                'object' => $input['model'],
                'operation' => $operation,
            ]);
        }

        $role->name = $request->input('name');
        $role->save();
    }
    public function checkPermission($object, $operation, $role)
    {
        $query = DB::select('select id from role_permissions where object = \'' . $object . '\' and operation = \'' . $operation . '\' and role_id = ' . $role . '');
        if (count($query) > 0) {
            return $query[0]->id;
        } else {
            return false;
        }
    }
    public function autorisations($id)
    {
        return RolePermission::where('role_id', $id)->get();
    }
}
