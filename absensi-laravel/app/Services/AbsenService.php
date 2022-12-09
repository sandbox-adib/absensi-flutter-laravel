<?Php

namespace App\Services;

use App\Exports\AllRoleExport;
use App\Http\Library\ApiHelper;
use App\Repositories\AbsenRepository;
use InvalidArgumentException;
use Maatwebsite\Excel\Facades\Excel;

class AbsenService
{
    use ApiHelper;

    protected $absenRepository;

    public function __construct(AbsenRepository $absenRepository)
    {
        $this->absenRepository = $absenRepository;
    }
    
    public function saveAbsen($data)
    {
        try 
        {
            $new_absen = $this->absenRepository->save($data);
        
            return $this->onSuccess(200, $new_absen, 'Berhasil absen');
        } catch (\Throwable $th) 
        {
            logger($th->getMessage());
            return $this->onError(500, ['Lapor ke admin'], 'Gagal absen');
        }
    }

    public function list($row, $name)
    {
        try 
        {
            $list_absen = $this->absenRepository->paginateAllByName($row, $name);

            return $this->onSuccess(200, $list_absen, 'Berhasil ambil daftar absen');
            
        } catch (\Throwable $th) 
        {
            logger($th->getMessage());
            return $this->onError(500, ['Lapor ke admin'], 'Gagal ambil daftar absen');
        }
    }
}