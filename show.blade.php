// This is the submissions page.
@extends('layouts.layout')
@section('content')
@php

$submissions = DB::table('PlantSubmission')->where('plantId','=',$plant->plantId)->get();

@endphp



<div class="container">
    <div class="text-center">
        <h1>{{ $plant->commonName }}</h1>
        <div class="row">
            <div class="col-6">
                <h4>Genus: {{$plant->genus}}</h4>
            </div>
            <div class="col-6">
                <h4>Species: {{$plant->species}}
            </div>
        </div>
        <h4><a href="/submissions/create">(Add Submission)</a></h4>
    </div>
    <table class="table">
            <thead>
                <tr>
                <th scope="col">Upvotes</th>
                <th scope="col">Title</th>
                <th scope="col">Plant Scientific Name</th>
                <th scope="col">Author</th>
                <th scope="col">Upload Date</th>
                </tr>
            </thead>
            <tbody>
                @foreach($submissions as $submission)
                <tr>
                    <td>
                        {{$submission->upvotes}}
                    </td>
                    <th>
                        <a href="/submissions/{{$submission->plantSubmissionId}}"> {{$submission->title}} </a>
                    </th>
                    <td>
                     {{DB::table('Plant')->where('plantId', $submission->plantId)->first()->genus}} {{DB::table('Plant')->where('plantId', $submission->plantId)->first()->species}} 
                    </td>
                    <td>
                        {{DB::table('users')->where('userId', $submission->userId)->first()->email}}
                    </td>
                    <td>
                        {{$submission->created_at}}
                    </td>
                </tr>
                    @endforeach
            </tbody>
        </table>
</div>
 
    
</div>
</body>
@endsection
