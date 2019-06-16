---
layout: post
title: How to create and use Julia environments
description: "A short guide on using Julia environments."
modified: 2019-01-16
tags: [julia, development, packages]
categories: [julia]
---

This is a really short guide on how to create and use your own or others environments.
This is a shortlist of the official [Pkg documentation](https://docs.julialang.org/en/v1/stdlib/Pkg/).

## Create a new environment

~~~shell
shell> mkdir MyProject

shell> cd MyProject
/Users/cstamas/MyProject

(v1.0) pkg> activate .

(MyProject) pkg> st
   Status `Project.toml`
~~~

Latter is equivalent to `using Pkg; Pkg.activate(".")`.

## Use an environment

This must be called before every use of this environment.
Use `pwd()` to determine if you're in a good folder.
~~~shell
(v1.0) pkg> activate .
~~~

## Use someone else's project

Simply clone their project using e.g. `git clone`, `cd` to the project directory and call
~~~shell
(v1.0) pkg> activate .

(SomeProject) pkg> instantiate
~~~
It will install the desired packages, that are in the that manifest.
