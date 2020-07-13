include <../NopSCADlib/lib.scad>
include <../vitamins/drives.scad>

// ssd = SSD_2_5;
hdd = HDD_3_5;

number_of_hdds = 2;
drive_stack_spacing = 10;
top_thickness = 10;                 // TODO: Evaluate this for heat set inserts
bottom_thickness = top_thickness;
side_thickness = 10;                // TODO: Evaluate for screw lengths
drive_clearance = 1;
grab_slot_radius = 7;

function drive_cage_height() = (drive_height(hdd) * number_of_hdds)
                    + (drive_stack_spacing * (number_of_hdds - 1))
                    + top_thickness + bottom_thickness;
function drive_cage_length() = drive_length(hdd) + side_thickness;
function drive_cage_width() = drive_width(hdd) + (side_thickness * 2);

module drive_mount_stl() {
    stl("drive_mount");

    difference() {
        // Base material
        cube([drive_cage_length(), drive_cage_width(), drive_cage_height()]);
        // Material to be removed
        union() {
            drive_hollow();
            side_mounting_holes_tracks();
            grab_slot();
        }
    }

}

module drive_hollow() {
    union()
        for (i = [0:number_of_hdds-1]) {
            translate([0, side_thickness, bottom_thickness + ((drive_height(hdd) + drive_stack_spacing) * i)])
                scale([1, 1.01, 1.01])
                    cube([drive_length(hdd) + side_thickness * 2, drive_width(hdd), drive_height(hdd)]);
        }
}

module side_mounting_holes_tracks() {
    // Get the mounting hole vertical offset
    mounting_hole_height_offest = drive_side_mounting_holes(hdd)[0][1];

    for (i = [0:number_of_hdds-1]) {
        // Drive width + width of material on both sides
        width = drive_width(hdd) + (side_thickness * 2);
        // Base offset for aligning with side mounting holes + offset for each stacked drive
        height = (bottom_thickness + mounting_hole_height_offest) + ((drive_height(hdd) + drive_stack_spacing) * i);
        start_x_offset =  side_thickness;
        end_x_offset = start_x_offset + drive_length(hdd) - side_thickness;

        radius = drive_mounting_hole_radius(hdd) * 1.5;

        hull() {
            translate([start_x_offset, width / 2, height])
                rotate([90, 0, 0])
                    cylinder(r=radius, h=width, center=true);
            translate([end_x_offset, width / 2, height])
                rotate([90, 0, 0])
                    cylinder(r=radius, h=width, center=true);
        }
    }
}

module grab_slot() {
    height = drive_cage_height();
    x_offset = drive_cage_length() + (grab_slot_radius * 0.25);
    y_offset = drive_cage_width() / 2;

    hull() {
        translate([x_offset, y_offset, height])
            sphere(r=grab_slot_radius);
        translate([x_offset, y_offset, 0])
            sphere(r=grab_slot_radius);
    }
}

module draw_hdds() {
    for (i = [0:number_of_hdds-1]) {
        translate([side_thickness, side_thickness, bottom_thickness + ((drive_height(hdd) + drive_stack_spacing) * i)])
            drive(hdd);
    }
}

module drive_assembly()
assembly("drives") {
    draw_hdds();
    render()
        drive_mount_stl();
}

if ($preview)
    drive_assembly();
