using Revise
using DelimitedFiles

includet("processrun.jl")

using .WorkoutProcessor

daef = WorkoutProcessor.DATEFORMAT

ds, dsh = readdlm("_drafts\\run2.tsv", '\t', header = true)
parseline(ds[1,:], daef)

ws = [parseline(ds[i,:], daef) for i in 1:size(ds,1)]
