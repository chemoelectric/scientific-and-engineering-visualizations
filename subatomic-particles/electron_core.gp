# Reset environment and enable 2-variable 3D parametric surface plotting
reset
set parametric
set dummy u, v

# Visual styling and layout configuration
set title \
    "Electron Core: Toroidal Field Plasmoid Sheath\n(Perspective View)" \
    font "JohnSansTextPro,18"

# --- RELIABLE PERSPECTIVE CAMERA ---
cam_height = 2.5   # Eye level height above the object
cam_distance = 8.0 # Pushed back from 4.0 to flatten the perspective effect
F = 15.0           # Increased from 4.5 to zoom back in and maintain size
Y_clip = 0.1       # Prevents division by zero

center_offset = 4.5

# 1. Match the gnuplot background to the ImageMagick #f6f8fa hex code
#set object 1 rectangle from screen 0,0 to screen 1,1 \
#    behind fillcolor rgb "#f6f8fa" fillstyle solid noborder

# 2. Make the frame border a thin, matching muted gray
#set border 15 linecolor rgb "#6a737d" linewidth 0.8

# 4. Custom realistic matte pastel palette (Slate Blue to Soft Terracotta)
set palette defined ( 0 '#798e9c', 1 '#c49a88' )

# Simple geometric transformation:
# 1. Rotate around Z to mimic 'view 30' horizontal rotation
alpha = 30.0 * pi / 180.0
rot_x(x,y) = x * cos(alpha) - y * sin(alpha)
rot_y(x,y) = x * sin(alpha) + y * cos(alpha)

# 2. Divide by the depth from the camera, then shift vertically to center
persp_x(x,y,z) = ( (rot_y(x,y) + cam_distance) > Y_clip ) ? ( F * rot_x(x,y) / (rot_y(x,y) + cam_distance) ) : NaN
persp_y(x,y,z) = ( (rot_y(x,y) + cam_distance) > Y_clip ) ? ( F * (z - cam_height) / (rot_y(x,y) + cam_distance) + center_offset ) : NaN

# --- COLOR SYSTEM SETUP ---
# Map palette color to depth (rot_y value). 
# Higher rot_y is further away (back = blue), lower rot_y is closer (front = red).
# We reverse the standard palette setup so low values (front) are red and high values (back) are blue.
set palette defined ( 0 "#E63946", 1 "#457B9D" )

# Flat 2D mapping orientation
set view 0, 0, 1.0, 1.0
set xyplane at 0
unset border
unset tics
unset key
unset colorbox
set hidden3d

set terminal svg size 800, 800 dynamic enhanced font "JohnSansTextPro,12"
set output "electron_core.svg"

# Set sample density for a smooth, clean grid mesh
set samples 50
set isosamples 25
set urange [0:2*pi]
set vrange [0:2*pi]

# Viewport bounds configured to safely hold the projection scale
set xrange [-3.5:3.5]
set yrange [-3.5:3.5]
set zrange [-1:1]

# Geometric parameters for the single electron torus
R = 1.45       # Major radius of the ring
r = 0.25       # Minor radius

# --- Raw 3D Geometry Equations ---
tx(u,v) = (R + r*cos(v)) * cos(u)
ty(u,v) = (R + r*cos(v)) * sin(u)
tz(u,v) = r * sin(v)

# --- Depth-Shaded Projection Render ---
# The 4th argument in the splot line (after the color '0') calculates the 3D depth 
# of the vertex, feeding it straight into the custom palette engine.
splot '++' using (persp_x(tx($1,$2), ty($1,$2), tz($1,$2))): \
                 (persp_y(tx($1,$2), ty($1,$2), tz($1,$2))): \
                 (0): \
                 (rot_y(tx($1,$2), ty($1,$2))) \
      with lines lc palette

set output
