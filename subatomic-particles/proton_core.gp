# Reset environment and enable 2-variable 3D parametric surface plotting
reset
set parametric
set dummy u, v

# Visual styling and layout configuration
set title \
    "Proton Core: Orthogonal Toroidal Field Plasmoids\n(Orthographic Projection)" \
    font "JohnSansTextPro,18"
set view 60, 30, 1.3, 1.0     # Optimized 3D angle view
set xyplane at 0
set grid
unset border
unset tics
unset key                     # Hide legends since coloring represents the components
set hidden3d                  # Critical for proper 3D surface occlusion/depth sorting

set terminal svg size 800, 800 dynamic enhanced font "JohnSansTextPro,12"
set output "proton_core.svg"

# Set sample density for a smooth, clean grid mesh
set isosamples 40, 20
set urange [0:2*pi]
set vrange [0:2*pi]

# Ensure equal 1:1:1 scale proportions to avoid spatial distortion
set xrange [-2.2:2.2]
set yrange [-2.2:2.2]
set zrange [-2.2:2.2]

# Geometric parameters for the toroidal knots
R = 1.45       # Major radius of each ring
r = 0.16       # Minor radius (thickness) of the field sheath tube
d = 0.55       # Axial displacement offset for spatial interlocking

# --- Torus 1: Oriented parallel to the XY plane (Red field) ---
x1(u,v) = (R + r*cos(v)) * cos(u)
y1(u,v) = (R + r*cos(v)) * sin(u)
z1(u,v) = r * sin(v) + d

# --- Torus 2: Oriented parallel to the YZ plane (Green field) ---
x2(u,v) = r * sin(v) + d
y2(u,v) = (R + r*cos(v)) * cos(u)
z2(u,v) = (R + r*cos(v)) * sin(u)

# --- Torus 3: Oriented parallel to the ZX plane (Blue field) ---
x3(u,v) = (R + r*cos(v)) * sin(u)
y3(u,v) = r * sin(v) + d
z3(u,v) = (R + r*cos(v)) * cos(u)

# Plot all three 3D field shells with distinct line colors
splot x1(u,v), y1(u,v), z1(u,v) with lines lc rgb "#D62828", \
      x2(u,v), y2(u,v), z2(u,v) with lines lc rgb "#2A9D8F", \
      x3(u,v), y3(u,v), z3(u,v) with lines lc rgb "#1D3557"

set output
