include <NopSCADlib/lib.scad>
use <parts/psu-mount.scad>
use <parts/drive-mount.scad>
include <vitamins/motherboards.scad>

motherboard_type = ATX;

show_mother_board = true;
show_psu_assembly = true;
show_drive_assembly = true;

//! TODO: Assembly instructions
module main_assembly()
assembly("main") {
    if (show_mother_board)
        translate([0, 0, psu_mount_height() + 10])
            motherboard(motherboard_type);
    if (show_psu_assembly)
        translate([0, motherboard_length(motherboard_type), 0])
            rotate(-90)
                psu_assembly();
    if (show_drive_assembly)
        translate([drive_cage_length(), drive_cage_width(), 0])
            rotate(180)
                drive_assembly();
}

if($preview)
    main_assembly();
