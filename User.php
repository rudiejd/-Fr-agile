<?php

namespace App;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use DB;
/**
 * Default User model that comes pre-installed with laravel. 
 * This class will Authorize  User with name, email and password
 */
class User extends Authenticatable
{
    use Notifiable;


    protected $primaryKey = 'userId';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function isAdmin() {
        if (sizeof(DB::table('Admin')->where('userId', '=', $this->userId)->get()) > 0 ) {
            return true;
        }
        else {
            return false; 
        }
    }
}
