<?php

namespace App\Http\Library\Validation;

trait AbsenValidationRules
{
    protected function addAbsenRules()
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'type' => ['required', 'in:in,out'],
            'date_check' => ['required', 'date_format:Y-m-d H:i:s']
        ];
    }

    protected function listAbsenRules()
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'row' => ['numeric']
        ];
    }
}