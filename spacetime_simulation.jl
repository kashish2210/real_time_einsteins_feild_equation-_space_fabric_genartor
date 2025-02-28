using GLMakie, InteractiveUtils, DifferentialEquations

# Define Constants
const G = 6.67430e-11  # Gravitational constant
const c = 3.0e8        # Speed of light

# Schwarzschild Radius Function
function schwarzschild_radius(mass)
    return (2 * G * mass) / (c^2)
end

# Generate Spacetime Curvature Data
function generate_spacetime_data(mass, grid_size=50)
    r_s = schwarzschild_radius(mass)
    x = range(-2*r_s, 2*r_s, length=grid_size)
    y = range(-2*r_s, 2*r_s, length=grid_size)
    z = [r_s / sqrt(1 + (xi^2 + yi^2) / r_s^2) for xi in x, yi in y]
    return x, y, z
end

# Plot the 3D Spacetime Bending
function plot_spacetime_bending(mass)
    x, y, z = generate_spacetime_data(mass)
    fig = Figure(resolution = (800, 600))
    ax = Axis3(fig[1,1], title = "Spacetime Bending due to Mass", aspect=:data)
    surface!(ax, x, y, z, colormap = :viridis)
    return fig
end

# Interactive User Input
function interactive_spacetime()
    mass = parse(Float64, readline(stdin))  # User enters mass
    fig = plot_spacetime_bending(mass)
    display(fig)
end

println("Enter Mass of Object (in kg) to visualize Spacetime Bending:")
interactive_spacetime()
