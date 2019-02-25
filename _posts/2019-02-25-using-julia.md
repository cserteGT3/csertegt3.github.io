---
layout: post
title: How to use Julia properly?
description: "Useful thoughts on using Julia."
modified: 2019-02-25
tags: [julia, development]
categories: [julia]
---
This post gathers useful thoughts on Julia.
These are not my ideas, I gathered some from everywhere on the internet.
I'll try and link the source everywhere it's possible.
Also this post planned to be updated.

### My mental load using Julia is much higher than, e.g., in Python. How to reduce it?

This is an extraction of a Julia discourse [thread](https://discourse.julialang.org/t/my-mental-load-using-julia-is-much-higher-than-e-g-in-python-how-to-reduce-it/18902).

#### rdeits

_I think what you’re talking about is “fluent interfaces”, and it’s true that we don’t really do that in Julia, at least not in the same way.
You might find the |> operator useful, since you can do:_
~~~julia
x |> f |> g
~~~
_as an alternative notation for_ `g(f(x))`.
_This should become even better when we (eventually) get [this PR](https://github.com/JuliaLang/julia/pull/24990) merged._

#### ssfrr

_Also in code examples.
When an example has several using Foo statements up top, it’s really hard to know which parts of the example come from which package.
Sometimes you can figure it out from context, but if you’re using a few packages that are related to each other it’s often ambiguous._

Maybe the `using` statements should be directly before the function calls?

#### Tamas_Papp

_In “scripts”, ie non-reused, non-packaged code, mostly for interactive exploration, I prefer just plain using Foo, and stick to using Foo: bar in packages (yes, even with LinearAlgebra :wink:).
I think both are useful, and looking up the module of a function is rather easy._

#### Orbots

_I find my mental load writing programs past a certain complexity level in Julia higher than other languages due to choice paralysis.
Which is a good thing, right? Still it’s a problem I struggle with.
The type system coupled with macros and multiple dispatch provide a set of very powerful, flexible building blocks._

_In something like C++ or python there are constraints imposed on you by the language that make many choices for you.
In Julia, I find myself wrecking my head trying to puzzle out the best abstractions/style to design my code around.
The awesome payoff is that when I “get it right” I have some very elegant code.
Like a shockingly small amount of code that does what would require an order of magnitude more C++ code._

_Things that I believe would lessen my mental load:_

* _formalized support of traits ( holy traits ) or multiple inheritance._
* _data inheritance ( maybe? possibly this is a constraint that actually reduces mental load )._
* _method discovery ( has been discussed in this thread )_
* _a stronger functional programming story, I gravitate to FP, and the Julia story is close, but unfinished._
* _if not FP then solidifying and supporting an idiomatic Julia style of some sort._
* _using, import, include, modules vs scripts story settling down into a solid idiomatic style of some sort._

Tamas_Papp
> IMO the best way to break out of this is to write something that just works, then iteratively refine as necessary.

_I’d usually write a first draft this way, then throw it away and rewrite a better version. Maybe repeat._

_Just starting that first something that works is not as straightforward in Julia as other languages.
I think this is because Julia atm lacks a strong opinion on how to write a program.
If it was C++ I’d start by writing some classes that mirror the domain entities and reach for some design patterns.
No brainer.
If it was Clojure I’d think about how I want to transform the data with higher order functions and isolate state changes as best as I can.
Python has documented opinions._

_In Julia I kind of start with the abstract data types and some functions, but I get to this point where I just start feeling a bit lost.
Part of me wants to code like it’s a lisp and another wants to code like it’s C++ and another part makes up a DSL with a bunch of macros._

_There are definitely well represented domains which appear to have solid opinions about how to do things.
e.g. Machine learning and mathematical modelling.
Could be that I’m just not in a well represented domain.
I’ll have to work on changing that._

#### Tero_Frondelius

_Maybe you should try [Test-driven development](https://en.wikipedia.org/wiki/Test-driven_development), if you haven’t already.
For many people it helps restructuring the code more naturally._

#### Stefan Karpinski

_For myself, I think about how I want to represent my data and define custom types if necessary, giving them the general behaviors I want them to have (and if I’m being good writing unit tests for all of those behaviors).
Then I start playing with my types and tackling the problem at hand.
This usually leads to realizing I’ve done some things wrong and having to change my data representations in some ways.
Then I proceed with the problem.
Iterate until done.
All of that is pretty similar to how I do things in other languages, although I find that designing data types is more limited and therefore simpler in Julia but I may be a bit biased._

#### mkborregaard

_FWIW when I did this years advent-of-code I decided to follow the paradigm that I should represent everything as close to the description/my intuitive understanding of the problem as closely as possible.
I.e. no looking-through-the-surface-into-the-underlying-maths but just writing the code that represented my thinking.
In most cases that worked surprisingly well, though there were a few cases which where clearly intended to be solved by knowing the mathematical algorithm (e.g. the square-summing exercise).
I think of that as the strength of Julia over e.g. R, where you always try to shoehorn the problem into vectorized predefined operations, or C++ where you always start by building up some big type hierarchy (for me, as not a professional programmer always requiring massive mental strain in terms of defining the best hierarchy).
So, with the risk of sounding flippant, maybe the key in Julia is to relax a little bit about the “optimal” approach and just writing the code that feels good to write in terms of your intuition?_

#### dlfivefifty

Orbots
> In Julia I kind of start with the abstract data types

_I think starting with abstract types is a mistake: most of the time functions work best with “interfaces” not types, that is, it’s not about the type, but about which functions the type overrides.
I’ve had to go back and delete type hierarchies several times when I realised that what started as an abstract type was better suited as a “trait”._

_In other words, I suggest starting projects with concrete types and functions, and only add abstract types when needed, and this should be motivated by software needs, not mathematical definitions._

#### Tamas_Papp

dlfivefifty
> I’ve had to go back and delete type hierarchies several times when I realised that what started as an abstract type was better suited as a “trait”.

_I had a similar experience. When I started programming Julia, I used to build elaborate type hierarchies like_

~~~julia
abstract type AbstractGizmo end
abstract type AbstractSpecialGizmo <: AbstractGizmo end
function f(g::AbstractGizmo)
    do_stuff(g)
end
~~~

_This gave me the illusion of doing something clever until I encountered things which wanted to be two or more kinds of abstract things at the same time.
Now whenever I refactor code, I tend do_

~~~julia
using ArgCheck

abstract type AbstractGizmo end
# not exported or part of the API, just for internal use

"Does the argument support the Gizmo interface?"
is_gizmo(::AbstractGizmo) = true
# could be a singleton type for traits, or just a boolean for testing
# user defines it for user-provided types

function f(g)
    @argcheck is_gizmo(g) "Argument does not support the required interface."
    do_stuff(g)
end
~~~

#### chakravala

_My big revelation along these lines recently is to encode some things into type parameters, which can hugely improve performance in some situations.
When I first started, I encoded some Boolean information using BitArray stored in the fields of a type.
However, I later split this single BitArray information off into an integer value (to store the bits) and some type parameters to store some other specialized type information, which I originally tacked onto the end of the BitArray.
Because these last two bits of information were used differently than the other bits to determine program logic for an entire sub-class of objects, encoding them into the type parameters instead helped improve the performance by simplifying the compiled code.
However, I think it was good to first get started with building up a working prototype, which gives me an idea of what kind of program structure was needed, and then to optimize it into better Julia code afterwards, when I had a stronger vision of what the requirements were for making the type system better._

_However, I think there is some kind of balance you want to strike with this, because it is actually better to work out these kinks at the beginning as soon as possible, so that you don’t have to go back and rework a large amount of code.
So, I think when building up your ideas like this, you have to plan ahead a bit and gradually make sure you are satisfied with your initial type setup, so that you don’t have to revisit a large amount of code when you are fixing things with modifications._

_So it is a good idea to start with the type system first, build up things intuitively and conceptually, but to also make sure that as you progress along that you are building up things from a central kernel of basic functions and types which build on each other, and to wait with implementing the outer library which rests on the kernel until later, as you progress and make optimizations to this inner kernel of functionality.
This way, if you think of building things up like this, you can both start with intuitive ideas which you can revise and optimize into a better structure before you are confident to build up the rest of the library API, so that it doesn’t have to be rewritten over and over with breaking changes.
I pretty much agree with all the other points raised here, but I just wanted to add this perspective about an inner kernel and outer library also._

#### ninjaaron

Tamas_Papp
> is_gizmo...

_I was under the impression the establish pattern for traits was something like this:_
~~~julia
abstract type Iteration end
struct HasIterate <: Iteration end
struct NoIterate  <: Iteration end
Iteration(t::Type) = hasmethod(iterate, Tuple{t}) ? HasIterate() : NoIterate()
Iteration(::T) where T = Iteration(T)

somefunc(x) = somefunc(Iterate(x), x)
somefunc(::HasIterate, x) = ...
somefunc(::NoIterate, x) = ...
~~~
_I got that impression from [here](https://docs.julialang.org/en/v1/manual/methods/#Trait-based-dispatch-1), but maybe I’m not doing it right._
