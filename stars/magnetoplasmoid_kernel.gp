# Set terminal to output clean, scalable SVG vector graphics
set terminal svg size 800,800 font 'MaiolaPro,16' dynamic rounded
set output 'magnetoplasmoid_kernel.svg'

# Enhanced 3D plotting options
set title \
    "Ultra-Dense Non-Singular Magnetoplasmoid Field Kernel\n{/*0.8 Toroidal Core and Extended Field Envelope Matrix}" \
    font "MaiolaPro,20"
set parametric
set isosamples 60, 40
set hidden3d back offset 1 trianglepattern 3 undefined 1 altdiagonal #polyquads
set view 60, 125, 1.2, 1.0

# Remove axis lines and grid to isolate the field topology mapping
unset xtics
unset ytics
unset ztics
unset border
set xyplane at 0

# Define Palette mimicking high-energy plasmoid radiation (Deep Blue -> Magenta -> Neon Orange)
set palette defined ( 0 '#05002b', 0.2 '#110066', 0.4 '#5500aa', 0.6 '#aa00aa', 0.8 '#ff0055', 1.0 '#ffaa00' )
set pm3d depthorder explicit at s

# Toroidal geometry parameters
R = 3.0    # Major radius of the kernel sheath structure
r_0 = 1.0  # Minor radius base multiplier

# Multi-layered field function mapping mapping: Core Density (u) -> Envelope Gradient
# Represents: u(x) = 0.5 * (eps_0*E^2 + mu_0^-1*B^2) interference patterns
sinc(x) = (x == 0) ? 1.0 : sin(x)/x
density(u, v) = (cos(v)**4) * (1.2 + 0.8 * sin(3*u))

# Parametric equations defining the self-trapped circulating field lines
x(u, v) = (R + r_0 * (1.0 + 0.3 * density(u, v)) * cos(v)) * cos(u)
y(u, v) = (R + r_0 * (1.0 + 0.3 * density(u, v)) * cos(v)) * sin(u)
z(u, v) = r_0 * (1.0 + 0.3 * density(u, v)) * sin(v) + 0.4 * cos(3*u)

# Boundaries for full toroidal angular closure (0 to 2*pi)
set urange [0:2*pi]
set vrange [0:2*pi]

# Main splot command generating the color-mapped field density matrix
splot x(u,v), y(u,v), z(u,v) with pm3d \
      title "Field Mass\nDensity (u)"
