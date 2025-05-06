using ManifoldDistributions
using Documenter

DocMeta.setdocmeta!(ManifoldDistributions, :DocTestSetup, :(using ManifoldDistributions); recursive=true)

makedocs(;
    modules=[ManifoldDistributions],
    authors="Seth Axen <seth@sethaxen.com> and contributors",
    sitename="ManifoldDistributions.jl",
    format=Documenter.HTML(;
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
