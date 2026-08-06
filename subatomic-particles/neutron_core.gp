# Reset environment and enable 2-variable 3D parametric surface plotting
reset
set parametric
set dummy u, v

# Visual styling and layout configuration
set title \
    "Neutron Core: Concentric Orthogonal Field Matrix\n(Orthographic Projection)" \
    font "JohnSansTextPro,18"
set view 60, 30, 1.3, 1.0     # Optimized 3D angle view
set xyplane at 0
set grid
unset border
unset tics
unset key                     
set hidden3d                  

set terminal svg size 800, 800 dynamic enhanced font "JohnSansTextPro,12"
set output "neutron_core.svg"

# Set sample density for a smooth, clean grid mesh
set isosamples 40, 20
set urange [0:2*pi]
set vrange [0:2*pi]

# Ensure equal 1:1:1 scale proportions to avoid spatial distortion
set xrange [-2.2:2.2]
set yrange [-2.2:2.2]
set zrange [-2.2:2.2]

# Geometric parameters (d=0 handles the unshifted concentric alignment)
R = 1.45       # Major radius of each ring
r = 0.16       # Minor radius of the field sheath tube

# --- Torus 1: Parallel to XY plane ---
x1(u,v) = (R + r*cos(v)) * cos(u)
y1(u,v) = (R + r*cos(v)) * sin(u)
z1(u,v) = r * sin(v)

# --- Torus 2: Parallel to YZ plane ---
x2(u,v) = r * sin(v)
y2(u,v) = (R + r*cos(v)) * cos(u)
z2(u,v) = (R + r*cos(v)) * sin(u)

# --- Torus 3: Parallel to ZX plane ---
x3(u,v) = (R + r*cos(v)) * sin(u)
y3(u,v) = r * sin(v)
z3(u,v) = (R + r*cos(v)) * cos(u)

# Plot all three concentric shells using a neutral palette (Muted Orange, Amber, and Slate Grey)
splot x1(u,v), y1(u,v), z1(u,v) with lines lc rgb "#E07A5F", \
      x2(u,v), y2(u,v), z2(u,v) with lines lc rgb "#F4A261", \
      x3(u,v), y3(u,v), z3(u,v) with lines lc rgb "#4A4E69"

set output
