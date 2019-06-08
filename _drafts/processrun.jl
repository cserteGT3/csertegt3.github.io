module WorkoutProcessor

using Dates


export AbstractWorkoutType, RunningWorkout, GymWorkout
export Workout

abstract type AbstractWorkoutType end

struct RunningWorkout <: AbstractWorkoutType
	place::String
	duration::Time
	distance::Float64
	averagepace::Float64
end

struct GymWorkout <: AbstractWorkoutType
	type::String
	place::String
	duration::Time
end


struct Workout{T<:AbstractWorkoutType}
	date::DateTime
	weight::Float64
	workout::T
	effort::Union{Int64, Nothing}
	notes::Union{String, Nothing}
end


end