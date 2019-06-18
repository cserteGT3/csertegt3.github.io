module WorkoutProcessor

using Dates


export AbstractWorkoutType, RunningWorkout, GymWorkout
export Workout

abstract type AbstractWorkoutType end

struct RunningWorkout <: AbstractWorkoutType
	road::String
	distance::Float64
	duration::Time
end

struct GymWorkout <: AbstractWorkoutType
	type::String
	duration::Time
end


struct Workout{T<:AbstractWorkoutType}
	date::DateTime
	weight::Float64
	workout::T
	place::String
	effort::Union{Int64, Nothing}
	notes::Union{String, Nothing}
end


end
