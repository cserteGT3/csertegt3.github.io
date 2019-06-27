using Revise
using DelimitedFiles
using Dates

includet("processrun.jl")

using .WorkoutProcessor

daef = WorkoutProcessor.DATEFORMAT

ds, dsh = readdlm("_drafts\\run2.tsv", '\t', header = true)
parseline(ds[1,:], daef)

ws = [parseline(ds[i,:], daef) for i in 1:size(ds,1)]

run_ind = runindices(ws)
runlengths = getdistance.(ws[run_ind])
rundates = getdate.(ws[run_ind])

using Plots

plt = Plots.plot(rundates, runlengths)
plt = Plots.scatter(rundates, runlengths)
