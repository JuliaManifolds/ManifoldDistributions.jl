#!/usr/bin/env julia
#
#

if "--help" ∈ ARGS
    println(
        """
docs/make.jl

Render the `ManifoldDistributions.jl` documentation with optional arguments

Arguments
* `--help`              - print this help and exit without rendering the documentation
* `--prettyurls`        – toggle the pretty urls part to true, which is always set on CI
"""
    )
    exit(0)
end
run_on_CI = (get(ENV, "CI", nothing) == "true")

# On CI we activate this folders env anyways, but let's also do that here
if Base.active_project() != joinpath(@__DIR__, "Project.toml")
    using Pkg
    Pkg.activate(@__DIR__)
    Pkg.instantiate()
end


using ManifoldDistributions
using Documenter, DocumenterInterLinks, DocumenterCitations

DocMeta.setdocmeta!(
    ManifoldDistributions, :DocTestSetup, :(using ManifoldDistributions); recursive=true
)

bib = CitationBibliography(joinpath(@__DIR__, "src", "references.bib"); style=:alpha)
links = InterLinks(
    "ManifoldsBase" => ("https://juliamanifolds.github.io/ManifoldsBase.jl/stable/"),
    "Manifolds" => ("https://juliamanifolds.github.io/Manifolds.jl/stable/"),
)

makedocs(;
    modules=[ManifoldDistributions],
    authors="Seth Axen <seth@sethaxen.com> and contributors",
    sitename="ManifoldDistributions.jl",
    format=Documenter.HTML(;
        edit_link="main", assets=String[], prettyurls=run_on_CI || ("--prettyurls" ∈ ARGS)
    ),
    pages=["Home" => "index.md"],
    plugins=[bib, links],
)
deploydocs(; repo="github.com/JuliaManifolds/ManifoldDistributions.jl", push_preview=true)
