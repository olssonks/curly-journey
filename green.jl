using Random
using StatsBase, Distributions
using LinearAlgebra

mutable struct particlePDF
    tuning_parameters::Dict
    particles::Real
    n_particles::Real
    n_dims::Real
    particle_weights::Real
    just_resampled::Bool

    ##contrustor
    function particlePDF(samples, tuning_parameters)
        ## samples is a tuple of arrays, each of length n_samples
        
        n_particles = length(samples)
        n_dims = size(samples[0]) ## need to check array index to querry
        particles = Matrix{Float64}(undef, n_particles, n_dims)
        for (idx, samps) in enumerate(samples)
            particles[:, idx] = samps
        end

        if weights == nothing
            pdf.particle_weights = ones(pdf.n_particles) ./ pdf.n_particles
        end
    end
end

## might not need this function at all, pdf constructor can do this
function set_pdf(pdf::particlePDF, samples; weights= nothing)
    ## samples is a tuple of arrays, each of length n_samples
    pdf.particles = samples
    pdf.n_particles = length(samples)
    pdf.n_dims = size(samples[0]) ## need to check array index to querry

    if weights == nothing
        pdf.particle_weights = ones(pdf.n_particles) ./ pdf.n_particles
    end
end

function mean(pdf::particlePDF) ## may want to pass OBE object instead
    mean(pdf.particles, 
         weights(pdf.particle_weights), 
         1)
end

function covariance(pdf::particlePDF)
    cov(pdf.particles, 
        AnalyticWeights(pdf.particle_weights), 
        corrected=true)
end

function std(pdf::partialPDF)
    c = covariance(pdf)
    sqrt(Diagonal(c))
end