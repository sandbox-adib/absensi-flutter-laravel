<?Php

namespace App\Repositories;

use App\Models\Absen;

class AbsenRepository 
{
    protected $absen;

    public function __construct(Absen $absen)
    {
        $this->absen = $absen;
    }

    public function save($data)
    {
        return $this->absen
                    ->create($data);
    }

    public function paginateAllByName($rows, $name)
    {
        return $this->absen
                    ->where('name', $name)
                    ->latest()
                    ->paginate($rows);
    }
}