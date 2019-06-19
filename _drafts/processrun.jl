module WorkoutProcessor

using Dates


export AbstractWorkoutType, RunWorkout, GymWorkout, SwimWorkout
export Workout
export parseworkouttype, parseline
export gettraining
export isrun, isswim, isgym
export runindices, swimindices, gymindices

abstract type AbstractWorkoutType end

struct RunWorkout <: AbstractWorkoutType
	road::String
	duration::Time
	distance::Float64
end

struct GymWorkout <: AbstractWorkoutType
	type::String
	duration::Time
end

struct SwimWorkout <: AbstractWorkoutType
	type::String
	duration::Time
	distance::Float64
end

struct Workout{T<:AbstractWorkoutType}
	date::DateTime
	weight::Float64
	place::String
	training::T
	effort::Union{Int64, Nothing}
	notes::Union{String, Nothing}
end

gettraining(w::Workout) = w.training

const DATEFORMAT = "yyyy.mm.dd-H:M"

nothinger(x) = x == "" ? nothing : x
nothinger(x::AbstractString) = x == "" ? nothing : String(x)


function parseworkouttype(l)
	if l[5] == "run"
		# run workout
		return RunWorkout(String(l[6]), Time(l[7], DateFormat("H:M:S")), l[8])
	elseif l[5] == "swim"
		# swim workout
		return SwimWorkout(String(l[6]), Time(l[7], DateFormat("H:M:S")), l[8])
	elseif l[5] == "gym"
		# gym workout
		return GymWorkout(String(l[6]), Time(l[7], DateFormat("H:M:S")))
	else
		throw(ArgumentError(l[5]*" is not a valid workout type!"))
		return nothing
	end
end


function parseline(l, dateform)
	time = DateTime(l[1]*"-"*l[2], dateform)
	inot = nothinger(l[9])
	comnot = nothinger(l[10])
	Workout(time, l[3], String(l[4]), parseworkouttype(l), inot, comnot)
end

isrun(w::Workout) = gettraining(w) isa RunWorkout
isswim(w::Workout) = gettraining(w) isa SwimWorkout
isgym(w::Workout) = gettraining(w) isa GymWorkout

runindices(W) = [isrun(w) for w in W]
swimindices(W) = [isswim(w) for w in W]
gymindices(W) = [isgym(w) for w in W]

end # module
