<?php

namespace App\Http\Controllers\API;

use App\Models\Absen;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Library\ApiHelper;
use App\Http\Library\Validation\AbsenValidationRules;
use App\Services\AbsenService;
use Illuminate\Support\Facades\Validator;

class AbsenController extends Controller
{

    use AbsenValidationRules, ApiHelper;

    protected $absenService;

    public function __construct(AbsenService $absenService)
    {
        $this->absenService = $absenService;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $all_req = request()->all();

        $validator = Validator::make(
            $all_req, 
            $this->listAbsenRules()
        );
        
        if ($validator->fails()) 
        {
            return $this->onError(400, $validator->errors()->toArray(), "kesalahan validasi");
        }

        return $this->absenService->list($all_req['rows'] ?? 25, $all_req['name']);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make(
            $request->all(), 
            $this->addAbsenRules()
        );
        
        if ($validator->fails()) 
        {
            return $this->onError(400, $validator->errors()->toArray(), "kesalahan validasi");
        }

        return $this->absenService->saveAbsen($request->all());
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Absen  $absen
     * @return \Illuminate\Http\Response
     */
    public function show(Absen $absen)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Absen  $absen
     * @return \Illuminate\Http\Response
     */
    public function edit(Absen $absen)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Absen  $absen
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Absen $absen)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Absen  $absen
     * @return \Illuminate\Http\Response
     */
    public function destroy(Absen $absen)
    {
        //
    }
}
