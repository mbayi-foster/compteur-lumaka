<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CustomController extends Controller
{
    public function getAllModels($sub_folder = "")
    {
        $modelList = [];
        if (!empty($sub_folder)) {
            $path = app_path() . "/Models/" . $sub_folder;
        } else {
            $path = app_path() . "/Models";
        }
        $results = scandir($path);
        foreach ($results as $result) {
            if ($result === '.' || $result === '..') continue;
            $filename = $result;

            if (is_dir($path . "/" . $filename)) {
                $modelList = array_merge($modelList, $this->getAllModels($filename));
            } else {
                $modelList[] = substr($filename, 0, -4);
            }
        }
        return $modelList;
    }
    public function getAllOperations()
    {
        $operationList = ['create', 'read', 'update', 'delete'];
        return $operationList;
    }
}