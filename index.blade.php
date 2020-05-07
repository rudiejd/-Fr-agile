//The page showing all plants with some submission information

@extends('layouts.layout')
@section('content')

   
    <div class="container">
        <div class="text-center">
            <h1>All Plants</h1>
            <h4><a href="/plants/create/">(Add Plant)</a></h4>
        </div>
        <table class="table">
            <thead>
                <tr>
                <th scope="col">Scientific Name</th>
                <th scope="col">Common Name</th>
                <th scope="col">Upload Date</th>
                </tr>
            </thead>
            <tbody>
                @foreach($plants as $plant)
                <tr>
                    <th>
                    <a href="/plants/{{$plant->plantId}}">{{$plant->species}}</a>
                    </td>
                    <td>
                        {{ $plant->commonName }}
                    </td>
                    <td>
                        {{ $plant->created_at->format('m/d/Y')}}
                    </td>
                </tr>
                 @endforeach
            </tbody>
        </table>
        <div class="row">
            {{$plants->links()}}
        </div>
        
    </div>
@endsection
