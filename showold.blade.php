// function of DELETE Plant.
@extends('layouts.layout')
@section('content')


<div class="content text-center">
    @if (isset($plant))
        <h1>{{ $plant['commonName']}}</h1>

        @if (Auth::user() !== null && Auth::user()->isAdmin())
            <form action="/plants/{{ $plant['plantId'] }}" method="POST">
                @csrf
                <input type="hidden" name="userId" value="{{Auth::id()}}">
                @method('DELETE')
                <button>Delete plant</button>
            </form>
        @endif




    @else
        <h1> Plant not found </h1>
    @endif

</div>
</body>
@endsection
