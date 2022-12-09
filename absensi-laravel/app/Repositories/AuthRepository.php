<?Php

namespace App\Repositories;

use App\Models\User;

class AuthRepository 
{
    protected $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }

    public function save($data)
    {
        return $this->user
                    ->create($data);
    }

    public function byEmail($email)
    {
        return $this->user
                    ->where('email', $email)
                    ->first();
    }

}