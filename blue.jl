module OBE_base
using Random
using StatsBase, Distributions
using LinearAlgebra

include("green.jl")

mutable struct optbayesexpt
    pdf:: particlePDF


end