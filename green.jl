mutable struct particlePDF
    tuning_parameters
    particles
    n_particles
    n_dims
    particle_weights
    just_resampled

    ##contrustor
    function particlePDF()
        ## needs to set up struct attributes
    end
end

function set_pdf(pdf::particlePDF, samples; weights= nothing)
    pdf.particles = samples
    pdf.n_particles = size(sample, 2)
    pdf.n_dims = size(samples, 1) ## need to check array index to querry

    if weights == nothing
        pdf.particle_weights = ones(pdf.n_particles) ./ pdf.n_particles
    end
end