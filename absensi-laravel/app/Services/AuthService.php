<?Php

namespace App\Services;

use App\Http\Library\ApiHelper;
use App\Repositories\AuthRepository;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthService
{
    use ApiHelper;

    protected $authRepository;

    public function __construct(AuthRepository $authRepository)
    {
        $this->authRepository = $authRepository;
    }
    
    public function createUser($data)
    {
        try 
        {
            $user = $this->authRepository->save([
                'name' => $data['name'],
                'email' => $data['email'],
                'password' => Hash::make($data['password'])
            ]);

            $user['token'] = $user->createToken("API TOKEN")->plainTextToken;

            return $this->onSuccess(200, $user, "Successfully create account");
        } catch (\Throwable $th) {
            logger($th->getMessage());
            return $this->onError(500, ['Please report to admin'], 'Failed to create account');
        }
    }

    /**
     * Login The User
     * @param Request $request
     * @return User
     */
    public function loginUser($data)
    {
        try 
        {
            if(!Auth::attempt($data)) return $this->onError(400, ['Email & Password does not match with our record.'], "Failed login");

            $user = $this->authRepository->byEmail($data['email']);

            $user['token'] = $user->createToken("API TOKEN")->plainTextToken;

            return $this->onSuccess(200, $user, "Successfully login");
        } catch (\Throwable $th) {
            logger($th->getMessage());
            return $this->onError(500, ['Please report to admin'], 'Failed to create account');
        }
    }
}